class CustomCharacter {
  final String name;
  final int hexColor; // TODO: 추후 필드 수정 예정
  final double speed;
  final double positionX;
  final bool isFinished;
  final int? rank;

  const CustomCharacter({
    required this.name,
    required this.hexColor,
    this.speed = 0.1,
    this.positionX = 0,
    this.isFinished = false,
    this.rank,
  });

  CustomCharacter copyWith({
    String? name,
    int? hexColor,
    double? speed,
    double? positionX,
    bool? isFinished,
    int? rank,
  }) {
    return CustomCharacter(
      name: name ?? this.name,
      hexColor: hexColor ?? this.hexColor,
      speed: speed ?? this.speed,
      positionX: positionX ?? this.positionX,
      isFinished: isFinished ?? this.isFinished,
      rank: rank ?? this.rank,
    );
  }
}