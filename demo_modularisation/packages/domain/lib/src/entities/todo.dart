import 'package:equatable/equatable.dart';

/// Entité représentant une tâche
class Todo extends Equatable {
  final String id;
  final String userId;
  final String title;
  final String? description;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime? completedAt;
  
  const Todo({
    required this.id,
    required this.userId,
    required this.title,
    this.description,
    required this.isCompleted,
    required this.createdAt,
    this.completedAt,
  });
  
  @override
  List<Object?> get props => [
        id,
        userId,
        title,
        description,
        isCompleted,
        createdAt,
        completedAt,
      ];
  
  /// Copie avec modification
  Todo copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? completedAt,
  }) {
    return Todo(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }
  
  @override
  String toString() => 'Todo(id: $id, title: $title, isCompleted: $isCompleted)';
}

