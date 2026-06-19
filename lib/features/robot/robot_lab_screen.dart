import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:abc_wonder/core/theme/typography.dart';

class RobotLabScreen extends StatefulWidget {
  const RobotLabScreen({super.key});

  @override
  State<RobotLabScreen> createState() => _RobotLabScreenState();
}

class _RobotLabScreenState extends State<RobotLabScreen> {
  int _bodyColor = 0;
  int _eyeStyle = 0;
  int _accessory = 0;

  static const _bodyColors = [
    Color(0xFF40C4FF),
    Color(0xFFFDD400),
    Color(0xFFFF9BB2),
    Color(0xFF7AD0FF),
    Color(0xFF7AE07A),
    Color(0xFFFF8C4D),
  ];

  static const _eyes = ['👀', '😊', '😎', '🤩', '👁️'];
  static const _accessories = ['⚡', '🎩', '🦋', '👑', '🌈'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1628),
      body: SafeArea(
        child: Column(
          children: [
            _RLTopBar(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  _buildPreview(),
                  const SizedBox(height: 32),
                  _buildSection('Body Color', _bodyColors.length, (i) => GestureDetector(
                    onTap: () => setState(() => _bodyColor = i),
                    child: Container(
                      width: 48, height: 48,
                      decoration: BoxDecoration(
                        color: _bodyColors[i],
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _bodyColor == i ? Colors.white : Colors.transparent,
                          width: 3,
                        ),
                        boxShadow: _bodyColor == i
                            ? [BoxShadow(color: _bodyColors[i].withValues(alpha: 0.5), blurRadius: 12)]
                            : null,
                      ),
                      child: _bodyColor == i ? const Icon(Icons.check, color: Colors.white, size: 20) : null,
                    ),
                  )),
                  const SizedBox(height: 24),
                  _buildSection('Eyes', _eyes.length, (i) => GestureDetector(
                    onTap: () => setState(() => _eyeStyle = i),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _eyeStyle == i ? Colors.white12 : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _eyeStyle == i ? const Color(0xFF40C4FF) : Colors.white12,
                        ),
                      ),
                      child: Text(_eyes[i], style: const TextStyle(fontSize: 28)),
                    ),
                  )),
                  const SizedBox(height: 24),
                  _buildSection('Accessories', _accessories.length, (i) => GestureDetector(
                    onTap: () => setState(() => _accessory = i),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _accessory == i ? Colors.white12 : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _accessory == i ? const Color(0xFF40C4FF) : Colors.white12,
                        ),
                      ),
                      child: Text(_accessories[i], style: const TextStyle(fontSize: 28)),
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreview() {
    return Center(
      child: Column(
        children: [
          Container(
            width: 120, height: 120,
            decoration: BoxDecoration(
              color: _bodyColors[_bodyColor],
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: _bodyColors[_bodyColor].withValues(alpha: 0.4),
                  blurRadius: 24,
                  spreadRadius: 4,
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text(_eyes[_eyeStyle], style: const TextStyle(fontSize: 32)),
                Positioned(
                  top: 0, right: 0,
                  child: Text(_accessories[_accessory], style: const TextStyle(fontSize: 24)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text('Your Robot', style: AppTypography.labelBold.copyWith(color: Colors.white54, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildSection(String title, int count, Widget Function(int) itemBuilder) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTypography.labelBold.copyWith(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: List.generate(count, itemBuilder),
        ),
      ],
    );
  }
}

class _RLTopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64, padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: Color(0xFF0A1628),
        border: Border(bottom: BorderSide(color: Colors.white12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white, size: 32), onPressed: () => context.goNamed('home'), padding: EdgeInsets.zero, constraints: const BoxConstraints(minWidth: 64, minHeight: 64)),
          Flexible(child: Text('Robot Lab', overflow: TextOverflow.ellipsis, style: AppTypography.headlineLgMobile.copyWith(color: Colors.white, fontSize: 28))),
          const SizedBox(width: 64),
        ],
      ),
    );
  }
}
