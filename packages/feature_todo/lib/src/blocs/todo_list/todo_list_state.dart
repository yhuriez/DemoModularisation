part of 'todo_list_bloc.dart';

/// État du TodoListBloc
enum TodoListStatus { initial, loading, success, failure }

@freezed
class TodoListState with _$TodoListState {
  const factory TodoListState({
    @Default(TodoListStatus.initial) TodoListStatus status,
    @Default([]) List<Todo> todos,
    String? errorMessage,
  }) = _TodoListState;
}

