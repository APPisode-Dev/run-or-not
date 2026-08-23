abstract class MotionEffectRule {
  static const int gameTickMilliseconds = 100;
  static const Duration gameTickDuration = Duration(
    milliseconds: gameTickMilliseconds,
  );

  static const int transientEffectTicks = 1;
  static const int stoppedTicks = 10;
  static const int slowDownTicks = 15;
  static const Duration slowDownDuration = Duration(
    milliseconds: gameTickMilliseconds * slowDownTicks,
  );

  static const double slowDownMinMultiplier = 0.3;
  static const double slowDownMaxMultiplier = 0.55;
  static const double chaosMinMultiplier = 4;
  static const double chaosMaxMultiplier = 7;
}
