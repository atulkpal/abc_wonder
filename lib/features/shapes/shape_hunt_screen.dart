import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:abc_wonder/core/theme/colors.dart';
import 'package:abc_wonder/core/theme/typography.dart';
import 'package:abc_wonder/data/models/shape_model.dart';
import 'package:abc_wonder/data/static/shape_data.dart';
import 'package:abc_wonder/utils/tts_helper.dart';

class ShapeHuntScreen extends StatefulWidget {
  const ShapeHuntScreen({super.key});

  @override
  State<ShapeHuntScreen> createState() => _ShapeHuntScreenState();
}

class _ShapeHuntScreenState extends State<ShapeHuntScreen> {
  final _random = Random();
  int _round = 0;
  int _score = 0;
  late ShapeModel _target;
  bool _found = false;

  @override
  void initState() {
    super.initState();
    _newRound();
  }

  void _newRound() {
    _round++;
    _found = false;
    _target = ShapeData.items[_random.nextInt(ShapeData.items.length)];
    TtsHelper().speak('Can you find the ${_target.name}?');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: Text('Shape Hunt — Score: $_score'),
        backgroundColor: const Color(0xFF7AD0FF),
        foregroundColor: const Color(0xFF001E2C),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.goNamed('shapes-hub')),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Text('Find the shape!', style: AppTypography.headlineLgMobile.copyWith(color: AppColors.onSurface)),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF7AD0FF),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Text(_target.emoji, style: const TextStyle(fontSize: 32)),
                  const SizedBox(width: 12),
                  Text(_target.name, style: AppTypography.headlineLg.copyWith(color: const Color(0xFF001E2C))),
                ]),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.5,
                  children: ShapeData.items.map((s) {
                    final isTarget = s.id == _target.id;
                    return GestureDetector(
                      onTap: () {
                        if (_found) return;
                        setState(() {
                          _found = true;
                          if (isTarget) { _score++; TtsHelper().speak('Found ${_target.name}!'); }
                          else { TtsHelper().speak('That\'s a ${s.name}!'); }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF7AD0FF).withValues(alpha: isTarget && _found ? 1 : 0.4),
                          borderRadius: BorderRadius.circular(s.id == 'circle' || s.id == 'oval' ? 40 : 12),
                          border: Border.all(
                            color: _found && isTarget ? Colors.green : Colors.white,
                            width: _found && isTarget ? 4 : 2,
                          ),
                        ),
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Text(s.emoji, style: TextStyle(fontSize: isTarget && _found ? 48 : 36)),
                          Text(s.name, style: const TextStyle(color: Color(0xFF001E2C))),
                        ]),
                      ),
                    );
                  }).toList(),
                ),
              ),
              if (_found) ...[
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: _round >= 5 ? () => context.goNamed('shape-celebration') : _newRound,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF7AD0FF),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFF004E6B), width: 3),
                    ),
                    child: Text(
                      _round >= 5 ? 'Finish' : 'Next Hunt',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF001E2C)),
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
