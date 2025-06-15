sealed class GamePlayIntent {}

class GoBackButtonTapped extends GamePlayIntent {}
class StartButtonTapped extends GamePlayIntent {}
class RankingButtonTapped extends GamePlayIntent {}
class RetryButtonTapped extends GamePlayIntent {}
class UpdatePositionXWithSpeed extends GamePlayIntent {}
class UpdateMaxDeviceWidthAndSafeArea extends GamePlayIntent {
  final double maxDeviceWidth;
  final double horizontalSafeArea;

  UpdateMaxDeviceWidthAndSafeArea(this.maxDeviceWidth, this.horizontalSafeArea);
}
class SetGameStart extends GamePlayIntent {
  final bool isStart;

  SetGameStart(this.isStart);
}