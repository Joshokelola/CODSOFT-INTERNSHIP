import 'package:quiz_app/features/quiz/domain/question.dart';

class Quiz {
  final String id;
  final String title;
  final String description;
  final List<Question> questions;
  final int timeForQuiz; // in seconds
  
  Quiz({
    required this.id,
    required this.title,
    required this.description,
    required this.questions,
    this.timeForQuiz = 60,
  });

  Quiz copyWith({
    String? id,
    String? title,
    String? description,
    List<Question>? questions,
    int? timeForQuiz,
  }) {
    return Quiz(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      questions: questions ?? this.questions,
      timeForQuiz: timeForQuiz ?? this.timeForQuiz,
    );
  }
}
