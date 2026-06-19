import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:abc_wonder/core/theme/colors.dart';
import 'package:abc_wonder/core/theme/typography.dart';
import 'package:abc_wonder/core/widgets/rim_card.dart';
import 'package:abc_wonder/data/models/shape_model.dart';
import 'package:abc_wonder/data/static/shape_data.dart';
import 'package:abc_wonder/utils/tts_helper.dart';

class ShapePuzzleScreen extends StatefulWidget {
  const ShapePuzzleScreen({super.key});

  @override
  State<ShapePuzzleScreen> createState() => _ShapePuzzleScreenState();
}

class _ShapePuzzleScreenState extends State<ShapePuzzleScreen> {
  final _random = Random();
  int _round = 0;
  int _score = 0;
  late ShapeModel _target;
  List<ShapeModel> _options = [];
  bool _answered = false;

  @override
  void initState() {
    super.initState();
    _newRound();
  }

  void _newRound() {
    _round++;
    _answered = false;
    _target = ShapeData.items[_random.nextInt(ShapeData.items.length)];
    TtsHelper().speak('Find the ${_target.name}');

    final wrong = <ShapeModel>{};
    while (wrong.length < 2) {
      final w = ShapeData.items[_random.nextInt(ShapeData.items.length)];
      if (w.id != _target.id) wrong.add(w);
    }
    _options = [_target, ...wrong];
    _options.shuffle();
  }

  void _answer(ShapeModel selected) {
    if (_answered) return;
    setState(() {
      _answered = true;
      if (selected.id == _target.id) {
        _score++;
        TtsHelper().speak('Correct! ${_target.name}!');
      } else {
        TtsHelper().speak('This is a ${selected.name}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: Text('Puzzle — Score: $_score'),
        backgroundColor: const Color(0xFF7AD0FF),
        foregroundColor: const Color(0xFF001E2C),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.goNamed('shapes-hub')),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Which shape is this?', style: AppTypography.headlineLgMobile.copyWith(color: AppColors.onSurface)),
              const SizedBox(height: 32),
              Container(
                width: 120, height: 120,
                decoration: BoxDecoration(
                  color: const Color(0xFF7AD0FF),
                  borderRadius: BorderRadius.circular(_target.id == 'circle' || _target.id == 'oval' ? 60 : 16),
                  boxShadow: [BoxShadow(color: const Color(0xFF00668A).withValues(alpha: 0.3), blurRadius: 20)],
                ),
                child: Center(child: Text(_target.emoji, style: const TextStyle(fontSize: 48))),
              ),
              const SizedBox(height: 32),
              ..._options.map((s) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: SizedBox(
                  width: double.infinity,
                  child: RimCard(
                    onTap: () => _answer(s),
                    backgroundColor: _answered && s.id == _target.id
                        ? const Color(0xFF4CAF50)
                        : const Color(0xFF7AD0FF),
                    borderColor: _answered && s.id == _target.id
                        ? const Color(0xFF2E7D32)
                        : const Color(0xFF004E6B),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Center(
                        child: Text(s.name, style: AppTypography.bodyXl.copyWith(
                          color: const Color(0xFF001E2C), fontWeight: FontWeight.bold,
                        )),
                      ),
                    ),
                  ),
                ),
              )),
              if (_answered) ...[
                const SizedBox(height: 16),
                Text(_answered && _target.id == _target.id ? '✅' : '❌',
                  style: AppTypography.headlineLg.copyWith(color: Colors.green)),
                const SizedBox(height: 16),
                RimCard(
                  onTap: _round >= 5 ? () => context.goNamed('shape-celebration') : _newRound,
                  backgroundColor: const Color(0xFF7AD0FF),
                  borderColor: const Color(0xFF004E6B),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Center(child: Text(
                      _round >= 5 ? 'See Results' : 'Next Puzzle',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF001E2C)),
                    )),
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
