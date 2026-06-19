import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:abc_wonder/core/theme/colors.dart';
import 'package:abc_wonder/core/theme/typography.dart';
import 'package:abc_wonder/core/widgets/rim_card.dart';
import 'package:abc_wonder/data/models/color_model.dart';
import 'package:abc_wonder/data/static/color_data.dart';
import 'package:abc_wonder/utils/tts_helper.dart';

class ColorMatchingScreen extends StatefulWidget {
  const ColorMatchingScreen({super.key});

  @override
  State<ColorMatchingScreen> createState() => _ColorMatchingScreenState();
}

class _ColorMatchingScreenState extends State<ColorMatchingScreen> {
  final _random = Random();
  late ColorModel _target;
  int _score = 0;
  int _round = 0;
  bool _answered = false;

  @override
  void initState() {
    super.initState();
    _newRound();
  }

  void _newRound() {
    _round++;
    _answered = false;
    _target = ColorData.items[_random.nextInt(ColorData.items.length)];
    TtsHelper().speak('Find the color ${_target.name}');
  }

  void _pick(ColorModel color) {
    if (_answered) return;
    setState(() {
      _answered = true;
      if (color.id == _target.id) {
        _score++;
        TtsHelper().speak('Correct! This is ${_target.name}!');
      } else {
        TtsHelper().speak('This is ${color.name}, not ${_target.name}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: Text('Matching — Score: $_score'),
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
              Text('Match the color', style: AppTypography.headlineLgMobile.copyWith(color: AppColors.onSurface)),
              const SizedBox(height: 24),
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: _target.color,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  boxShadow: [BoxShadow(color: _target.color.withValues(alpha: 0.4), blurRadius: 20)],
                ),
              ),
              const SizedBox(height: 8),
              Text(_target.name, style: AppTypography.headlineLg.copyWith(color: AppColors.onSurface)),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  children: ColorData.items.map((c) {
                    return GestureDetector(
                      onTap: () => _pick(c),
                      child: AnimatedScale(
                        scale: _answered && c.id == _target.id ? 1.15 : 1,
                        duration: const Duration(milliseconds: 200),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: c.color,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: _answered && c.id == _target.id
                                      ? Colors.green
                                      : Colors.white,
                                  width: 3,
                                ),
                              ),
                            ),
                            Text(c.name, style: const TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              if (_answered) ...[
                const SizedBox(height: 32),
                RimCard(
                  onTap: _round >= 5 ? () => context.goNamed('color-celebration') : _newRound,
                  backgroundColor: AppColors.tertiaryContainer,
                  borderColor: const Color(0xFF930040),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      _round >= 5 ? 'See Results' : 'Next Color',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF930040)),
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
