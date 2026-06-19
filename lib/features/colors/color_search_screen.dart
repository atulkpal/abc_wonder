import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:abc_wonder/core/theme/colors.dart';
import 'package:abc_wonder/core/theme/typography.dart';
import 'package:abc_wonder/data/models/color_model.dart';
import 'package:abc_wonder/data/static/color_data.dart';
import 'package:abc_wonder/utils/tts_helper.dart';

class ColorSearchScreen extends StatefulWidget {
  const ColorSearchScreen({super.key});

  @override
  State<ColorSearchScreen> createState() => _ColorSearchScreenState();
}

class _ColorSearchScreenState extends State<ColorSearchScreen> {
  final _random = Random();
  late ColorModel _target;
  int _score = 0;
  int _round = 0;
  bool _found = false;

  @override
  void initState() {
    super.initState();
    _newRound();
  }

  void _newRound() {
    _round++;
    _found = false;
    _target = ColorData.items[_random.nextInt(ColorData.items.length)];
    TtsHelper().speak('Can you find the color ${_target.name}?');
  }

  List<Color> get _sceneColors => [
    Colors.red, Colors.blue, Colors.green, Colors.yellow,
    Colors.orange, Colors.purple, Colors.pink, Colors.brown,
    Colors.black45, Colors.white70,
  ];

  @override
  Widget build(BuildContext context) {
    final items = _sceneColors;
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: Text('Search — Score: $_score'),
        backgroundColor: AppColors.tertiary,
        foregroundColor: AppColors.onTertiary,
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.goNamed('colors-hub')),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Text('Find the color', style: AppTypography.headlineLgMobile.copyWith(color: AppColors.onSurface)),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: _target.color,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: Text(
                  _target.name,
                  style: AppTypography.headlineLg.copyWith(
                    color: _target.id == 'white' || _target.id == 'yellow' ? Colors.black87 : Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1,
                  children: items.map((color) {
                    final isTarget = color == _target.color;
                    return GestureDetector(
                      onTap: () {
                        if (_found) return;
                        setState(() {
                          _found = true;
                          if (isTarget) {
                            _score++;
                            TtsHelper().speak('Found ${_target.name}!');
                          } else {
                            TtsHelper().speak('Not quite, try again!');
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: _found && isTarget ? Colors.green : Colors.white,
                            width: _found && isTarget ? 4 : 2,
                          ),
                          boxShadow: _found && isTarget
                              ? [BoxShadow(color: Colors.green.withValues(alpha: 0.5), blurRadius: 16, spreadRadius: 4)]
                              : null,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              if (_found) ...[
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: _round >= 5 ? () => context.goNamed('color-celebration') : _newRound,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    decoration: BoxDecoration(
                      color: AppColors.tertiaryContainer,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFF930040), width: 3),
                    ),
                    child: Text(
                      _round >= 5 ? 'Finish' : 'Next Round',
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
