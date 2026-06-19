import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:abc_wonder/core/theme/colors.dart';
import 'package:abc_wonder/core/theme/typography.dart';
import 'package:abc_wonder/core/widgets/rim_card.dart';
import 'package:abc_wonder/utils/tts_helper.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late double _ttsRate;
  bool _soundFx = true;

  @override
  void initState() {
    super.initState();
    _ttsRate = TtsHelper().rate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            _SettingsTopBar(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  _Card(
                    child: Column(
                      children: [
                        _SettingSlider(
                          icon: Icons.speed,
                          title: 'Speech Rate',
                          subtitle: 'Narrator speaking speed',
                          value: _ttsRate,
                          min: 0.2, max: 0.8,
                          display: '${_ttsRate.toStringAsFixed(1)}x',
                          onChanged: (v) {
                            setState(() => _ttsRate = v);
                            TtsHelper().setRate(v);
                          },
                        ),
                        Divider(height: 1, color: AppColors.onSurface.withValues(alpha: 0.1)),
                        ListTile(
                          title: Text('Sound Effects', style: AppTypography.labelBold.copyWith(color: AppColors.onSurface, fontSize: 16)),
                          subtitle: Text('Toggle sound effects', style: TextStyle(color: AppColors.onSurfaceVariant, fontSize: 12)),
                          trailing: Switch(
                            value: _soundFx,
                            activeTrackColor: AppColors.primary,
                            onChanged: (v) => setState(() => _soundFx = v),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _Card(
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.info_outline, color: AppColors.onSurfaceVariant),
                          title: Text('Version', style: AppTypography.labelBold.copyWith(color: AppColors.onSurface)),
                          trailing: Text('1.0.0', style: TextStyle(color: AppColors.onSurfaceVariant)),
                        ),
                        Divider(height: 1, color: AppColors.onSurface.withValues(alpha: 0.1)),
                        ListTile(
                          leading: Icon(Icons.style, color: AppColors.onSurfaceVariant),
                          title: Text('Style Guide', style: AppTypography.labelBold.copyWith(color: AppColors.onSurface)),
                          trailing: Icon(Icons.chevron_right, color: AppColors.onSurfaceVariant),
                          onTap: () => context.goNamed('style-guide'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: TextButton.icon(
                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                      label: Text('Reset All Data', style: TextStyle(color: Colors.redAccent)),
                      onPressed: () => _confirmReset(context),
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
        title: const Text('Reset All Data?'),
        content: const Text('This will clear all progress and settings. Cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('All data reset')),
              );
            },
            child: const Text('Reset', style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }
}

class _SettingsTopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64, padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [BoxShadow(color: AppColors.onSurface.withValues(alpha: 0.06), blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(icon: Icon(Icons.arrow_back, color: AppColors.primary, size: 32), onPressed: () => context.goNamed('home'), padding: EdgeInsets.zero, constraints: const BoxConstraints(minWidth: 64, minHeight: 64)),
          Flexible(child: Text('Settings', overflow: TextOverflow.ellipsis, style: AppTypography.headlineLgMobile.copyWith(color: AppColors.primary, fontSize: 28))),
          const SizedBox(width: 64),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return RimCard(
      backgroundColor: AppColors.surfaceContainer,
      borderColor: AppColors.onSurface.withValues(alpha: 0.1),
      child: child,
    );
  }
}

class _SettingSlider extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final double value;
  final double min;
  final double max;
  final String display;
  final ValueChanged<double> onChanged;

  const _SettingSlider({
    required this.icon, required this.title, required this.subtitle,
    required this.value, required this.min, required this.max,
    required this.display, required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primary, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTypography.labelBold.copyWith(color: AppColors.onSurface, fontSize: 16)),
                    Text(subtitle, style: TextStyle(color: AppColors.onSurfaceVariant, fontSize: 12)),
                  ],
                ),
              ),
              Text(display, style: AppTypography.labelBold.copyWith(color: AppColors.primary, fontSize: 18)),
            ],
          ),
          Slider(
            value: value, min: min, max: max,
            divisions: 6,
            activeColor: AppColors.primary,
            inactiveColor: AppColors.onSurface.withValues(alpha: 0.1),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
