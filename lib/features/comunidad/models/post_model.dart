import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String id;
  final String userId;
  final String userName;
  final bool haDadoLuz;
  final DateTime? fechaReferencia;
  final String contenido;
  final List<String> tags;

  final List<String> likes;
  final List<String> commentsIds;

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
    required this.likes,
    required this.commentsIds,
    required this.likesCount,
    required this.commentsCount,
    required this.createdAt,
  });

  factory PostModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return PostModel(
      id: doc.id,
      userId: data['user_id'] ?? '',
      userName: data['user_name'] ?? '',
      haDadoLuz: data['haDadoLuz'] ?? false,
      fechaReferencia: data['fechaReferencia'] != null
          ? (data['fechaReferencia'] as Timestamp).toDate()
          : null,
      contenido: data['contenido'] ?? '',
      tags: List<String>.from(data['tags'] ?? []),
      likes: data['likes'] != null ? List<String>.from(data['likes']) : [],

      commentsIds: data['comments_ids'] != null
          ? List<String>.from(data['comments_ids'])
          : [],
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

  String get tiempoFormateado {
    if (fechaReferencia == null) return "";

    final diasTotales = DateTime.now().difference(fechaReferencia!).inDays;
    final meses = diasTotales ~/ 30;

    if (meses <= 0) {
      return "menos de 1 mes";
    }

    return "$meses mes${meses > 1 ? 'es' : ''}";
  }

  bool isLikedBy(String userId) {
    return likes.contains(userId);
  }
}
