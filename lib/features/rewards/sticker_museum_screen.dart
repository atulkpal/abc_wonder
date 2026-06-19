import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:abc_wonder/core/theme/typography.dart';
import 'package:abc_wonder/core/widgets/rim_card.dart';
import 'package:abc_wonder/data/static/sticker_data.dart';
import 'package:abc_wonder/data/models/sticker_model.dart';

class StickerMuseumScreen extends StatefulWidget {
  const StickerMuseumScreen({super.key});

  @override
  State<StickerMuseumScreen> createState() => _StickerMuseumScreenState();
}

class _StickerMuseumScreenState extends State<StickerMuseumScreen> {
  String _selectedCategory = 'All';

  List<String> get _categories =>
      ['All', ...StickerData.categories.where((c) => c != 'Special'), 'Special'];

  List<StickerModel> get _filtered {
    if (_selectedCategory == 'All') return StickerData.items;
    return StickerData.byCategory(_selectedCategory);
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;
    return Scaffold(
      backgroundColor: const Color(0xFFF5E6CC),
      body: SafeArea(
        child: Column(
          children: [
            _StickerTopBar(),
            _CategoryTabs(
              categories: _categories,
              selected: _selectedCategory,
              onSelect: (c) => setState(() => _selectedCategory = c),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Row(
                children: [
                  Text(
                    '${StickerData.unlockedCount}/${StickerData.totalCount}',
                    style: AppTypography.labelBold.copyWith(
                      color: const Color(0xFF544600),
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'stickers collected',
                    style: AppTypography.labelBold.copyWith(
                      color: const Color(0xFF544600).withValues(alpha: 0.7),
                      fontSize: 14,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF544600).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _selectedCategory,
                      style: AppTypography.labelBold.copyWith(
                        color: const Color(0xFF544600),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isTablet ? 6 : 3,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.9,
                ),
                itemCount: _filtered.length,
                itemBuilder: (_, i) => _StickerCard(sticker: _filtered[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StickerTopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: const Color(0xFFF5E6CC),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF544600), size: 32),
            onPressed: () => context.goNamed('home'),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 64, minHeight: 64),
          ),
          Flexible(
            child: Text(
              'Sticker Museum',
              overflow: TextOverflow.ellipsis,
              style: AppTypography.headlineLgMobile.copyWith(
                color: const Color(0xFF544600),
                fontSize: 24,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.smart_toy, color: Color(0xFF544600), size: 32),
            onPressed: () => context.goNamed('robot-lab'),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 64, minHeight: 64),
          ),
        ],
      ),
    );
  }
}

class _CategoryTabs extends StatelessWidget {
  final List<String> categories;
  final String selected;
  final ValueChanged<String> onSelect;

  const _CategoryTabs({
    required this.categories,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: categories.map((c) {
          final isActive = c == selected;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: GestureDetector(
              onTap: () => onSelect(c),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  color: isActive ? const Color(0xFF544600) : const Color(0xFFEED9B7),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF544600).withValues(alpha: 0.3),
                  ),
                ),
                child: Text(
                  c,
                  style: AppTypography.labelBold.copyWith(
                    color: isActive ? Colors.white : const Color(0xFF544600),
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _StickerCard extends StatelessWidget {
  final StickerModel sticker;
  const _StickerCard({required this.sticker});

  @override
  Widget build(BuildContext context) {
    final isUnlocked = sticker.isUnlocked;
    return RimCard(
      backgroundColor: isUnlocked ? Colors.white : Colors.grey.shade200,
      borderColor: isUnlocked ? const Color(0xFF544600) : Colors.grey.shade400,
      child: Stack(
        children: [
          Center(
            child: Opacity(
              opacity: isUnlocked ? 1.0 : 0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(sticker.emoji, style: const TextStyle(fontSize: 36)),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      sticker.name,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.labelBold.copyWith(
                        color: isUnlocked ? const Color(0xFF001E2C) : Colors.grey,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (!isUnlocked)
            const Center(
              child: Icon(Icons.lock, color: Colors.grey, size: 20),
            ),
          if (isUnlocked && sticker.isFavorite)
            Positioned(
              top: 4,
              right: 4,
              child: GestureDetector(
                onTap: () => _toggleFavorite(context),
                child: const Icon(Icons.star, color: Color(0xFFFFD700), size: 18),
              ),
            ),
          if (isUnlocked && !sticker.isFavorite)
            Positioned(
              top: 4,
              right: 4,
              child: GestureDetector(
                onTap: () => _toggleFavorite(context),
                child: Icon(Icons.star_border, color: Colors.grey.shade500, size: 18),
              ),
            ),
        ],
      ),
    );
  }

  void _toggleFavorite(BuildContext context) {
    // Toggle favorite - would use state management in production
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(sticker.isFavorite ? 'Removed favorite' : 'Added favorite'),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
