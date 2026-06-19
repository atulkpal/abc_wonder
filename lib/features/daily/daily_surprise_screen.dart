import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:abc_wonder/core/theme/typography.dart';

class DailySurpriseScreen extends StatefulWidget {
  const DailySurpriseScreen({super.key});

  @override
  State<DailySurpriseScreen> createState() => _DailySurpriseScreenState();
}

class _DailySurpriseScreenState extends State<DailySurpriseScreen>
    with SingleTickerProviderStateMixin {
  bool _claimed = false;
  bool _revealed = false;
  late AnimationController _pulseCtrl;
  late Animation<double> _pulseAnim;

  final _prizes = [
    ('⭐', '10 Stars', 'Great work today!'),
    ('🌟', '15 Stars', 'Keep it up!'),
    ('💎', 'Special Gem', 'A shiny surprise!'),
    ('🎉', 'Bonus Celebration', 'Party time!'),
    ('🦋', 'Magic Butterfly', 'A visitor from the garden!'),
    ('🍭', 'Candy Treat', 'Sweet!'),
  ];

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _pulseAnim = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut),
    );
    _pulseCtrl.repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
  }

  void _claim() {
    if (_claimed) return;
    setState(() => _claimed = true);
    _pulseCtrl.stop();
    _pulseCtrl.reset();
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) setState(() => _revealed = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final prize = _prizes[DateTime.now().millisecondsSinceEpoch ~/ 86400000 % _prizes.length];

    return Scaffold(
      backgroundColor: const Color(0xFF1A0A2E),
      body: SafeArea(
        child: Column(
          children: [
            _DSTopBar(),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (!_claimed) ...[
                        const Text('🌟', style: TextStyle(fontSize: 24)),
                        const SizedBox(height: 8),
                        Text(
                          'Daily Surprise',
                          style: AppTypography.displayHero.copyWith(
                            color: Colors.white,
                            fontSize: 32,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Come back every day for a reward!',
                          style: TextStyle(color: Colors.white54, fontSize: 14),
                        ),
                        const SizedBox(height: 40),
                        GestureDetector(
                          onTap: _claim,
                          child: ScaleTransition(
                            scale: _pulseAnim,
                            child: Container(
                              width: 120, height: 120,
                              decoration: BoxDecoration(
                                gradient: const RadialGradient(
                                  colors: [Color(0xFFFFD700), Color(0xFFFF8C00)],
                                ),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.amber.withValues(alpha: 0.4),
                                    blurRadius: 24,
                                    spreadRadius: 4,
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Text('🎁', style: TextStyle(fontSize: 48)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text('Tap the gift!', style: TextStyle(color: Colors.amber.shade200, fontSize: 16)),
                      ],
                      if (_claimed && !_revealed)
                        const Column(
                          children: [
                            Text('🎁', style: TextStyle(fontSize: 80)),
                            SizedBox(height: 16),
                            Text('Opening...', style: TextStyle(color: Colors.white54, fontSize: 18)),
                          ],
                        ),
                      if (_revealed) ...[
                        Text(prize.$1, style: const TextStyle(fontSize: 80)),
                        const SizedBox(height: 16),
                        Text(
                          prize.$2,
                          style: AppTypography.displayHero.copyWith(
                            color: Colors.amber,
                            fontSize: 32,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          prize.$3,
                          style: TextStyle(color: Colors.white54, fontSize: 16),
                        ),
                        const SizedBox(height: 32),
                        ElevatedButton(
                          onPressed: () => context.goNamed('home'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                            foregroundColor: const Color(0xFF001E2C),
                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          ),
                          child: const Text('Back to Home'),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DSTopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64, padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white, size: 32), onPressed: () => context.goNamed('home'), padding: EdgeInsets.zero, constraints: const BoxConstraints(minWidth: 64, minHeight: 64)),
          Flexible(child: Text('Daily Surprise', overflow: TextOverflow.ellipsis, style: AppTypography.headlineLgMobile.copyWith(color: Colors.white, fontSize: 24))),
          const SizedBox(width: 64),
        ],
      ),
    );
  }
}
