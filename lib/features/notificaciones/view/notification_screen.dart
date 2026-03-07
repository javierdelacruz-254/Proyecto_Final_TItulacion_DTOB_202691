import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:lactaamor/features/notificaciones/repository/notification_repository_impl.dart';
import 'package:lactaamor/features/notificaciones/viewmodel/notification_viewmodel.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authViewModelProvider);
    final userId = authState.user?.uid;

    if (userId == null) return const SizedBox.shrink();

    ref
        .read(notificationsViewModelProvider.notifier)
        .listenNotifications(userId);

    final stream = NotificationRepositoryImpl().getNotifications(userId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificaciones'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: () => NotificationRepositoryImpl().deleteAll(userId),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return const Center(child: Text('No hay notificaciones'));
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final doc = docs[index];
              final data = doc.data() as Map<String, dynamic>;
              return ListTile(
                title: Text(data['title'] ?? ''),
                subtitle: Text(data['body'] ?? ''),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () =>
                      NotificationRepositoryImpl().deleteNotification(doc.id),
                ),
                tileColor: data['read'] ? Colors.grey[200] : Colors.white,
                onTap: () => NotificationRepositoryImpl().markAsRead(doc.id),
              );
            },
          );
        },
      ),
    );
  }
}
