import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String id;
  final String userId;
  final String userName;
  final bool haDadoLuz;
  final DateTime? fechaReferencia;
  final String contenido;
  final List<String> tags;
  final int likesCount;
  final int commentsCount;
  final DateTime createdAt;

  PostModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.haDadoLuz,
    this.fechaReferencia,
    required this.contenido,
    required this.tags,
    required this.likesCount,
    required this.commentsCount,
    required this.createdAt,
  });

  factory PostModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return PostModel(
      id: doc.id,
      userId: data['user_id'],
      userName: data['user_name'],
      haDadoLuz: data['haDadoLuz'],
      fechaReferencia: data['fechaReferencia'] != null
          ? (data['fechaReferencia'] as Timestamp).toDate()
          : null,
      contenido: data['contenido'],
      tags: List<String>.from(data['tags'] ?? []),
      likesCount: data['likes_count'] ?? 0,
      commentsCount: data['comments_count'] ?? 0,
      createdAt: (data['created_at'] as Timestamp).toDate(),
    );
  }

  int get semanas {
    if (fechaReferencia == null) return 0;
    return DateTime.now().difference(fechaReferencia!).inDays ~/ 7;
  }

  int get dias {
    if (fechaReferencia == null) return 0;
    return DateTime.now().difference(fechaReferencia!).inDays;
  }
}
