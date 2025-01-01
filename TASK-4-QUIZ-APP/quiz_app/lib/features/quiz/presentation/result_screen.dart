import 'package:flutter/material.dart';
import 'package:quiz_app/features/quiz/domain/question.dart';

class ResultsScreen extends StatelessWidget {
  final List<int?> userAnswers;
  final List<Question> questions;

  const ResultsScreen({
    Key? key,
    required this.userAnswers,
    required this.questions,
  }) : super(key: key);

  int get correctAnswers {
    int count = 0;
    for (int i = 0; i < questions.length; i++) {
      if (userAnswers[i] == questions[i].correctAnswerIndex) {
        count++;
      }
    }
    return count;
  }

  double get score {
    return (correctAnswers / questions.length) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Quiz Results'),
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
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                        child: Text(
                          '${score.round()}%',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
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
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatColumn(
                          'Total Questions',
                          questions.length.toString(),
                          context,
                        ),
                        _buildStatColumn(
                          'Correct',
                          correctAnswers.toString(),
                          context,
                        ),
                        _buildStatColumn(
                          'Incorrect',
                          (questions.length - correctAnswers).toString(),
                          context,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Detailed Review',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final question = questions[index];
                final userAnswer = userAnswers[index];
                final isCorrect = userAnswer == question.correctAnswerIndex;

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 8.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ExpansionTile(
                      title: Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isCorrect ? Colors.green : Colors.red,
                            ),
                            child: Icon(
                              isCorrect ? Icons.check : Icons.close,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Question ${index + 1}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                question.questionText,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 16),
                              ...List.generate(
                                question.options.length,
                                (optionIndex) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: _getOptionColor(
                                        optionIndex,
                                        userAnswer,
                                        question.correctAnswerIndex,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        _getOptionIcon(
                                          optionIndex,
                                          userAnswer,
                                          question.correctAnswerIndex,
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(question.options[optionIndex]),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: questions.length,
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 24),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FilledButton(
          onPressed: () {
            // Navigate back to home or restart quiz
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text('Back to Home'),
        ),
      ),
    );
  }

  Widget _buildStatColumn(String label, String value, BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Color _getOptionColor(int optionIndex, int? userAnswer, int correctAnswer) {
    if (optionIndex == correctAnswer) {
      return Colors.green.withOpacity(0.1);
    }
    if (optionIndex == userAnswer && userAnswer != correctAnswer) {
      return Colors.red.withOpacity(0.1);
    }
    return Colors.grey.withOpacity(0.1);
  }

  Widget _getOptionIcon(int optionIndex, int? userAnswer, int correctAnswer) {
    if (optionIndex == correctAnswer) {
      return const Icon(Icons.check_circle, color: Colors.green);
    }
    if (optionIndex == userAnswer && userAnswer != correctAnswer) {
      return const Icon(Icons.cancel, color: Colors.red);
    }
    return const Icon(Icons.circle_outlined, color: Colors.grey);
  }
}