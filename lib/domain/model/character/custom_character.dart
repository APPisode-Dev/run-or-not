class CustomCharacter {
  final String name;
  final double speed;
  final double positionX;
  final bool isFinished;
  final int rank;

  const CustomCharacter({
    required this.name,
    this.speed = 0.1,
    this.positionX = 0,
    this.isFinished = false,
    this.rank = 0,
  });

  CustomCharacter copyWith({
    String? name,
    double? speed,
    double? positionX,
    bool? isFinished,
    int? rank,
  }) {
    return CustomCharacter(
      name: name ?? this.name,
      speed: speed ?? this.speed,
      positionX: positionX ?? this.positionX,
      isFinished: isFinished ?? this.isFinished,
      rank: rank ?? this.rank,
    );
  }
}