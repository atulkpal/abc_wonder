import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:abc_wonder/core/theme/colors.dart';
import 'package:abc_wonder/core/theme/typography.dart';
import 'package:abc_wonder/core/widgets/rim_card.dart';
import 'package:abc_wonder/data/static/days_data.dart';
import 'package:abc_wonder/data/models/day_model.dart';

class DailyQuizScreen extends StatefulWidget {
  const DailyQuizScreen({super.key});

  @override
  State<DailyQuizScreen> createState() => _DailyQuizScreenState();
}

class _DailyQuizScreenState extends State<DailyQuizScreen> {
  final List<_Question> _questions = [];
  int _questionIndex = 0;
  int _score = 0;
  bool _answered = false;
  bool _finished = false;
  final _rng = Random();

  @override
  void initState() {
    super.initState();
    _generateQuestions();
  }

  void _generateQuestions() {
    _questions.clear();
    final days = DaysData.items;
    for (int i = 0; i < 7; i++) {
      final target = days[i];
      final others = days.where((d) => d.id != target.id).toList()..shuffle(_rng);
      final options = [target, others[0], others[1]]..shuffle(_rng);
      _questions.add(_Question(target: target, options: options));
    }
    _questionIndex = 0;
    _score = 0;
    _answered = false;
    _finished = false;
  }

  _Question get _current => _questions[_questionIndex];

  void _select(DayModel selected) {
    if (_answered) return;
    setState(() {
      _answered = true;
      if (selected.id == _current.target.id) _score++;
    });
  }

  void _next() {
    if (_questionIndex < _questions.length - 1) {
      setState(() {
        _questionIndex++;
        _answered = false;
      });
    } else {
      setState(() => _finished = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: _finished ? _buildResult() : _buildQuiz(),
      ),
    );
  }

  Widget _buildQuiz() {
    final q = _current;
    return Column(
      children: [
        _QuizTopBar(questionIndex: _questionIndex, total: _questions.length),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
          child: Text(
            'What day comes after ${q.target.name}?',
            textAlign: TextAlign.center,
            style: AppTypography.headlineLgMobile.copyWith(
              color: const Color(0xFF544600),
              fontSize: 24,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: q.options.map((option) {
                final isCorrect = option.id == q.target.id;
                final isSelected = _answered;
                Color? bg;
                if (isSelected && isCorrect) bg = Colors.green.withValues(alpha: 0.2);
                if (isSelected && !isCorrect) bg = Colors.red.withValues(alpha: 0.2);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: RimCard(
                      onTap: isSelected ? null : () => _select(option),
                      backgroundColor: bg ?? option.cardColor,
                      borderColor: const Color(0xFF544600),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(option.emoji, style: const TextStyle(fontSize: 28)),
                            const SizedBox(width: 12),
                            Text(
                              option.name,
                              style: AppTypography.headlineLgMobile.copyWith(
                                color: const Color(0xFF001E2C),
                                fontSize: 22,
                              ),
                            ),
                            if (isSelected && isCorrect)
                              const Padding(
                                padding: EdgeInsets.only(left: 12),
                                child: Text('✅', style: TextStyle(fontSize: 24)),
                              ),
                            if (isSelected && !isCorrect)
                              const Padding(
                                padding: EdgeInsets.only(left: 12),
                                child: Text('❌', style: TextStyle(fontSize: 24)),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        if (_answered)
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _next,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFE66D),
                  foregroundColor: const Color(0xFF001E2C),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  _questionIndex < _questions.length - 1 ? 'Next' : 'See Results',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildResult() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('🎉', style: TextStyle(fontSize: 64)),
        const SizedBox(height: 16),
        Text(
          'You got $_score / ${_questions.length}',
          style: AppTypography.displayHero.copyWith(
            color: const Color(0xFF544600),
            fontSize: 36,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          _score == 7
              ? 'Perfect! You know all the days!'
              : _score >= 4
                  ? 'Good job! Keep practicing!'
                  : 'Try again to learn them all!',
          style: AppTypography.headlineLgMobile.copyWith(
            color: const Color(0xFF544600),
            fontSize: 22,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: () {
            setState(_generateQuestions);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFFE66D),
            foregroundColor: const Color(0xFF001E2C),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          ),
          child: const Text('Play Again'),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () => context.goNamed('days-hub'),
          child: const Text('Back to Hub'),
        ),
      ],
    );
  }
}

class _QuizTopBar extends StatelessWidget {
  final int questionIndex;
  final int total;
  const _QuizTopBar({required this.questionIndex, required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.onSurface.withValues(alpha: 0.06),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF544600), size: 32),
            onPressed: () => context.goNamed('days-hub'),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 64, minHeight: 64),
          ),
          Flexible(
            child: Text(
              'Question ${questionIndex + 1}/$total',
              overflow: TextOverflow.ellipsis,
              style: AppTypography.headlineLgMobile.copyWith(
                color: const Color(0xFF544600),
                fontSize: 24,
              ),
            ),
          ),
          const SizedBox(width: 64),
        ],
      ),
    );
  }
}

class _Question {
  final DayModel target;
  final List<DayModel> options;
  const _Question({required this.target, required this.options});
}
