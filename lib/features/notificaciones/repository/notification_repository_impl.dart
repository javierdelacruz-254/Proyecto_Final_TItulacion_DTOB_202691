import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging_platform_interface/src/remote_message.dart';
import 'package:lactaamor/features/notificaciones/repository/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final CollectionReference _collection = FirebaseFirestore.instance.collection(
    "notifications",
  );
  @override
  Future<void> deleteAll(String userId) async {
    final snapshot = await _collection.where('userId', isEqualTo: userId).get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }

  @override
  Future<void> deleteNotification(String docId) async {
    await _collection.doc(docId).delete();
  }

  @override
  Stream<QuerySnapshot<Object?>> getNotifications(String userId) {
    return _collection
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  @override
  Future<void> markAsRead(String docId) async {
    await _collection.doc(docId).update({'read': true});
  }

  @override
  Future<void> saveNotification(RemoteMessage message, {String? userId}) async {
    await _collection.add({
      'userId': userId ?? 'general',
      'title': message.notification?.title ?? '',
      'body': message.notification?.body ?? '',
      'data': message.data,
      'read': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
