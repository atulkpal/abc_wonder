import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

enum AchievementTier { bronze, silver, gold, platinum }

class AchievementModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final AchievementTier tier;
  final String? badgeImagePath;
  final Color badgeColor;
  final String unlockCriteria;
  final double progress;
  final bool isUnlocked;
  final DateTime? unlockedDate;
  final int starReward;

  const AchievementModel({
    required this.id,
    required this.title,
    required this.description,
    required this.tier,
    this.badgeImagePath,
    required this.badgeColor,
    required this.unlockCriteria,
    this.progress = 0.0,
    this.isUnlocked = false,
    this.unlockedDate,
    this.starReward = 0,
  });

  AchievementModel copyWith({
    double? progress,
    bool? isUnlocked,
    DateTime? unlockedDate,
  }) {
    return AchievementModel(
      id: id,
      title: title,
      description: description,
      tier: tier,
      badgeImagePath: badgeImagePath,
      badgeColor: badgeColor,
      unlockCriteria: unlockCriteria,
      progress: progress ?? this.progress,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      unlockedDate: unlockedDate ?? this.unlockedDate,
      starReward: starReward,
    );
  }

  @override
  List<Object?> get props => [id, title, description, tier, badgeImagePath, badgeColor, unlockCriteria, progress, isUnlocked, unlockedDate, starReward];
}
