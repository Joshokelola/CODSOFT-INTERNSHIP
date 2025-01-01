import 'package:flutter/material.dart';

import 'package:quiz_app/features/quiz/domain/question.dart';

@immutable
class QuizSession {
  final String quizId;
  final List<Question> questions;
  final List<int?> userAnswers;
  final DateTime startTime;
  final bool isTimeUp;
  final int currentQuestionIndex;
  final int? selectedOptionIndex;
  final int score;
  final int totalTime;
  final int remainingSeconds;

  QuizSession({
    required this.quizId,
    required this.startTime,
    required this.totalTime,
    required this.questions,
    this.selectedOptionIndex,
    this.userAnswers = const [],
    this.currentQuestionIndex = 0,
    this.score = 0,
    this.isTimeUp = false,
    this.remainingSeconds = 0,
  });

  QuizSession copyWith({
    String? quizId,
    List<Question>? questions,
    List<int?>? userAnswers,
    DateTime? startTime,
    bool? isTimeUp,
    int? currentQuestionIndex,
    int? score,
    int? remainingSeconds,
    int? selectedOptionIndex,
    int? totalTime,
  }) {
    return QuizSession(
      quizId: quizId ?? this.quizId,
      questions: questions ?? this.questions,
      userAnswers: userAnswers ?? this.userAnswers,
      startTime: startTime ?? this.startTime,
      isTimeUp: isTimeUp ?? this.isTimeUp,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      score: score ?? this.score,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      selectedOptionIndex: selectedOptionIndex,
      totalTime: totalTime ?? this.totalTime,
    );
  }
}
