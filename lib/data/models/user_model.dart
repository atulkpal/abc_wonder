import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String? childName;
  final DateTime? dateOfBirth;
  final String? avatarId;
  final int totalStars;
  final int currentStreak;
  final int longestStreak;
  final DateTime? lastPlayedDate;

  const UserModel({
    required this.id,
    this.childName,
    this.dateOfBirth,
    this.avatarId,
    this.totalStars = 0,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.lastPlayedDate,
  });

  UserModel copyWith({
    String? childName,
    DateTime? dateOfBirth,
    String? avatarId,
    int? totalStars,
    int? currentStreak,
    int? longestStreak,
    DateTime? lastPlayedDate,
  }) {
    return UserModel(
      id: id,
      childName: childName ?? this.childName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      avatarId: avatarId ?? this.avatarId,
      totalStars: totalStars ?? this.totalStars,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      lastPlayedDate: lastPlayedDate ?? this.lastPlayedDate,
    );
  }

  @override
  List<Object?> get props => [id, childName, dateOfBirth, avatarId, totalStars, currentStreak, longestStreak, lastPlayedDate];
}
