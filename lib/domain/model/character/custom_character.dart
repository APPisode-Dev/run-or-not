import 'package:run_or_not/domain/model/character/motion_effect.dart';

class CustomCharacter {
  final String name;
  final String assetName;
  final double speed;
  final double positionX;
  final bool isFinished;
  final int rank;
  final MotionEffect motionEffect;
  final int effectRemainingTicks;
  final double speedMultiplier;

  const CustomCharacter({
    required this.name,
    required this.assetName,
    this.speed = 0.1,
    this.positionX = 0,
    this.isFinished = false,
    this.rank = 0,
    this.motionEffect = MotionEffect.normal,
    this.effectRemainingTicks = 0,
    this.speedMultiplier = 1,
  });

  CustomCharacter copyWith({
    String? name,
    String? assetName,
    double? speed,
    double? positionX,
    bool? isFinished,
    int? rank,
    MotionEffect? motionEffect,
    int? effectRemainingTicks,
    double? speedMultiplier,
  }) {
    return CustomCharacter(
      name: name ?? this.name,
      assetName: assetName ?? this.assetName,
      speed: speed ?? this.speed,
      positionX: positionX ?? this.positionX,
      isFinished: isFinished ?? this.isFinished,
      rank: rank ?? this.rank,
      motionEffect: motionEffect ?? this.motionEffect,
      effectRemainingTicks: effectRemainingTicks ?? this.effectRemainingTicks,
      speedMultiplier: speedMultiplier ?? this.speedMultiplier,
    );
  }
}
