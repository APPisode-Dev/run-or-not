import 'dart:math';

import 'package:flutter/material.dart';
import 'package:run_or_not/design_system/color/app_colors.dart';
import 'package:run_or_not/domain/const/motion_effect_rule.dart';
import 'package:run_or_not/domain/model/character/motion_effect.dart';
import 'package:run_or_not/presentation/core/const/widget_sizes.dart';

class HorseMotionEffectView extends StatefulWidget {
  final MotionEffect motionEffect;
  final Widget child;

  const HorseMotionEffectView({
    super.key,
    required this.motionEffect,
    required this.child,
  });

  @override
  State<HorseMotionEffectView> createState() => _HorseMotionEffectViewState();
}

class _HorseMotionEffectViewState extends State<HorseMotionEffectView>
    with TickerProviderStateMixin {
  static const _reverseMinimumVisibleDuration = Duration(milliseconds: 500);
  static const _loopingEffectDuration = Duration(milliseconds: 420);

  AnimationController? _controller;
  MotionEffect _visibleEffect = MotionEffect.normal;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _syncAnimation();
  }

  @override
  void didUpdateWidget(covariant HorseMotionEffectView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.motionEffect != widget.motionEffect) {
      _syncAnimation();
    }
  }

  void _syncAnimation() {
    if (widget.motionEffect == MotionEffect.normal) {
      if (_visibleEffect == MotionEffect.reverse && _controller != null) {
        return;
      }
      _clearAnimation();
      return;
    }

    if (_visibleEffect == widget.motionEffect && _controller != null) {
      return;
    }

    _startAnimation(widget.motionEffect);
  }

  void _startAnimation(MotionEffect effect) {
    _controller?.dispose();
    _visibleEffect = effect;
    _controller = AnimationController(
      vsync: this,
      duration: _durationFor(effect),
    )..addStatusListener(_handleAnimationStatus);

    final disableAnimations =
        MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    if (disableAnimations) {
      _controller!
        ..stop()
        ..value = effect == MotionEffect.slowDown ? 0.55 : 0.5;
      if (effect == MotionEffect.reverse) {
        _hideVisibleEffectAfter(
          _controller!,
          MotionEffect.reverse,
          _reverseMinimumVisibleDuration,
        );
      }
    } else if (effect == MotionEffect.slowDown ||
        effect == MotionEffect.reverse) {
      _controller!.forward(from: 0);
    } else {
      _controller!.repeat(reverse: true);
    }
  }

  void _handleAnimationStatus(AnimationStatus status) {
    if (status != AnimationStatus.completed || !mounted) {
      return;
    }

    final controller = _controller;
    if (controller == null) return;

    if (_visibleEffect == MotionEffect.reverse) {
      _hideVisibleEffect(controller, MotionEffect.reverse);
    }
  }

  Duration _durationFor(MotionEffect effect) {
    return switch (effect) {
      MotionEffect.slowDown => MotionEffectRule.slowDownDuration,
      MotionEffect.reverse => _reverseMinimumVisibleDuration,
      MotionEffect.normal ||
      MotionEffect.boost ||
      MotionEffect.stopped => _loopingEffectDuration,
    };
  }

  void _hideVisibleEffectAfter(
    AnimationController controller,
    MotionEffect effect,
    Duration duration,
  ) {
    Future<void>.delayed(duration, () {
      _hideVisibleEffect(controller, effect);
    });
  }

  void _hideVisibleEffect(AnimationController controller, MotionEffect effect) {
    if (!mounted || controller != _controller || _visibleEffect != effect) {
      return;
    }

    setState(() {
      _controller = null;
      _visibleEffect = MotionEffect.normal;
    });
    controller.dispose();
  }

  void _clearAnimation() {
    _controller?.dispose();
    _controller = null;
    _visibleEffect = MotionEffect.normal;
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_visibleEffect == MotionEffect.normal || _controller == null) {
      return widget.child;
    }

    return ExcludeSemantics(
      child: IgnorePointer(
        child: RepaintBoundary(
          child: AnimatedBuilder(
            animation: _controller!,
            builder: (context, _) {
              final progress = _controller!.value;
              return SizedBox.square(
                dimension: WidgetSizes.avatarCircleSize,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ..._buildBehindEffect(progress),
                    widget.child,
                    ..._buildFrontEffect(progress),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  List<Widget> _buildBehindEffect(double progress) {
    return switch (_visibleEffect) {
      MotionEffect.boost => [
        Positioned(
          left: -24,
          top: 3,
          child: CustomPaint(
            size: const Size(34, 34),
            painter: _BoostPainter(progress),
          ),
        ),
      ],
      MotionEffect.slowDown => const [],
      MotionEffect.normal ||
      MotionEffect.reverse ||
      MotionEffect.stopped => const [],
    };
  }

  List<Widget> _buildFrontEffect(double progress) {
    return switch (_visibleEffect) {
      MotionEffect.reverse => [
        Positioned(
          left: -8 + (progress * 3),
          top: -5,
          child: Transform.rotate(
            angle: -0.18 + (progress * 0.36),
            child: const _ReverseBadge(),
          ),
        ),
      ],
      MotionEffect.stopped => [
        Positioned.fill(child: _FrozenOverlay(progress: progress)),
      ],
      MotionEffect.slowDown => [
        Positioned(
          right: -9,
          top: -7,
          child: _HammerHitEffect(progress: progress),
        ),
      ],
      MotionEffect.normal || MotionEffect.boost => const [],
    };
  }
}

class _FrozenOverlay extends StatelessWidget {
  final double progress;

  const _FrozenOverlay({required this.progress});

  @override
  Widget build(BuildContext context) {
    final scale = 0.96 + (progress * 0.06);
    return Transform.scale(
      scale: scale,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.skyBlue.withValues(alpha: 0.24),
          border: Border.all(
            color: AppColors.white.withValues(alpha: 0.9),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.skyBlue.withValues(alpha: 0.65),
              blurRadius: 5 + (progress * 3),
              spreadRadius: 1,
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: const [
            Positioned(
              left: -3,
              top: 2,
              child: Icon(Icons.ac_unit, size: 13, color: AppColors.white),
            ),
            Positioned(
              right: -2,
              bottom: 1,
              child: Icon(Icons.ac_unit, size: 10, color: AppColors.white),
            ),
            Positioned(
              right: 7,
              top: 4,
              child: Icon(
                Icons.diamond_outlined,
                size: 9,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReverseBadge extends StatelessWidget {
  const _ReverseBadge();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 27,
      height: 24,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const Positioned(
            left: 0,
            bottom: 0,
            child: Icon(
              Icons.rotate_left_rounded,
              size: 25,
              color: AppColors.slateBlue,
            ),
          ),
          Positioned(
            right: -3,
            top: -4,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(7),
                border: Border.all(color: AppColors.coral, width: 1.2),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 3, vertical: 1),
                child: Text(
                  '?!',
                  style: TextStyle(
                    color: AppColors.coral,
                    fontSize: 8,
                    fontWeight: FontWeight.w900,
                    height: 1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BoostPainter extends CustomPainter {
  final double progress;

  _BoostPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final speedLine =
        Paint()
          ..color = AppColors.lemonYellow.withValues(alpha: 0.85)
          ..strokeWidth = 2
          ..strokeCap = StrokeCap.round;
    final lineShift = progress * 5;
    canvas.drawLine(
      Offset(2 + lineShift, 7),
      Offset(size.width - 3, 7),
      speedLine,
    );
    canvas.drawLine(
      Offset(lineShift, size.height - 6),
      Offset(size.width - 6, size.height - 6),
      speedLine,
    );

    final flameLength = 4 + (progress * 7);
    final flame =
        Path()
          ..moveTo(size.width, size.height / 2 - 8)
          ..quadraticBezierTo(
            size.width - 13,
            size.height / 2 - 9,
            size.width - 18 - flameLength,
            size.height / 2,
          )
          ..quadraticBezierTo(
            size.width - 12,
            size.height / 2 + 10,
            size.width,
            size.height / 2 + 7,
          )
          ..close();
    canvas.drawPath(flame, Paint()..color = AppColors.tangerine);

    final core =
        Path()
          ..moveTo(size.width - 1, size.height / 2 - 4)
          ..quadraticBezierTo(
            size.width - 10,
            size.height / 2 - 4,
            size.width - 15 - (progress * 4),
            size.height / 2,
          )
          ..quadraticBezierTo(
            size.width - 9,
            size.height / 2 + 5,
            size.width - 1,
            size.height / 2 + 4,
          )
          ..close();
    canvas.drawPath(core, Paint()..color = AppColors.lemonYellow);
  }

  @override
  bool shouldRepaint(covariant _BoostPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class _HammerHitEffect extends StatelessWidget {
  final double progress;

  const _HammerHitEffect({required this.progress});

  @override
  Widget build(BuildContext context) {
    const hitEnd = 0.42;
    final hitProgress = Curves.easeIn.transform(
      (progress / hitEnd).clamp(0.0, 1.0).toDouble(),
    );
    final swingAngle = -0.9 + (hitProgress * 0.72);
    final hammerOpacity =
        1 -
        Curves.easeOut.transform(
          ((progress - 0.24) / 0.18).clamp(0.0, 1.0).toDouble(),
        );
    final impactProgress = Curves.easeOut.transform(
      ((progress - 0.18) / 0.3).clamp(0.0, 1.0).toDouble(),
    );
    final impactScale = 0.65 + (impactProgress * 0.55);
    final impactOpacity =
        1 -
        Curves.easeIn.transform(
          ((progress - 0.36) / 0.24).clamp(0.0, 1.0).toDouble(),
        );
    final dizzyRotation = progress * pi * 4;

    return SizedBox(
      width: 34,
      height: 31,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: 0,
            top: 0,
            child: Opacity(
              opacity: hammerOpacity,
              child: Transform.rotate(
                angle: swingAngle,
                alignment: Alignment.bottomLeft,
                child: const Icon(
                  Icons.gavel_rounded,
                  size: 24,
                  color: AppColors.softBlack,
                ),
              ),
            ),
          ),
          Positioned(
            left: 1,
            bottom: 1,
            child: Transform.scale(
              scale: impactScale,
              child: Opacity(
                opacity: impactOpacity,
                child: const Icon(
                  Icons.brightness_7_rounded,
                  size: 14,
                  color: AppColors.tangerine,
                ),
              ),
            ),
          ),
          Transform.rotate(
            angle: dizzyRotation,
            child: Stack(
              children: [
                Positioned(
                  left: 2,
                  top: -2,
                  child: Opacity(
                    opacity: progress < 0.34 ? impactOpacity : 1,
                    child: const Icon(
                      Icons.star_rounded,
                      size: 9,
                      color: AppColors.lemonYellow,
                    ),
                  ),
                ),
                Positioned(
                  left: 12,
                  top: 2,
                  child: Opacity(
                    opacity: progress < 0.34 ? impactOpacity : 1,
                    child: const Icon(
                      Icons.star_rounded,
                      size: 7,
                      color: AppColors.coral,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
