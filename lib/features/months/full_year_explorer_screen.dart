import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:abc_wonder/core/theme/colors.dart';
import 'package:abc_wonder/core/theme/typography.dart';
import 'package:abc_wonder/data/static/months_data.dart';
import 'package:abc_wonder/data/models/month_model.dart';
import 'package:abc_wonder/utils/tts_helper.dart';

class FullYearExplorerScreen extends StatefulWidget {
  const FullYearExplorerScreen({super.key});

  @override
  State<FullYearExplorerScreen> createState() => _FullYearExplorerScreenState();
}

class _FullYearExplorerScreenState extends State<FullYearExplorerScreen> {
  final PageController _pageCtrl = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            _ExplorerTopBar(),
            Expanded(
              child: PageView.builder(
                controller: _pageCtrl,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemCount: MonthsData.items.length,
                itemBuilder: (_, i) => _MonthPage(month: MonthsData.items[i]),
              ),
            ),
            _PageIndicator(
              currentIndex: _currentPage,
              total: MonthsData.items.length,
              months: MonthsData.items,
            ),
          ],
        ),
      ),
    );
  }
}

class _ExplorerTopBar extends StatelessWidget {
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
            icon: const Icon(Icons.arrow_back, color: Color(0xFF3F0018), size: 32),
            onPressed: () => context.goNamed('months-hub'),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 64, minHeight: 64),
          ),
          Flexible(
            child: Text(
              'Full Year',
              overflow: TextOverflow.ellipsis,
              style: AppTypography.headlineLgMobile.copyWith(
                color: const Color(0xFF3F0018),
                fontSize: 28,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.smart_toy, color: Color(0xFF3F0018), size: 32),
            onPressed: () => context.goNamed('robot-lab'),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 64, minHeight: 64),
          ),
        ],
      ),
    );
  }
}

class _MonthPage extends StatelessWidget {
  final MonthModel month;
  const _MonthPage({required this.month});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [month.seasonGradientStart, month.seasonGradientEnd],
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(month.emoji, style: const TextStyle(fontSize: 80)),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () => TtsHelper().speak(month.ttsText),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      month.name,
                      style: AppTypography.displayHero.copyWith(
                        color: const Color(0xFF001E2C),
                        fontSize: 40,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.3),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.volume_up,
                        color: Color(0xFF001E2C),
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Season: ${month.season}',
                  style: AppTypography.labelBold.copyWith(
                    color: const Color(0xFF001E2C),
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${month.shortName} — Month ${month.index} of 12',
                  style: AppTypography.labelBold.copyWith(
                    color: const Color(0xFF001E2C).withValues(alpha: 0.7),
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  final int currentIndex;
  final int total;
  final List<MonthModel> months;

  const _PageIndicator({
    required this.currentIndex,
    required this.total,
    required this.months,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 24),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(total, (i) {
          final isActive = i == currentIndex;
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  months[i].shortName,
                  style: AppTypography.labelBold.copyWith(
                    color: isActive ? const Color(0xFF3F0018) : Colors.grey,
                    fontSize: isActive ? 14 : 11,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  width: isActive ? 12 : 8,
                  height: isActive ? 12 : 8,
                  decoration: BoxDecoration(
                    color: isActive ? const Color(0xFF3F0018) : Colors.grey.withValues(alpha: 0.4),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
