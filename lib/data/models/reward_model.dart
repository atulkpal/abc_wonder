import 'package:equatable/equatable.dart';

class RewardModel extends Equatable {
  final String id;
  final String type;
  final String name;
  final String description;
  final String? animationAsset;
  final bool isClaimed;

  const RewardModel({
    required this.id,
    required this.type,
    required this.name,
    required this.description,
    this.animationAsset,
    this.isClaimed = false,
  });

  RewardModel copyWith({bool? isClaimed}) {
    return RewardModel(
      id: id,
      type: type,
      name: name,
      description: description,
      animationAsset: animationAsset,
      isClaimed: isClaimed ?? this.isClaimed,
    );
  }

  @override
  List<Object?> get props => [id, type, name, description, animationAsset, isClaimed];
}
