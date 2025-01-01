import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/quiz.dart';
import '../../domain/quiz_session.dart';

part 'quiz_controller.g.dart';

@riverpod
class QuizSessionController extends _$QuizSessionController {
  Timer? _timer;

  @override
  QuizSession build(Quiz quiz) {
    // Start the timer when the controller is built
    startTimer();
    return QuizSession(
      quizId: quiz.id,
      startTime: DateTime.now(),
      totalTime: quiz.timeForQuiz,
      questions: quiz.questions,
      remainingSeconds: quiz.timeForQuiz,
      userAnswers: List.filled(quiz.questions.length, null),
      isTimeUp: false,
      currentQuestionIndex: 0,
      score: 0,
    );
  }

  void selectOption(int index) {
    if (state.isTimeUp) return;

    final newAnswers = List<int?>.from(state.userAnswers);
    newAnswers[state.currentQuestionIndex] = index;
    state = state.copyWith(
      userAnswers: newAnswers,
      selectedOptionIndex: index,
    );
  }

  void nextQuestion() {
    if (state.isTimeUp) return;
    if (state.currentQuestionIndex < state.questions.length - 1) {
      state = state.copyWith(
        currentQuestionIndex: state.currentQuestionIndex + 1,
        selectedOptionIndex: state.userAnswers[state.currentQuestionIndex + 1],
      );
    }
  }

  void previousQuestion() {
    if (state.isTimeUp) return;
    if (state.currentQuestionIndex > 0) {
      state = state.copyWith(
        currentQuestionIndex: state.currentQuestionIndex - 1,
        selectedOptionIndex: state.userAnswers[state.currentQuestionIndex - 1],
      );
    }
  }

  void setTimeUp() {
    _timer?.cancel();
    state = state.copyWith(isTimeUp: true);
  }

  int getAnsweredCount() {
    return state.userAnswers.where((answer) => answer != null).length;
  }

  void startTimer() {
    // Cancel any existing timer to prevent duplicates
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // if (!mounted) {
      //   timer.cancel();
      //   return;
      // }

      if (state.remainingSeconds <= 0) {
        timer.cancel();
        setTimeUp();
      } else {
        state = state.copyWith(
          remainingSeconds: state.remainingSeconds - 1,
           selectedOptionIndex: state.selectedOptionIndex,  // Preserve selected option
          userAnswers: state.userAnswers,
        );
      }
    });
  }

  // @override
  // void dispose() {
  //   _timer?.cancel();
  //   super.dispose();
  // }
}
