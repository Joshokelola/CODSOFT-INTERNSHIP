import 'package:objectbox/objectbox.dart';

import '../domain/todo.dart';
import 'todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final Box<TodoTask> box;

  TodoRepositoryImpl(this.box);

  @override
  Future<void> addTodo(TodoTask todo) async {
    box.put(todo);
  }

  @override
  Future<void> deleteTodo(int id) async {
    box.remove(id);
  }

  @override
  Future<void> updateTodo(TodoTask todo) async {
    box.put(todo);
  }

  @override
  Future<TodoTask?> getTodo(int id) async {
    return box.get(id);
  }

  @override
  Stream<List<TodoTask>> watchTodos() {
    return box
        .query()
        .watch(triggerImmediately: true)
        .map((query) => query.find());
  }

  /// Sorting by due date (earliest first)
  @override
  Future<List<TodoTask>> getTodosSortedByDueDate() async {
    final todos = box.getAll();
    todos.sort((a, b) => (a.dueDate ?? DateTime.now())
        .compareTo(b.dueDate ?? DateTime.now()));
    return todos;
  }

  /// Sorting by priority (highest priority first)
  @override
  Future<List<TodoTask>> getTodosSortedByPriority() async {
    final todos = box.getAll();
    todos.sort((a, b) => b.priority.compareTo(a.priority));
    return todos;
  }

  /// Sorting by completion status (incomplete tasks first)
  @override
  Future<List<TodoTask>> getTodosSortedByCompletionStatus() async {
    final todos = box.getAll();
    todos.sort((a, b) => a.isCompleted.toString().compareTo(b.isCompleted.toString()));
    return todos;
  }

  /// Sorting alphabetically by title
  @override
  Future<List<TodoTask>> getTodosSortedByTitle() async {
    final todos = box.getAll();
    todos.sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
    return todos;
  }

  /// Combined sorting: by completion status, priority, and then due date
  @override
  Future<List<TodoTask>> getTodosSortedByCombined() async {
    final todos = box.getAll();
    todos.sort((a, b) {
      int statusComparison = a.isCompleted.toString().compareTo(b.isCompleted.toString());
      if (statusComparison != 0) return statusComparison;

      int priorityComparison = b.priority.compareTo(a.priority);
      if (priorityComparison != 0) return priorityComparison;

      return (a.dueDate ?? DateTime.now()).compareTo(b.dueDate ?? DateTime.now());
    });
    return todos;
  }

  /// Sorting by ID (insertion order)
  @override
  Future<List<TodoTask>> getTodosSortedById() async {
    final todos = box.getAll();
    todos.sort((a, b) => (a.id ?? 0).compareTo(b.id ?? 0));
    return todos;
  }

  /// Custom sorting using a comparator function
  @override
  Future<List<TodoTask>> getTodosCustomSorted(
      int Function(TodoTask a, TodoTask b) comparator) async {
    final todos = box.getAll();
    todos.sort(comparator);
    return todos;
  }
}
