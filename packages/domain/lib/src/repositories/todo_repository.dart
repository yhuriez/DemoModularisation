import 'package:common/common.dart';
import '../entities/todo.dart';

/// Interface du repository de todos
abstract class TodoRepository {
  /// Récupération de tous les todos d'un utilisateur
  Future<Result<List<Todo>>> getTodos(String userId);
  
  /// Récupération d'un todo par son ID
  Future<Result<Todo>> getTodoById(String id);
  
  /// Création d'un nouveau todo
  Future<Result<Todo>> createTodo({
    required String userId,
    required String title,
    String? description,
  });
  
  /// Mise à jour d'un todo
  Future<Result<Todo>> updateTodo(Todo todo);
  
  /// Suppression d'un todo
  Future<Result<void>> deleteTodo(String id);
  
  /// Basculer le statut de complétion d'un todo
  Future<Result<Todo>> toggleTodoCompletion(String id);
}

