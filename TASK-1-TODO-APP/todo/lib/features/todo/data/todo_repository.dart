import '../domain/todo.dart';

abstract class TodoRepository {
  Future<void> addTodo(TodoTask todo);
  Future<void> deleteTodo(int id);
  Future<void> updateTodo(TodoTask todo);
  Future<TodoTask?> getTodo(int id);
  Stream<List<TodoTask>> watchTodos();
  Future<List<TodoTask>> getTodosSortedByDueDate();
  Future<List<TodoTask>> getTodosSortedByPriority();
  Future<List<TodoTask>> getTodosSortedByCompletionStatus();
  Future<List<TodoTask>> getTodosSortedByTitle();
  Future<List<TodoTask>> getTodosSortedByCombined();
  Future<List<TodoTask>> getTodosSortedById();
  Future<List<TodoTask>> getTodosCustomSorted(
      int Function(TodoTask a, TodoTask b) comparator);
}
