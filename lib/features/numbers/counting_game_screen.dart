import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:abc_wonder/core/theme/colors.dart';
import 'package:abc_wonder/core/theme/typography.dart';
import 'package:abc_wonder/core/widgets/rim_card.dart';
import 'package:abc_wonder/utils/tts_helper.dart';

class CountingGameScreen extends StatefulWidget {
  const CountingGameScreen({super.key});

  @override
  State<CountingGameScreen> createState() => _CountingGameScreenState();
}

class _CountingGameScreenState extends State<CountingGameScreen> {
  int _target = 3;
  int _counted = 0;
  final List<_CountingItem> _items = [];
  bool _completed = false;

  @override
  void initState() {
    super.initState();
    _newRound();
  }

  void _newRound() {
    _target = (DateTime.now().millisecondsSinceEpoch % 5) + 2;
    _counted = 0;
    _completed = false;
    _items.clear();
    for (int i = 0; i < _target + 2; i++) {
      _items.add(_CountingItem(tapped: false));
    }
    _items.shuffle();
  }

  void _tapItem(int index) {
    if (_completed || _items[index].tapped) return;
    setState(() {
      _items[index] = _CountingItem(tapped: true);
      _counted++;
      TtsHelper().speak('$_counted');
      if (_counted >= _target) {
        _completed = true;
        TtsHelper().speak('Great job! You counted $_target!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: const Text('Counting Game'),
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
                'Count the items!',
                style: AppTypography.headlineLgMobile.copyWith(color: AppColors.onSurface),
              ),
              const SizedBox(height: 8),
              Text(
                'Tap $_target items',
                style: AppTypography.bodyXl.copyWith(color: AppColors.onSurfaceVariant),
              ),
              const SizedBox(height: 32),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: List.generate(_items.length, (i) {
                  return GestureDetector(
                    onTap: () => _tapItem(i),
                    child: AnimatedScale(
                      scale: _items[i].tapped ? 0.8 : 1,
                      duration: const Duration(milliseconds: 200),
                      child: Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: _items[i].tapped
                              ? AppColors.surfaceVariant
                              : AppColors.secondaryContainer,
                          borderRadius: BorderRadius.circular(16),
                          border: _items[i].tapped
                              ? Border.all(color: AppColors.outline)
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            '🐶',
                            style: TextStyle(
                              fontSize: _items[i].tapped ? 24 : 32,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 32),
              Text(
                '$_counted / $_target',
                style: AppTypography.displayHero.copyWith(
                  color: _completed ? AppColors.secondary : AppColors.onSurface,
                  fontSize: 48,
                ),
              ),
              if (_completed) ...[
                const SizedBox(height: 24),
                Text(
                  '🎉 Great counting!',
                  style: AppTypography.headlineLg.copyWith(color: AppColors.secondary),
                ),
                const SizedBox(height: 16),
                RimCard(
                  onTap: _newRound,
                  backgroundColor: AppColors.secondaryContainer,
                  borderColor: const Color(0xFF6F5C00),
                  child: const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Play Again',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6F5C00),
                      ),
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

class _CountingItem {
  final bool tapped;
  const _CountingItem({required this.tapped});
}
