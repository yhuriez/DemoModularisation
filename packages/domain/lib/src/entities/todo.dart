import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';

/// Entité représentant une tâche
@freezed
class Todo with _$Todo {
  const factory Todo({
    required String id,
    required String userId,
    required String title,
    String? description,
    required bool isCompleted,
    required DateTime createdAt,
    DateTime? completedAt,
  }) = _Todo;
}

