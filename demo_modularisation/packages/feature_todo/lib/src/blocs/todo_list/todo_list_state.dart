part of 'todo_list_bloc.dart';

/// État du TodoListBloc
enum TodoListStatus { initial, loading, success, failure }

class TodoListState extends Equatable {
  final TodoListStatus status;
  final List<Todo> todos;
  final String? errorMessage;
  
  const TodoListState({
    this.status = TodoListStatus.initial,
    this.todos = const [],
    this.errorMessage,
  });
  
  TodoListState copyWith({
    TodoListStatus? status,
    List<Todo>? todos,
    String? errorMessage,
  }) {
    return TodoListState(
      status: status ?? this.status,
      todos: todos ?? this.todos,
      errorMessage: errorMessage,
    );
  }
  
  @override
  List<Object?> get props => [status, todos, errorMessage];
}

