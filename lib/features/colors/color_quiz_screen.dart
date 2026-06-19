import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:abc_wonder/core/theme/colors.dart';
import 'package:abc_wonder/core/theme/typography.dart';
import 'package:abc_wonder/core/widgets/squishy_button.dart';
import 'package:abc_wonder/core/widgets/rim_card.dart';
import 'package:abc_wonder/data/models/color_model.dart';
import 'package:abc_wonder/data/static/color_data.dart';
import 'package:abc_wonder/utils/tts_helper.dart';

class ColorQuizScreen extends StatefulWidget {
  const ColorQuizScreen({super.key});

  @override
  State<ColorQuizScreen> createState() => _ColorQuizScreenState();
}

class _ColorQuizScreenState extends State<ColorQuizScreen> {
  final _random = Random();
  int _question = 0;
  int _score = 0;
  late ColorModel _correct;
  List<ColorModel> _options = [];
  bool _answered = false;

  @override
  void initState() {
    super.initState();
    _newQuestion();
  }

  void _newQuestion() {
    _question++;
    _answered = false;
    _correct = ColorData.items[_random.nextInt(ColorData.items.length)];
    TtsHelper().speak('Which color is this?');

    final wrong = <ColorModel>{};
    while (wrong.length < 2) {
      final w = ColorData.items[_random.nextInt(ColorData.items.length)];
      if (w.id != _correct.id) wrong.add(w);
    }
    _options = [_correct, ...wrong];
    _options.shuffle();
  }

  void _answer(ColorModel selected) {
    if (_answered) return;
    setState(() {
      _answered = true;
      if (selected.id == _correct.id) _score++;
    });
    TtsHelper().speak(selected.id == _correct.id ? 'Correct!' : 'This is ${_correct.name}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: Text('Quiz — Score: $_score'),
        backgroundColor: AppColors.tertiary,
        foregroundColor: AppColors.onTertiary,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.goNamed('colors-hub')),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Question $_question', style: AppTypography.headlineLgMobile.copyWith(color: AppColors.onSurface)),
              const SizedBox(height: 32),
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: _correct.color,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  boxShadow: [BoxShadow(color: _correct.color.withValues(alpha: 0.4), blurRadius: 24)],
                ),
              ),
              const SizedBox(height: 32),
              ..._options.map((c) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: SizedBox(
                  width: double.infinity,
                  child: RimCard(
                    onTap: () => _answer(c),
                    backgroundColor: _answered && c.id == _correct.id
                        ? const Color(0xFF4CAF50)
                        : AppColors.tertiaryContainer,
                    borderColor: _answered && c.id == _correct.id
                        ? const Color(0xFF2E7D32)
                        : const Color(0xFF930040),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Center(
                        child: Text(
                          c.name,
                          style: AppTypography.bodyXl.copyWith(
                            color: AppColors.onTertiaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )),
              if (_answered) ...[
                const SizedBox(height: 16),
                Text(
                  _answered && _options.firstWhere((o) => o.id == _correct.id).id == _correct.id
                      ? '✅ Correct!' : '❌',
                  style: AppTypography.headlineLg.copyWith(
                    color: _answered && _correct.id == _correct.id ? Colors.green : Colors.red,
                  ),
                ),
                const SizedBox(height: 16),
                SquishyButton(
                  backgroundColor: AppColors.tertiaryContainer,
                  rimColor: const Color(0xFFD9B500),
                  onTap: _question >= 5 ? () => context.goNamed('color-celebration') : _newQuestion,
                  child: Text(
                    _question >= 5 ? 'See Results' : 'Next Question',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF930040)),
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
