import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../app/providers/todo_providers.dart';
import 'providers/selectedTaskProvider.dart';

class TaskEditingScreen extends ConsumerStatefulWidget {
  final int taskId;
  const TaskEditingScreen({super.key, required this.taskId});
  
  @override
  ConsumerState<TaskEditingScreen> createState() => _TaskEditingScreenState();
}

class _TaskEditingScreenState extends ConsumerState<TaskEditingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _selectedDate;
  int _priority = 0;
  bool _isCompleted = false;
  
  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: _getPriorityColor(_priority),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _updateTask() async {
    if (!_formKey.currentState!.validate()) return;

    final task = await ref.read(todoRepositoryProvider).getTodo(widget.taskId);
    if (task == null) return;

    bool hasChanges = task.title != _titleController.text.trim() ||
        task.description != _descriptionController.text.trim() ||
        task.dueDate != _selectedDate ||
        task.priority != _priority ||
        task.isCompleted != _isCompleted;

    if (!hasChanges) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No changes made'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }
    }

    final updatedTask = task.copyWith(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      dueDate: _selectedDate,
      priority: _priority,
      isCompleted: _isCompleted,
    );

    try {
      await ref.read(todoNotifierProvider.notifier).updateTodo(updatedTask);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Task updated successfully'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating task: $e'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final taskAsync = ref.watch(selectedTaskProvider(widget.taskId));
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _updateTask,
          ),
        ],
      ),
      body: taskAsync.when(
        data: (task) {
          if (task != null && _titleController.text.isEmpty) {
            _titleController.text = task.title;
            _descriptionController.text = task.description ?? '';
            _selectedDate = task.dueDate;
            _priority = task.priority;
            _isCompleted = task.isCompleted;
          }
          
          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Task Details',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _titleController,
                          decoration: const InputDecoration(
                            labelText: 'Title',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.title),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter a title';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _descriptionController,
                          decoration: const InputDecoration(
                            labelText: 'Description',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.description),
                          ),
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Task Settings',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        ListTile(
                          title: const Text('Due Date'),
                          subtitle: Text(
                            _selectedDate == null
                                ? 'No date selected'
                                : DateFormat('MMMM dd, yyyy').format(_selectedDate!),
                          ),
                          leading: Icon(
                            Icons.calendar_today,
                            color: _getPriorityColor(_priority),
                          ),
                          onTap: () => _selectDate(context),
                        ),
                        const Divider(),
                        ListTile(
                          title: const Text('Priority'),
                          subtitle: DropdownButtonFormField<int>(
                            value: _priority,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(horizontal: 12),
                            ),
                            items: const [
                              DropdownMenuItem(value: 0, child: Text('Low')),
                              DropdownMenuItem(value: 1, child: Text('Medium')),
                              DropdownMenuItem(value: 2, child: Text('High')),
                            ],
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  _priority = value;
                                });
                              }
                            },
                          ),
                          leading: Icon(
                            Icons.flag,
                            color: _getPriorityColor(_priority),
                          ),
                        ),
                        const Divider(),
                        SwitchListTile(
                          title: const Text('Task Completed'),
                          value: _isCompleted,
                          onChanged: (bool value) {
                            setState(() {
                              _isCompleted = value;
                            });
                          },
                          secondary: Icon(
                            Icons.check_circle,
                            color: _isCompleted ? Colors.green : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }
}