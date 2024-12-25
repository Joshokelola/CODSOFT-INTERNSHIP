// todo_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/todo/data/todo_repository.dart';
import '../../features/todo/data/todo_repository_impl.dart';
import '../../features/todo/domain/todo.dart';
import '../services/db.dart';

part 'todo_providers.g.dart';
@riverpod
TodoRepository todoRepository(Ref ref) {
  final box = ref.watch(objectBoxProvider).box;
  return TodoRepositoryImpl(box);
}
@riverpod
class TodoNotifier extends _$TodoNotifier {
  // The current sorting method
  String _currentSortMethod = 'Default';

  @override
  Stream<List<TodoTask>> build() {
    final repository = ref.watch(todoRepositoryProvider);
    return repository.watchTodos().map((tasks) {
      return _sortTasks(tasks);
    });
  }

  // Method to update the sorting method
  void setSortMethod(String sortMethod) {
    _currentSortMethod = sortMethod;
    state = AsyncValue.data(_sortTasks(state.value ?? []));
  }

  // Helper method to sort tasks based on the current sorting method
  List<TodoTask> _sortTasks(List<TodoTask> tasks) {
    switch (_currentSortMethod) {
      case 'Due Date':
        tasks.sort((a, b) => (a.dueDate ?? DateTime.now())
            .compareTo(b.dueDate ?? DateTime.now()));
        break;
      case 'Priority':
        tasks.sort((a, b) => b.priority.compareTo(a.priority));
        break;
      case 'Completion Status':
        tasks.sort((a, b) => a.isCompleted.toString().compareTo(b.isCompleted.toString()));
        break;
      case 'Title':
        tasks.sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
        break;
      case 'Combined':
        tasks.sort((a, b) {
          int statusComparison =
              a.isCompleted.toString().compareTo(b.isCompleted.toString());
          if (statusComparison != 0) return statusComparison;

          int priorityComparison = b.priority.compareTo(a.priority);
          if (priorityComparison != 0) return priorityComparison;

          return (a.dueDate ?? DateTime.now())
              .compareTo(b.dueDate ?? DateTime.now());
        });
        break;
      default:
        break; // Default order (no sorting)
    }
    return tasks;
  }

  Future<void> addTodo(TodoTask todo) async {
    await ref.read(todoRepositoryProvider).addTodo(todo);
  }

  Future<void> updateTodo(TodoTask todo) async {
    await ref.read(todoRepositoryProvider).updateTodo(todo);
  }

  Future<void> deleteTodo(int id) async {
    await ref.read(todoRepositoryProvider).deleteTodo(id);
  }
}


@Riverpod(keepAlive: true)
ObjectBox objectBox(Ref ref) {
  throw UnimplementedError('ObjectBox must be initialized before accessing');
}
