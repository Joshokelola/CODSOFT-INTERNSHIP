import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo/app/providers/todo_providers.dart';
import '../../todo/presentation/create_task_page.dart';
import '../../todo/presentation/edit_task_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  String _getPriorityLabel(int priority) {
    switch (priority) {
      case 0:
        return 'Low';
      case 1:
        return 'Medium';
      case 2:
        return 'High';
      default:
        return 'Unknown';
    }
  }

  Color _getPriorityColor(int priority) {
    switch (priority) {
      case 0:
        return Colors.green;
      case 1:
        return Colors.orange;
      case 2:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final todosAsync = ref.watch(todoNotifierProvider);

    return Scaffold(
    appBar: AppBar(
  title: const Text(
    'My Tasks',
    style: TextStyle(fontWeight: FontWeight.bold),
  ),
  actions: [
    PopupMenuButton<String>(
      icon: const Icon(Icons.sort),
      onSelected: (String value) {
        ref.read(todoNotifierProvider.notifier).setSortMethod(value);
      },
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem(
          value: 'Default',
          child: Text('Default Order'),
        ),
        const PopupMenuItem(
          value: 'Due Date',
          child: Text('Sort by Due Date'),
        ),
        const PopupMenuItem(
          value: 'Priority',
          child: Text('Sort by Priority'),
        ),
        const PopupMenuItem(
          value: 'Completion Status',
          child: Text('Sort by Completion Status'),
        ),
        const PopupMenuItem(
          value: 'Title',
          child: Text('Sort by Title'),
        ),
        const PopupMenuItem(
          value: 'Combined',
          child: Text('Sort by Combined'),
        ),
      ],
    ),
  ],
),


      body: todosAsync.when(
        data: (tasks) {
          if (tasks.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.task_alt, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'No tasks yet',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              final dueDate = task.dueDate != null
                  ? DateFormat('MMM dd, yyyy').format(task.dueDate!)
                  : 'No due date';

              return Dismissible(
                key: Key(task.id.toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  color: Colors.red,
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (_) async {
                  await ref
                      .read(todoNotifierProvider.notifier)
                      .deleteTodo(task.id!);
                },
                child: Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskEditingScreen(taskId: task.id!),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: task.isCompleted,
                                onChanged: (value) async {
                                  if (value != null) {
                                    final updatedTask = task.copyWith(
                                      isCompleted: value,
                                    );
                                    await ref
                                        .read(todoNotifierProvider.notifier)
                                        .updateTodo(updatedTask);
                                  }
                                },
                              ),
                              Expanded(
                                child: Text(
                                  task.title,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    decoration: task.isCompleted
                                        ? TextDecoration.lineThrough
                                        : null,
                                    color: task.isCompleted
                                        ? Colors.grey
                                        : Colors.black,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: _getPriorityColor(task.priority)
                                      .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  _getPriorityLabel(task.priority),
                                  style: TextStyle(
                                    color: _getPriorityColor(task.priority),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (task.description?.isNotEmpty ?? false) ...[
                            const SizedBox(height: 8),
                            Text(
                              task.description!,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 16,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                dueDate,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
        error: (error, stack) => Center(
          child: Text('Error: $error'),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TaskCreationScreen(),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Task'),
      ),
    );
  }
}