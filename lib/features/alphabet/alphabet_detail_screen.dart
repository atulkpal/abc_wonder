import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:abc_wonder/core/theme/colors.dart';
import 'package:abc_wonder/core/theme/typography.dart';
import 'package:abc_wonder/core/widgets/pressable_3d.dart';
import 'package:abc_wonder/core/widgets/bead_progress.dart';
import 'package:abc_wonder/core/widgets/wiggle_animation.dart';
import 'package:abc_wonder/core/widgets/animated_float.dart';
import 'package:abc_wonder/core/widgets/sparkle_overlay.dart';
import 'package:abc_wonder/core/widgets/prime_rim.dart';
import 'package:abc_wonder/data/static/alphabet_data.dart';
import 'package:abc_wonder/data/models/letter_model.dart';
import 'package:abc_wonder/utils/tts_helper.dart';

class AlphabetDetailScreen extends StatefulWidget {
  final String letterId;

  const AlphabetDetailScreen({super.key, required this.letterId});

  @override
  State<AlphabetDetailScreen> createState() => _AlphabetDetailScreenState();
}

class _AlphabetDetailScreenState extends State<AlphabetDetailScreen> {
  late LetterModel _letter;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _letter = AlphabetData.byId(widget.letterId) ?? AlphabetData.items[0];
    _currentIndex = _letter.index;
  }

  void _playTts(String text) {
    TtsHelper().speak(text);
  }

  void _goLetter(int index) {
    if (index < 0 || index >= AlphabetData.items.length) return;
    final next = AlphabetData.items[index];
    context.goNamed('alphabet-detail', pathParameters: {'letter': next.id});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            _DetailTopBar(letter: _letter, onRobotTap: () => _playTts(_letter.ttsText)),
            Expanded(
              child: SparkleOverlay(
                child: Stack(
                  children: [
                    Positioned(
                      bottom: -40,
                      left: -40,
                      child: Container(
                        width: 384,
                        height: 384,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.secondaryContainer.withValues(alpha: 0.2),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 120),
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          _LetterTiles(
                            letter: _letter,
                            onUppercaseTap: () => _playTts(_letter.character),
                            onLowercaseTap: () => _playTts(_letter.character.toLowerCase()),
                          ),
                          const SizedBox(height: 32),
                          _WordBanner(
                            word: _letter.example.toUpperCase(),
                            onPlayTap: () => _playTts(_letter.example),
                          ),
                          const SizedBox(height: 24),
                          _CharacterScene(
                            emoji: _letter.emoji,
                            onTap: () => _playTts(_letter.ttsText),
                          ),
                          const SizedBox(height: 32),
                          _RobotBubble(
                            message: '${_letter.character} is for ${_letter.example}!',
                            onTap: () => _playTts(_letter.ttsText),
                          ),
                          const SizedBox(height: 24),
                          BeadProgress(
                            total: AlphabetData.items.length,
                            current: _currentIndex,
                            activeColor: AppColors.primaryContainer,
                            inactiveColor: AppColors.surfaceVariant,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _DetailBottomNav(
        currentIndex: _currentIndex,
        total: AlphabetData.items.length,
        onBack: () {
          if (_currentIndex > 0) _goLetter(_currentIndex - 1);
        },
        onHub: () => context.goNamed('alphabet-hub'),
        onNext: () {
          if (_currentIndex < AlphabetData.items.length - 1) {
            _goLetter(_currentIndex + 1);
          } else {
            context.goNamed('alphabet-celebration');
          }
        },
      ),
    );
  }
}

class _DetailTopBar extends StatelessWidget {
  final LetterModel letter;
  final VoidCallback onRobotTap;
  const _DetailTopBar({required this.letter, required this.onRobotTap});

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
            icon: Icon(Icons.arrow_back, color: AppColors.primary, size: 32),
            onPressed: () => context.goNamed('alphabet-hub'),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 64, minHeight: 64),
          ),
          Flexible(
            child: Text(
              'Alphabet Adventure',
              overflow: TextOverflow.ellipsis,
              style: AppTypography.headlineLgMobile.copyWith(
                color: AppColors.primary,
                fontSize: 28,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.smart_toy, color: AppColors.primary, size: 32),
            onPressed: onRobotTap,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 64, minHeight: 64),
          ),
        ],
      ),
    );
  }
}

