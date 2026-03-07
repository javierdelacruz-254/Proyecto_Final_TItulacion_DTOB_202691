import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/features/notificaciones/models/notification_model.dart';
import 'package:lactaamor/features/notificaciones/repository/notification_repository_impl.dart';

final notificationsViewModelProvider =
    StateNotifierProvider<
      NotificationViewmodel,
      AsyncValue<List<NotificationModel>>
    >((ref) => NotificationViewmodel(ref));

class NotificationViewmodel
    extends StateNotifier<AsyncValue<List<NotificationModel>>> {
  final Ref ref;
  final NotificationRepositoryImpl _repo = NotificationRepositoryImpl();
  StreamSubscription? _subscription;

  NotificationViewmodel(this.ref) : super(const AsyncValue.loading());

  void listenNotifications(String userId) {
    _subscription?.cancel();
    _subscription = _repo.getNotifications(userId).listen((snapshot) {
      final list = snapshot.docs
          .map((doc) => NotificationModel.fromDoc(doc))
          .toList();
      state = AsyncValue.data(list);
    });
  }

  Future<void> markAsRead(String docId) async {
    await _repo.markAsRead(docId);
  }

  Future<void> deleteNotification(String docId) async {
    await _repo.deleteNotification(docId);
  }

  Future<void> deleteAll(String userId) async {
    await _repo.deleteAll(userId);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
