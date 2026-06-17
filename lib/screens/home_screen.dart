import 'package:flutter/material.dart';
import 'package:abc_wonder/theme/app_theme.dart';
import 'package:abc_wonder/screens/detail_screen.dart';
import 'package:abc_wonder/data/alphabet_data.dart';
import 'package:abc_wonder/data/number_data.dart';
import 'package:abc_wonder/data/days_data.dart';
import 'package:abc_wonder/data/months_data.dart';
import 'package:abc_wonder/widgets/category_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'ABC Wonder',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'What would you like to learn today?',
                style: TextStyle(
                  fontSize: 16,
                  color: AppTheme.textPrimary.withValues(alpha: 0.6),
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    int crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;
                    return GridView.count(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 1.0,
                      children: [
                        CategoryTile(
                          emoji: '🔤',
                          label: 'Alphabet',
                          subtitle: 'A to Z',
                          color: AppTheme.alphabetColor,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailScreen(
                                items: AlphabetData.items,
                                title: 'Alphabet',
                              ),
                            ),
                          ),
                        ),
                        CategoryTile(
                          emoji: '🔢',
                          label: 'Numbers',
                          subtitle: '1 to 100',
                          color: AppTheme.numberColor,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailScreen(
                                items: NumberData.items,
                                title: 'Numbers',
                              ),
                            ),
                          ),
                        ),
                        CategoryTile(
                          emoji: '📅',
                          label: 'Days',
                          subtitle: 'Week days',
                          color: AppTheme.daysColor,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailScreen(
                                items: DaysData.items,
                                title: 'Days',
                              ),
                            ),
                          ),
                        ),
                        CategoryTile(
                          emoji: '🗓️',
                          label: 'Months',
                          subtitle: '12 months',
                          color: AppTheme.monthsColor,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailScreen(
                                items: MonthsData.items,
                                title: 'Months',
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
