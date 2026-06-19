import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class RobotModel extends Equatable {
  final String id;
  final Color bodyColor;
  final Color eyeColor;
  final Color antennaColor;
  final String? accessoryId;
  final String currentExpression;

  const RobotModel({
    required this.id,
    this.bodyColor = const Color(0xFFFFFFFF),
    this.eyeColor = const Color(0xFF00668A),
    this.antennaColor = const Color(0xFFFF6B35),
    this.accessoryId,
    this.currentExpression = 'idle',
  });

  RobotModel copyWith({
    Color? bodyColor,
    Color? eyeColor,
    Color? antennaColor,
    String? accessoryId,
    String? currentExpression,
  }) {
    return RobotModel(
      id: id,
      bodyColor: bodyColor ?? this.bodyColor,
      eyeColor: eyeColor ?? this.eyeColor,
      antennaColor: antennaColor ?? this.antennaColor,
      accessoryId: accessoryId ?? this.accessoryId,
      currentExpression: currentExpression ?? this.currentExpression,
    );
  }

  @override
  List<Object?> get props => [id, bodyColor, eyeColor, antennaColor, accessoryId, currentExpression];
}