class _LetterTiles extends StatelessWidget {
  final LetterModel letter;
  final VoidCallback onUppercaseTap;
  final VoidCallback onLowercaseTap;
  const _LetterTiles({
    required this.letter,
    required this.onUppercaseTap,
    required this.onLowercaseTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Pressable3D(
          onTap: onUppercaseTap,
          child: RimDecoration(
            rimColor: const Color(0xFF004C69),
            backgroundColor: AppColors.primaryContainer,
            borderRadius: 12,
            padding: const EdgeInsets.all(24),
            child: Text(
              letter.character,
              style: AppTypography.displayHero.copyWith(
                color: AppColors.onPrimaryContainer,
                fontSize: 48,
              ),
            ),
          ),
        ),
        const SizedBox(width: 32),
        Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Pressable3D(
            onTap: onLowercaseTap,
            child: RimDecoration(
              rimColor: const Color(0xFF544600),
              backgroundColor: AppColors.secondaryContainer,
              borderRadius: 12,
              padding: const EdgeInsets.all(16),
              child: Text(
                letter.character.toLowerCase(),
                style: AppTypography.displayHero.copyWith(
                  color: AppColors.onSecondaryContainer,
                  fontSize: 40,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _WordBanner extends StatelessWidget {
  final String word;
  final VoidCallback onPlayTap;
  const _WordBanner({required this.word, required this.onPlayTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(48),
        border: Border.all(color: Colors.white, width: 4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            word,
            style: AppTypography.displayHero.copyWith(
              fontSize: 40,
              color: AppColors.primary,
              letterSpacing: 4,
            ),
          ),
          const SizedBox(width: 16),
          Pressable3D(
            onTap: onPlayTap,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(Icons.volume_up, color: Colors.white, size: 24),
            ),
          ),
        ],
      ),
    );
  }
}

class _CharacterScene extends StatelessWidget {
  final String emoji;
  final VoidCallback onTap;

  const _CharacterScene({required this.emoji, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 0,
            bottom: 0,
            child: Container(
              width: 150,
              height: 200,
              decoration: BoxDecoration(
                color: AppColors.secondaryContainer.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(32),
              ),
              child: Center(
                child: Text('🌳', style: TextStyle(fontSize: 80)),
              ),
            ),
          ),
          WiggleAnimation(
            onTap: onTap,
            child: AnimatedFloat(
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryContainer.withValues(alpha: 0.1),
                ),
                child: Center(
                  child: Text(emoji, style: TextStyle(fontSize: 100)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RobotBubble extends StatelessWidget {
  final String message;
  final VoidCallback onTap;
  const _RobotBubble({required this.message, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Pressable3D(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text('🤖', style: TextStyle(fontSize: 32)),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.primaryContainer,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Text(
              message,
              style: AppTypography.labelBold.copyWith(
                color: AppColors.onPrimaryContainer,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailBottomNav extends StatelessWidget {
  final int currentIndex;
  final int total;
  final VoidCallback onBack;
  final VoidCallback onHub;
  final VoidCallback onNext;

  const _DetailBottomNav({
    required this.currentIndex,
    required this.total,
    required this.onBack,
    required this.onHub,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.15),
            blurRadius: 40,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _DetailNavItem(
            icon: Icons.arrow_back_ios,
            label: 'Back',
            onTap: onBack,
          ),
          _DetailNavItem(
            icon: Icons.home,
            label: 'Hub',
            isActive: true,
            onTap: onHub,
          ),
          _DetailNavItem(
            icon: Icons.arrow_forward_ios,
            label: currentIndex == total - 1 ? 'Done' : 'Next',
            onTap: onNext,
          ),
        ],
      ),
    );
  }
}

class _DetailNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _DetailNavItem({
    required this.icon,
    required this.label,
    this.isActive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (isActive) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.primaryContainer,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF004C69),
                blurRadius: 0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Transform.translate(
            offset: const Offset(0, -4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: AppColors.onPrimaryContainer, size: 28),
                const SizedBox(height: 4),
                Text(label, style: AppTypography.labelBold.copyWith(
                  color: AppColors.onPrimaryContainer, fontSize: 18,
                )),
              ],
            ),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.onSurfaceVariant, size: 28),
            const SizedBox(height: 4),
            Text(label, style: AppTypography.labelBold.copyWith(
              color: AppColors.onSurfaceVariant, fontSize: 18,
            )),
          ],
        ),
      ),
    );
  }
}
