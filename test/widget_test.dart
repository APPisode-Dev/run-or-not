import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:run_or_not/app/main.dart';
import 'package:run_or_not/core/di/injector.dart';
import 'package:run_or_not/domain/model/character/motion_effect.dart';
import 'package:run_or_not/presentation/game_play/widgets/horse_motion_effect_view.dart';

void main() {
  setUpAll(() {
    setupDependencies();
  });

  testWidgets('renders the home start button', (tester) async {
    await tester.pumpWidget(MyApp(router: getIt<GoRouter>()));
    await tester.pump();

    expect(find.text('시작하기'), findsOneWidget);
  });

  testWidgets('switches motion effects without creating multiple tickers', (
    tester,
  ) async {
    for (final effect in const [
      MotionEffect.stopped,
      MotionEffect.boost,
      MotionEffect.reverse,
      MotionEffect.slowDown,
    ]) {
      await tester.pumpWidget(_effectHarness(effect));
      await tester.pump(const Duration(milliseconds: 50));
      expect(tester.takeException(), isNull);
    }

    await tester.pumpWidget(_effectHarness(MotionEffect.normal));
    await tester.pump();
    expect(tester.takeException(), isNull);
  });

  testWidgets('keeps reverse decoration visible for at least 0.5 seconds', (
    tester,
  ) async {
    await tester.pumpWidget(_effectHarness(MotionEffect.reverse));
    expect(find.text('?!'), findsOneWidget);

    await tester.pumpWidget(_effectHarness(MotionEffect.normal));
    await tester.pump(const Duration(milliseconds: 499));
    expect(find.text('?!'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 2));
    expect(find.text('?!'), findsNothing);
  });

  testWidgets('shows one hammer hit and keeps dizzy stars during slow down', (
    tester,
  ) async {
    await tester.pumpWidget(_effectHarness(MotionEffect.slowDown));

    expect(find.byIcon(Icons.gavel_rounded), findsOneWidget);
    expect(find.byIcon(Icons.star_rounded), findsNWidgets(2));

    await tester.pump(const Duration(milliseconds: 700));

    final hammerOpacity = tester.widgetList<Opacity>(
      find.ancestor(
        of: find.byIcon(Icons.gavel_rounded),
        matching: find.byType(Opacity),
      ),
    );
    expect(hammerOpacity.any((widget) => widget.opacity == 0), isTrue);
    expect(find.byIcon(Icons.star_rounded), findsNWidgets(2));

    await tester.pumpWidget(_effectHarness(MotionEffect.normal));
    await tester.pump();
    expect(find.byIcon(Icons.gavel_rounded), findsNothing);
    expect(find.byIcon(Icons.star_rounded), findsNothing);
  });
}

Widget _effectHarness(MotionEffect effect) {
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: HorseMotionEffectView(
          motionEffect: effect,
          child: const SizedBox.square(dimension: 48),
        ),
      ),
    ),
  );
}
