// Create a provider for the selected task
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../app/providers/todo_providers.dart';
import '../../domain/todo.dart';
part 'selectedTaskProvider.g.dart';
@riverpod
Future<TodoTask?> selectedTask(SelectedTaskRef ref, int taskId) {
  return ref.watch(todoRepositoryProvider).getTodo(taskId);
}