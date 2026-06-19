import 'package:equatable/equatable.dart';

class StickerModel extends Equatable {
  final String id;
  final String name;
  final String category;
  final String? imagePath;
  final String emoji;
  final String unlockCondition;
  final bool isUnlocked;
  final bool isFavorite;
  final String? unlockModuleId;
  final String? unlockItemId;

  const StickerModel({
    required this.id,
    required this.name,
    required this.category,
    this.imagePath,
    required this.emoji,
    required this.unlockCondition,
    this.isUnlocked = false,
    this.isFavorite = false,
    this.unlockModuleId,
    this.unlockItemId,
  });

  StickerModel copyWith({
    bool? isUnlocked,
    bool? isFavorite,
  }) {
    return StickerModel(
      id: id,
      name: name,
      category: category,
      imagePath: imagePath,
      emoji: emoji,
      unlockCondition: unlockCondition,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      isFavorite: isFavorite ?? this.isFavorite,
      unlockModuleId: unlockModuleId,
      unlockItemId: unlockItemId,
    );
  }

  @override
  List<Object?> get props => [id, name, category, imagePath, emoji, unlockCondition, isUnlocked, isFavorite, unlockModuleId, unlockItemId];
}
