import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_model.freezed.dart';
part 'todo_model.g.dart';

/// Modèle de données pour les todos
@freezed
class TodoModel with _$TodoModel {
  const TodoModel._();
  
  const factory TodoModel({
    required String id,
    required String userId,
    required String title,
    String? description,
    required bool isCompleted,
    required DateTime createdAt,
    DateTime? completedAt,
  }) = _TodoModel;
  
  /// Conversion depuis JSON
  factory TodoModel.fromJson(Map<String, dynamic> json) => _$TodoModelFromJson(json);
  
  /// Conversion vers l'entité domain
  Todo toEntity() {
    return Todo(
      id: id,
      userId: userId,
      title: title,
      description: description,
      isCompleted: isCompleted,
      createdAt: createdAt,
      completedAt: completedAt,
    );
  }
  
  /// Création depuis l'entité domain
  factory TodoModel.fromEntity(Todo todo) {
    return TodoModel(
      id: todo.id,
      userId: todo.userId,
      title: todo.title,
      description: todo.description,
      isCompleted: todo.isCompleted,
      createdAt: todo.createdAt,
      completedAt: todo.completedAt,
    );
  }
}

