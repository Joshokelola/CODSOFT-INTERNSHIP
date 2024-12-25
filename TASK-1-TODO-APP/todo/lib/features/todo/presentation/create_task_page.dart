import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo/features/todo/domain/todo.dart';

import '../../../app/providers/todo_providers.dart';

class TaskCreationScreen extends ConsumerStatefulWidget {
 const TaskCreationScreen({super.key});

 @override
 ConsumerState<TaskCreationScreen> createState() => _TaskCreationScreenState();
}

class _TaskCreationScreenState extends ConsumerState<TaskCreationScreen> {
 final _formKey = GlobalKey<FormState>();
 final _titleController = TextEditingController();
 final _descriptionController = TextEditingController();
 DateTime? _selectedDate;
 int _priority = 0;

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

 Future<void> _createTask() async {
   if (!_formKey.currentState!.validate()) return;

   try {
     final newTask = TodoTask(
       title: _titleController.text.trim(),
       description: _descriptionController.text.trim(),
       dueDate: _selectedDate,
       priority: _priority,
       isCompleted: false,
     );

     await ref.read(todoNotifierProvider.notifier).addTodo(newTask);
     
     if (mounted) {
       ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(
           content: Text('Task created successfully'),
           behavior: SnackBarBehavior.floating,
         ),
       );
       Navigator.of(context).pop();
     }
   } catch (e) {
     if (mounted) {
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
           content: Text('Error creating task: $e'),
           behavior: SnackBarBehavior.floating,
         ),
       );
     }
   }
 }

 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: const Text('Create Task'),
       actions: [
         IconButton(
           icon: const Icon(Icons.check),
           onPressed: _createTask,
         ),
       ],
     ),
     body: Form(
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
                 ],
               ),
             ),
           ),
         ],
       ),
     ),
   );
 }
}