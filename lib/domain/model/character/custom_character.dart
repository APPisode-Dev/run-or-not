class CustomCharacter {
  final String name;
  final String assetName;
  final double speed;
  final double positionX;
  final bool isFinished;
  final int rank;

  const CustomCharacter({
    required this.name,
    required this.assetName,
    this.speed = 0.1,
    this.positionX = 0,
    this.isFinished = false,
    this.rank = 0,
  });

  CustomCharacter copyWith({
    String? name,
    String? assetName,
    double? speed,
    double? positionX,
    bool? isFinished,
    int? rank,
  }) {
    return CustomCharacter(
      name: name ?? this.name,
      assetName: assetName ?? this.assetName,
      speed: speed ?? this.speed,
      positionX: positionX ?? this.positionX,
      isFinished: isFinished ?? this.isFinished,
      rank: rank ?? this.rank,
    );
  }
}