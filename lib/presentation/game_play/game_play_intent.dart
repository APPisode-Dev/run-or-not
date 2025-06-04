sealed class GamePlayIntent {}

class GoBackButtonTapped extends GamePlayIntent {}
class TimerStartButtonTapped extends GamePlayIntent {}
class RankingButtonTapped extends GamePlayIntent {}
class UpdatePositionXWithSpeed extends GamePlayIntent {}
class UpdateMaxDeviceWidthAndSafeArea extends GamePlayIntent {
  final double maxDeviceWidth;
  final double horizontalSafeArea;

  UpdateMaxDeviceWidthAndSafeArea(this.maxDeviceWidth, this.horizontalSafeArea);
}