import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:quiz_app/features/quiz/domain/question.dart';
import 'package:quiz_app/features/quiz/presentation/controllers/quiz_controller.dart';
import 'package:quiz_app/features/quiz/presentation/result_screen.dart';

import '../domain/quiz.dart';

class QuizScreen extends ConsumerStatefulWidget {
  final Quiz quiz;

  const QuizScreen({super.key, required this.quiz});
  @override
  ConsumerState<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizScreen> {
  //int _currentQuestionIndex = 0;
 // int? _selectedOptionIndex;
  // final List<int?> _userAnswers = List.filled(30, null);
  // bool _isTimeUp = false;
  // late DateTime _endTime;
  // int _remainingSeconds = 60; // 30 minutes in seconds

  // final List<Question> _questions = [
  //   Question(
  //     id: '1',
  //     questionText: 'Who is making the Web standards?',
  //     options: [
  //       'The World Wide Web Consortium',
  //       'Microsoft',
  //       'Mozilla',
  //       'Google'
  //     ],
  //     correctAnswerIndex: 0,
  //   ),
  //   Question(
  //     id: '2',
  //     questionText: 'What does HTML stand for?',
  //     options: [
  //       'Hyper Text Markup Language',
  //       'High Tech Modern Language',
  //       'Hyperlinks and Text Markup Language',
  //       'Home Tool Markup Language'
  //     ],
  //     correctAnswerIndex: 0,
  //   ),
  //   // Add more questions here
  // ];

  @override
  void initState() {
    super.initState();
    
      // ref.read(quizSessionControllerProvider(widget.quiz));
     


    // _endTime = DateTime.now().add(const Duration(minutes: 1));
    // _startTimer();
  }

  // void _startTimer() {
  //   Future.delayed(const Duration(seconds: 1), () {
  //     if (!mounted) return;

  //     setState(() {
  //       _remainingSeconds--;
  //       if (_remainingSeconds <= 0) {
  //         _isTimeUp = true;
  //       } else {
  //         _startTimer();
  //       }
  //     });
  //   });
  // }

  // void _selectOption(int index) {
  //   if (_isTimeUp) return;

  //   setState(() {
  //     _selectedOptionIndex = index;
  //     _userAnswers[_currentQuestionIndex] = index;
  //   });
  // }

  // void _nextQuestion() {
  //   if (_isTimeUp) return;

  //   if (_currentQuestionIndex < _questions.length - 1) {
  //     setState(() {
  //       _currentQuestionIndex++;
  //       _selectedOptionIndex = _userAnswers[_currentQuestionIndex];
  //     });
  //   } else {
  //     _showResultsDialog();
  //   }
  // }

  // void _previousQuestion() {
  //   if (_isTimeUp) return;

  //   if (_currentQuestionIndex > 0) {
  //     setState(() {
  //       _currentQuestionIndex--;
  //       _selectedOptionIndex = _userAnswers[_currentQuestionIndex];
  //     });
  //   }
  // }

  void _showResultsDialog() {
    var qs = ref.watch(quizSessionControllerProvider(widget.quiz));
    var qsn = ref.watch(quizSessionControllerProvider(widget.quiz).notifier);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(qs.isTimeUp ? 'Time\'s Up!' : 'Quiz Complete'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(qs.isTimeUp
                ? 'Your quiz time has ended. Let\'s see your results!'
                : 'You\'ve completed all questions. Ready to see your results?'),
            const SizedBox(height: 8),
            Text(
              // 'Answered: ${_userAnswers.where((answer) => answer != null).length}/${_questions.length}',
              'Answered: ${qsn.getAnsweredCount()}',

              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Add navigation to results screen
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultsScreen(
                    userAnswers: qs.userAnswers,
                    questions: qs.questions,
                  ),
                ),
              );
            },
            child: const Text('View Results'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var quizSessionProvider =
        ref.watch(quizSessionControllerProvider(widget.quiz));
    var quizSessionController =
        ref.watch(quizSessionControllerProvider(widget.quiz).notifier);
    // final question = _questions[_currentQuestionIndex];
    final question =
        quizSessionProvider.questions[quizSessionProvider.currentQuestionIndex];
        var _selectedOptionIndex = quizSessionProvider.selectedOptionIndex;
    // final progress = (_currentQuestionIndex + 1) / _questions.length;
    final progress = (quizSessionProvider.currentQuestionIndex + 1) /
        quizSessionProvider.questions.length;
    final isTimeLow = quizSessionProvider.remainingSeconds < 60;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 150,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title:  Text(widget.quiz.title),
             titlePadding: const EdgeInsets.only(left: 50, bottom: 16),
             expandedTitleScale: 1.3,
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColor.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isTimeLow
                          ? Colors.red.withOpacity(0.1)
                          : Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: isTimeLow
                          ? Border.all(color: Colors.red, width: 2)
                          : null,
                    ),
                    child: Column(
                      children: [
                        // TimerCountdown(
                        //   format: CountDownTimerFormat.minutesSeconds,
                        //   endTime: DateTime.now()
                        //       .add(Duration(seconds: quizSessionProvider.totalTime)),
                        //   onEnd: () {
                        //     // setState(() {
                        //     //   _isTimeUp = true;
                        //     // });
                        //     quizSessionController.setTimeUp();
                        //     _showResultsDialog();
                        //   },
                        //   timeTextStyle: TextStyle(
                        //     color: quizSessionProvider.isTimeUp || isTimeLow
                        //         ? Colors.red
                        //         : Theme.of(context).primaryColor,
                        //     fontSize: 24,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        //   colonsTextStyle: TextStyle(
                        //     color: quizSessionProvider.isTimeUp || isTimeLow
                        //         ? Colors.red
                        //         : Theme.of(context).primaryColor,
                        //     fontSize: 24,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        //   descriptionTextStyle:
                        //       Theme.of(context).textTheme.bodySmall,
                        //   spacerWidth: 20,
                        //   enableDescriptions: true,
                        //   minutesDescription: 'min',
                        //   secondsDescription: 'sec',
                        // ),
                        Text(
  '${(quizSessionProvider.remainingSeconds ~/ 60).toString().padLeft(2, '0')}:${(quizSessionProvider.remainingSeconds % 60).toString().padLeft(2, '0')}',
  style: TextStyle(
    color: quizSessionProvider.isTimeUp || isTimeLow
        ? Colors.red
        : Theme.of(context).primaryColor,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  ),
),
                        if (isTimeLow) ...[
                          const SizedBox(height: 8),
                          Text(
                            'Time is running out!',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Question ${quizSessionProvider.currentQuestionIndex + 1} of ${quizSessionProvider.questions.length}',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '${(progress * 100).toInt()}%',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      question.questionText,
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  ...List.generate(
                    question.options.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Material(
                          color: _selectedOptionIndex == index
                              ? Theme.of(context).primaryColor.withOpacity(0.1)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          child: InkWell(
                            onTap: () =>
                                quizSessionController.selectOption(index),
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Theme.of(context).primaryColor,
                                        width: 2,
                                      ),
                                      shape: BoxShape.circle,
                                      color: _selectedOptionIndex == index
                                          ? Theme.of(context).primaryColor
                                          : Colors.transparent,
                                    ),
                                    child: _selectedOptionIndex == index
                                        ? Icon(
                                            Icons.check,
                                            size: 16,
                                            color: Colors.white,
                                          )
                                        : null,
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Text(
                                      question.options[index],
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton.icon(
                        onPressed:
                            quizSessionProvider.currentQuestionIndex > 0 &&
                                    !quizSessionProvider.isTimeUp
                                ? quizSessionController.previousQuestion
                                : null,
                        icon: const Icon(Icons.arrow_back),
                        label: const Text('Previous'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                      ),
                      FilledButton.icon(
                        onPressed: !quizSessionProvider.isTimeUp
                            ? quizSessionProvider.currentQuestionIndex <
                                    quizSessionProvider.questions.length - 1
                                ? quizSessionController.nextQuestion
                                : _showResultsDialog
                            : null,
                        icon: Icon(
                          quizSessionProvider.currentQuestionIndex <
                                  quizSessionProvider.questions.length - 1
                              ? Icons.arrow_forward
                              : Icons.check,
                        ),
                        label: Text(
                          quizSessionProvider.currentQuestionIndex <
                                  quizSessionProvider.questions.length - 1
                              ? 'Next'
                              : 'Finish',
                        ),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
