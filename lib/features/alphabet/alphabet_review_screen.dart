import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:abc_wonder/core/theme/colors.dart';
import 'package:abc_wonder/core/theme/typography.dart';
import 'package:abc_wonder/core/widgets/rim_card.dart';
import 'package:abc_wonder/data/static/alphabet_data.dart';
import 'package:abc_wonder/utils/tts_helper.dart';

class AlphabetReviewScreen extends StatelessWidget {
  const AlphabetReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: const Text('Letter Review'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.goNamed('alphabet-hub'),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(24),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isTablet ? 6 : 4,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1,
        ),
        itemCount: AlphabetData.items.length,
        itemBuilder: (context, index) {
          final letter = AlphabetData.items[index];
          return RimCard(
            onTap: () => TtsHelper().speak('${letter.name} for ${letter.example}'),
            backgroundColor: AppColors.primaryContainer,
            borderColor: const Color(0xFF004E6B),
            child: Center(
              child: Text(
                letter.character,
                style: AppTypography.displayHero.copyWith(
                  color: AppColors.onPrimaryContainer,
                  fontSize: 36,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
