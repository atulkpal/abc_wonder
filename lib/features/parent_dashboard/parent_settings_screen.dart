import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:abc_wonder/core/theme/typography.dart';
import 'package:abc_wonder/core/widgets/rim_card.dart';
import 'package:abc_wonder/utils/tts_helper.dart';

class ParentSettingsScreen extends StatefulWidget {
  const ParentSettingsScreen({super.key});

  @override
  State<ParentSettingsScreen> createState() => _ParentSettingsScreenState();
}

class _ParentSettingsScreenState extends State<ParentSettingsScreen> {
  double _ttsRate = TtsHelper().rate;
  bool _soundEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: SafeArea(
        child: Column(
          children: [
            _PSTopBar(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  _SectionHeader(title: 'TTS Settings'),
                  const SizedBox(height: 8),
                  RimCard(
                    backgroundColor: const Color(0xFF16213E),
                    borderColor: Colors.white12,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Speech Rate', style: AppTypography.labelBold.copyWith(color: Colors.white, fontSize: 16)),
                          const SizedBox(height: 4),
                          Text('Adjust how fast the narrator speaks', style: const TextStyle(color: Colors.white38, fontSize: 12)),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Text('🐢', style: TextStyle(fontSize: 20)),
                              Expanded(
                                child: Slider(
                                  value: _ttsRate,
                                  min: 0.2,
                                  max: 0.8,
                                  divisions: 6,
          activeColor: const Color(0xFF40C4FF),
                                  inactiveColor: Colors.white12,
                                  onChanged: (v) {
                                    setState(() => _ttsRate = v);
                                    TtsHelper().setRate(v);
                                  },
                                ),
                              ),
                              const Text('🐇', style: TextStyle(fontSize: 20)),
                            ],
                          ),
                          Center(
                            child: Text(
                              '${_ttsRate.toStringAsFixed(1)}x',
                              style: AppTypography.labelBold.copyWith(color: const Color(0xFF40C4FF), fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _SectionHeader(title: 'Preferences'),
                  const SizedBox(height: 8),
                  RimCard(
                    backgroundColor: const Color(0xFF16213E),
                    borderColor: Colors.white12,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text('Sound Effects', style: AppTypography.labelBold.copyWith(color: Colors.white, fontSize: 16)),
                          subtitle: const Text('Toggle sound effects on/off', style: TextStyle(color: Colors.white38, fontSize: 12)),
                          trailing: Switch(
                            value: _soundEnabled,
                            activeTrackColor: const Color(0xFF40C4FF),
                            onChanged: (v) => setState(() => _soundEnabled = v),
                          ),
                        ),
                        const Divider(color: Colors.white10, height: 1),
                        ListTile(
                          title: Text('Reset Progress', style: AppTypography.labelBold.copyWith(color: Colors.redAccent, fontSize: 16)),
                          subtitle: const Text('Clear all learning data', style: TextStyle(color: Colors.white38, fontSize: 12)),
                          leading: const Icon(Icons.delete_forever, color: Colors.redAccent),
                          onTap: () => _confirmReset(context),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _SectionHeader(title: 'About'),
                  const SizedBox(height: 8),
                  RimCard(
                    backgroundColor: const Color(0xFF16213E),
                    borderColor: Colors.white12,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _AboutRow(label: 'App', value: 'ABC Wonder'),
                          const Divider(color: Colors.white10, height: 16),
                          _AboutRow(label: 'Version', value: '1.0.0'),
                          const Divider(color: Colors.white10, height: 16),
                          _AboutRow(label: 'Target Age', value: '2-4 years'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmReset(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Reset Progress?'),
        content: const Text('This will clear all learning data. This cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Progress reset')),
              );
            },
            child: const Text('Reset', style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }
}

class _PSTopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64, padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(color: Color(0xFF1A1A2E), border: Border(bottom: BorderSide(color: Colors.white12))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white, size: 32), onPressed: () => context.goNamed('parent-dashboard'), padding: EdgeInsets.zero, constraints: const BoxConstraints(minWidth: 64, minHeight: 64)),
          Flexible(child: Text('Settings', overflow: TextOverflow.ellipsis, style: AppTypography.headlineLgMobile.copyWith(color: Colors.white, fontSize: 28))),
          const SizedBox(width: 64),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title, style: AppTypography.labelBold.copyWith(color: const Color(0xFF40C4FF), fontSize: 14));
  }
}

class _AboutRow extends StatelessWidget {
  final String label;
  final String value;
  const _AboutRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.white54, fontSize: 14)),
        Text(value, style: AppTypography.labelBold.copyWith(color: Colors.white, fontSize: 14)),
      ],
    );
  }
}
