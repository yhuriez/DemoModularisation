part of 'todo_list_bloc.dart';

/// Événements du TodoListBloc
abstract class TodoListEvent extends Equatable {
  const TodoListEvent();
  
  @override
  List<Object> get props => [];
}

/// Événement pour charger la liste des todos
class TodoListLoaded extends TodoListEvent {
  const TodoListLoaded();
}

/// Événement pour basculer le statut d'un todo
class TodoToggled extends TodoListEvent {
  final String todoId;
  
  const TodoToggled(this.todoId);
  
  @override
  List<Object> get props => [todoId];
}

/// Événement pour ajouter un nouveau todo
class TodoAdded extends TodoListEvent {
  final String title;
  final String? description;
  
  const TodoAdded({
    required this.title,
    this.description,
  });
  
  @override
  List<Object> get props => [title];
}

/// Événement pour supprimer un todo
class TodoDeleted extends TodoListEvent {
  final String todoId;
  
  const TodoDeleted(this.todoId);
  
  @override
  List<Object> get props => [todoId];
}

