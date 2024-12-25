import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'todo.g.dart';

@JsonSerializable()
@Entity()
class TodoTask {
  @Id()
   int? id;
  
  final String title;
  final String? description;
  
  @Property(type: PropertyType.dateNano)
  final DateTime? dueDate;
  
  final int priority;
  final bool isCompleted;

   TodoTask({
    this.id,
    required this.title,
    this.description,
    this.dueDate,
    this.priority = 0,
    this.isCompleted = false,
  });

  TodoTask copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? dueDate,
    int? priority,
    bool? isCompleted,
  }) {
    return TodoTask(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  factory TodoTask.fromJson(Map<String, dynamic> json) => 
      _$TodoTaskFromJson(json);

  Map<String, dynamic> toJson() => _$TodoTaskToJson(this);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoTask &&
          id == other.id &&
          title == other.title &&
          description == other.description &&
          dueDate == other.dueDate &&
          priority == other.priority &&
          isCompleted == other.isCompleted;

  @override
  int get hashCode => Object.hash(
        id,
        title,
        description,
        dueDate,
        priority,
        isCompleted,
      );

  @override
  String toString() {
    return 'TodoTask(id: $id, title: $title, description: $description, '
        'dueDate: $dueDate, priority: $priority, isCompleted: $isCompleted)';
  }
}