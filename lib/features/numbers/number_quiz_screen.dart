import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:abc_wonder/core/theme/colors.dart';
import 'package:abc_wonder/core/theme/typography.dart';
import 'package:abc_wonder/core/widgets/squishy_button.dart';
import 'package:abc_wonder/core/widgets/rim_card.dart';
import 'package:abc_wonder/data/static/number_data.dart';
import 'package:abc_wonder/utils/tts_helper.dart';

class NumberQuizScreen extends StatefulWidget {
  const NumberQuizScreen({super.key});

  @override
  State<NumberQuizScreen> createState() => _NumberQuizScreenState();
}

class _NumberQuizScreenState extends State<NumberQuizScreen> {
  int _currentQuestion = 0;
  int _score = 0;
  int _correctAnswer = 0;
  List<int> _options = [];
  bool _answered = false;
  bool? _lastCorrect;
  final _random = Random();

  @override
  void initState() {
    super.initState();
    _newQuestion();
  }

  void _newQuestion() {
    _currentQuestion++;
    _answered = false;
    _lastCorrect = null;
    _correctAnswer = _random.nextInt(10) + 1;
    final num = NumberData.byId('$_correctAnswer');
    TtsHelper().speak('Find the number ${num?.spokenName ?? _correctAnswer}');

    final wrong = <int>{};
    while (wrong.length < 2) {
      final w = _random.nextInt(10) + 1;
      if (w != _correctAnswer) wrong.add(w);
    }
    _options = [_correctAnswer, ...wrong];
    _options.shuffle();
  }

  void _answer(int selected) {
    if (_answered) return;
    setState(() {
      _answered = true;
      _lastCorrect = selected == _correctAnswer;
      if (_lastCorrect!) _score++;
    });
    TtsHelper().speak(selected == _correctAnswer ? 'Correct!' : 'The answer was $_correctAnswer');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: Text('Quiz — Score: $_score'),
        backgroundColor: AppColors.secondary,
        foregroundColor: AppColors.onSecondary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.goNamed('numbers-hub'),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Question $_currentQuestion',
                style: AppTypography.headlineLgMobile.copyWith(color: AppColors.onSurface),
              ),
              const SizedBox(height: 8),
              Text(
                'Tap the correct number',
                style: AppTypography.bodyXl.copyWith(color: AppColors.onSurfaceVariant),
              ),
              const SizedBox(height: 48),
              ..._options.map((opt) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: SizedBox(
                  width: double.infinity,
                  child: RimCard(
                    onTap: () => _answer(opt),
                    backgroundColor: _answered
                        ? (opt == _correctAnswer
                            ? const Color(0xFF4CAF50)
                            : (_lastCorrect == false && opt != _correctAnswer
                                ? AppColors.secondaryContainer
                                : AppColors.secondaryContainer))
                        : AppColors.secondaryContainer,
                    borderColor: _answered && opt == _correctAnswer
                        ? const Color(0xFF2E7D32)
                        : const Color(0xFF6F5C00),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: Text(
                          NumberData.byId('$opt')?.emoji ?? '',
                          style: const TextStyle(fontSize: 48),
                        ),
                      ),
                    ),
                  ),
                ),
              )),
              if (_answered) ...[
                const SizedBox(height: 16),
                Text(
                  _lastCorrect! ? '✅ Correct!' : '❌ Try again next time!',
                  style: AppTypography.headlineLg.copyWith(
                    color: _lastCorrect! ? Colors.green : Colors.red,
                  ),
                ),
                const SizedBox(height: 16),
                SquishyButton(
                  onTap: _currentQuestion >= 5
                      ? () => context.goNamed('number-celebration')
                      : _newQuestion,
                  child: Text(
                    _currentQuestion >= 5 ? 'See Results' : 'Next Question',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
