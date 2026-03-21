import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:lactaamor/features/notificaciones/repository/notification_repository_impl.dart';

class PushNotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize({String? userId}) async {
    if (Platform.isIOS) {
      await _messaging.requestPermission(alert: true, badge: true, sound: true);
      if (Platform.isAndroid) {
        final status = await _messaging.requestPermission(
          alert: true,
          badge: true,
          sound: true,
        );
        print('🔹 Permisos Android: $status');
      }
    }

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'Este canal se usa para notificaciones importantes',
      importance: Importance.high,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );

    await _localNotifications.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        print('Notificación tocada: ${details.payload}');
      },
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('📩 Notificación recibida: ${message.data}');
      print('📩 Notificación notification: ${message.notification}');
      _showNotification(message);

      if (userId != null) {
        await NotificationRepositoryImpl().saveNotification(
          message,
          userId: userId,
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('🚀 Notificación abierta: ${message.data}');
    });

    final token = await _messaging.getToken();
    print('🔑 FCM Token: $token');

    if (userId != null && token != null) {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'fcmToken': token,
      });
    }
  }

  static Future<void> _showNotification(RemoteMessage message) async {
    print('🔹 _showNotification iniciado');

    final notification = message.notification;
    if (notification == null) {
      print('⚠️ No hay "notification" en el mensaje');
      return;
    }
    print(
      '🔹 Notification encontrada: title=${notification.title}, body=${notification.body}',
    );

    final androidDetails = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: 'Este canal se usa para notificaciones importantes',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );
    print('🔹 AndroidNotificationDetails creado');

    final iosDetails = DarwinNotificationDetails();
    print('🔹 DarwinNotificationDetails creado');

    final platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    print('🔹 NotificationDetails creado');

    try {
      await _localNotifications.show(
        id: notification.hashCode,
        title: notification.title,
        body: notification.body,
        notificationDetails: platformDetails,
        payload: message.data['screen'],
      );
      print('✅ Notificación mostrada con éxito');
    } catch (e, st) {
      print('❌ Error mostrando notificación: $e');
      print(st);
    }
  }

  static Future<void> sendPushNotification({
    required String fcmToken,
    required String title,
    required String body,
    Map<String, String>? data,
  }) async {
    try {
      final url = Uri.parse(
        'https://paneladmin.fulventas.com/private/enviar_notificacion_firebase.php',
      );

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'fcmToken': fcmToken,
          'title': title,
          'body': body,
          'data': data ?? {},
        }),
      );

      if (response.statusCode == 200) {
        print('✅ Notificación enviada correctamente');
      } else {
        print('❌ Error al enviar notificación: ${response.body}');
      }
    } catch (e, st) {
      print('❌ Exception en sendPushNotification: $e');
      print(st);
    }
  }
}
