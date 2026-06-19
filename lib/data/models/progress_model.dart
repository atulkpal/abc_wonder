import 'package:equatable/equatable.dart';

class ProgressModel extends Equatable {
  final String moduleId;
  final Map<String, bool> completedItems;
  final int totalItems;
  final DateTime? lastPlayedDate;
  final int sessionCount;
  final int totalTimeSpentSeconds;
  final double averageAccuracy;

  const ProgressModel({
    required this.moduleId,
    required this.completedItems,
    required this.totalItems,
    this.lastPlayedDate,
    this.sessionCount = 0,
    this.totalTimeSpentSeconds = 0,
    this.averageAccuracy = 0.0,
  });

  int get completedCount => completedItems.values.where((v) => v).length;
  double get completionPercentage => totalItems > 0 ? completedCount / totalItems : 0.0;
  bool get isModuleComplete => completedCount >= totalItems;

  ProgressModel copyWith({
    String? moduleId,
    Map<String, bool>? completedItems,
    int? totalItems,
    DateTime? lastPlayedDate,
    int? sessionCount,
    int? totalTimeSpentSeconds,
    double? averageAccuracy,
  }) {
    return ProgressModel(
      moduleId: moduleId ?? this.moduleId,
      completedItems: completedItems ?? this.completedItems,
      totalItems: totalItems ?? this.totalItems,
      lastPlayedDate: lastPlayedDate ?? this.lastPlayedDate,
      sessionCount: sessionCount ?? this.sessionCount,
      totalTimeSpentSeconds: totalTimeSpentSeconds ?? this.totalTimeSpentSeconds,
      averageAccuracy: averageAccuracy ?? this.averageAccuracy,
    );
  }

  @override
  List<Object?> get props => [moduleId, completedItems, totalItems, lastPlayedDate, sessionCount, totalTimeSpentSeconds, averageAccuracy];
}
