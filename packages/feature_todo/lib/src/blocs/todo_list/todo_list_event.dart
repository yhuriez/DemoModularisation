part of 'todo_list_bloc.dart';

/// Événements du TodoListBloc
@freezed
class TodoListEvent with _$TodoListEvent {
  /// Événement pour charger la liste des todos
  const factory TodoListEvent.loaded() = TodoListLoaded;
  
  /// Événement pour basculer le statut d'un todo
  const factory TodoListEvent.toggled(String todoId) = TodoToggled;
  
  /// Événement pour ajouter un nouveau todo
  const factory TodoListEvent.added({
    required String title,
    String? description,
  }) = TodoAdded;
  
  /// Événement pour supprimer un todo
  const factory TodoListEvent.deleted(String todoId) = TodoDeleted;
}

