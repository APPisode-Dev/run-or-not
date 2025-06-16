import 'dart:math';

abstract class RandomUtil {
  static final Random _random = Random();

  static double getDoubleMinMaxRangeValue(double min, double max) {
    return min + (max - min) * _random.nextDouble();
  }
}