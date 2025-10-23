import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

part 'todo_list_event.dart';
part 'todo_list_state.dart';

/// Bloc de gestion de la liste des todos
class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  TodoListBloc() : super(const TodoListState()) {
    on<TodoListLoaded>(_onLoaded);
    on<TodoToggled>(_onToggled);
    on<TodoAdded>(_onAdded);
    on<TodoDeleted>(_onDeleted);
  }
  
  /// Chargement de la liste des todos
  Future<void> _onLoaded(
    TodoListLoaded event,
    Emitter<TodoListState> emit,
  ) async {
    emit(state.copyWith(status: TodoListStatus.loading));
    
    try {
      // Pour l'instant, on retourne une liste vide
      // À terme, on utilisera un use case pour récupérer les todos
      await Future.delayed(const Duration(milliseconds: 500));
      emit(state.copyWith(
        status: TodoListStatus.success,
        todos: [],
      ));
    } catch (e) {
      emit(state.copyWith(
        status: TodoListStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
  
  /// Basculer le statut d'un todo
  Future<void> _onToggled(
    TodoToggled event,
    Emitter<TodoListState> emit,
  ) async {
    final updatedTodos = state.todos.map((todo) {
      if (todo.id == event.todoId) {
        return todo.copyWith(
          isCompleted: !todo.isCompleted,
          completedAt: !todo.isCompleted ? DateTime.now() : null,
        );
      }
      return todo;
    }).toList();
    
    emit(state.copyWith(todos: updatedTodos));
  }
  
  /// Ajouter un nouveau todo
  Future<void> _onAdded(
    TodoAdded event,
    Emitter<TodoListState> emit,
  ) async {
    final newTodo = Todo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: 'current-user', // À remplacer par l'ID de l'utilisateur courant
      title: event.title,
      description: event.description,
      isCompleted: false,
      createdAt: DateTime.now(),
    );
    
    final updatedTodos = [...state.todos, newTodo];
    emit(state.copyWith(todos: updatedTodos));
  }
  
  /// Supprimer un todo
  Future<void> _onDeleted(
    TodoDeleted event,
    Emitter<TodoListState> emit,
  ) async {
    final updatedTodos = state.todos
        .where((todo) => todo.id != event.todoId)
        .toList();
    
    emit(state.copyWith(todos: updatedTodos));
  }
}

