import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:abc_wonder/core/theme/typography.dart';

class TreasureChestScreen extends StatefulWidget {
  const TreasureChestScreen({super.key});

  @override
  State<TreasureChestScreen> createState() => _TreasureChestScreenState();
}

class _TreasureChestScreenState extends State<TreasureChestScreen>
    with SingleTickerProviderStateMixin {
  bool _isOpen = false;
  bool _hasRevealed = false;
  late AnimationController _bounceCtrl;
  late Animation<double> _bounceAnim;

  final _rng = Random();
  late final String _reward;
  late final String _rewardEmoji;

  static const _rewards = [
    ('🎉', 'You earned 10 stars!'),
    ('🌟', 'Great job today!'),
    ('🏆', 'You are a champion!'),
    ('💎', 'Special gem unlocked!'),
    ('🌈', 'Rainbow power activated!'),
    ('🦋', 'A magical butterfly!'),
    ('🎪', 'Circus surprise!'),
    ('🚀', 'Rocket boost!'),
  ];

  @override
  void initState() {
    super.initState();
    final pick = _rewards[_rng.nextInt(_rewards.length)];
    _rewardEmoji = pick.$1;
    _reward = pick.$2;
    _bounceCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _bounceAnim = Tween<double>(begin: 0, end: -20).animate(
      CurvedAnimation(parent: _bounceCtrl, curve: Curves.elasticIn),
    );
    _bounceCtrl.repeat(reverse: true);
  }

  @override
  void dispose() {
    _bounceCtrl.dispose();
    super.dispose();
  }

  void _openChest() {
    if (_isOpen) return;
    setState(() => _isOpen = true);
    _bounceCtrl.stop();
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) setState(() => _hasRevealed = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A0A2E),
      body: SafeArea(
        child: Column(
          children: [
            _ChestTopBar(),
            Expanded(
              child: Center(
                child: _hasRevealed ? _buildRevealed() : _buildChest(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChest() {
    return GestureDetector(
      onTap: _openChest,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _bounceAnim,
            builder: (_, child) => Transform.translate(
              offset: Offset(0, _bounceAnim.value),
              child: child,
            ),
            child: Text(
              '📦',
              style: TextStyle(fontSize: _isOpen ? 60 : 80),
            ),
          ),
          const SizedBox(height: 24),
          if (!_isOpen)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.amber.withValues(alpha: 0.3),
                    blurRadius: 16,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: Text(
                'Tap to open!',
                style: AppTypography.headlineLgMobile.copyWith(
                  color: const Color(0xFF001E2C),
                  fontSize: 24,
                ),
              ),
            ),
          if (_isOpen && !_hasRevealed)
            const Text(
              'Opening...',
              style: TextStyle(color: Colors.white54, fontSize: 18),
            ),
        ],
      ),
    );
  }

  Widget _buildRevealed() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(_rewardEmoji, style: const TextStyle(fontSize: 80)),
        const SizedBox(height: 16),
        Text(
          _reward,
          style: AppTypography.displayHero.copyWith(
            color: Colors.amber,
            fontSize: 28,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _isOpen = false;
              _hasRevealed = false;
              final pick = _rewards[_rng.nextInt(_rewards.length)];
              _rewardEmoji = pick.$1;
              _reward = pick.$2;
              _bounceCtrl.repeat(reverse: true);
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            foregroundColor: const Color(0xFF001E2C),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          ),
          child: const Text('Open Again'),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () => context.goNamed('home'),
          child: const Text('Back to Home', style: TextStyle(color: Colors.white54)),
        ),
      ],
    );
  }
}

class _ChestTopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 32),
            onPressed: () => context.goNamed('home'),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 64, minHeight: 64),
          ),
          Flexible(
            child: Text(
              'Treasure Chest',
              overflow: TextOverflow.ellipsis,
              style: AppTypography.headlineLgMobile.copyWith(
                color: Colors.white,
                fontSize: 28,
              ),
            ),
          ),
          const SizedBox(width: 64),
        ],
      ),
    );
  }
}


