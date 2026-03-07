import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

abstract class NotificationRepository {
  Future<void> saveNotification(RemoteMessage message);

  Stream<QuerySnapshot> getNotifications(String userId);

  Future<void> markAsRead(String docId);

  Future<void> deleteNotification(String docId);

  Future<void> deleteAll(String userId);
}
