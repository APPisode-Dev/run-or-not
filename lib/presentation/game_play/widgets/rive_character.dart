import 'package:flutter/material.dart';
import 'package:rive/rive.dart' as Rive;
import 'package:run_or_not/presentation/core/const/widget_sizes.dart';
import 'package:run_or_not/presentation/game_play/const/rive_setting_const.dart';
import 'package:run_or_not/presentation/game_play/utils/rive_path_converter.dart';

class RiveCharacter extends StatefulWidget {
  final String assetPath;
  final bool isRunning;

  const RiveCharacter({
    super.key,
    required this.assetPath,
    required this.isRunning,
  });

  @override
  State<RiveCharacter> createState() => _RiveCharacterState();
}

class _RiveCharacterState extends State<RiveCharacter> {
  late Rive.FileLoader _fileLoader;
  Rive.TriggerInput? _startTrigger;

  @override
  void initState() {
    super.initState();
    _fileLoader = _createFileLoader();
  }

  Rive.FileLoader _createFileLoader() {
    return Rive.FileLoader.fromAsset(
      widget.assetPath.toRivePath(),
      // Use Flutter's renderer for iOS release/TestFlight stability.
      // Factory.rive uses the native Metal texture path, which is the path
      // that rendered these characters invisible in the 1.1.0 iOS build.
      riveFactory: Rive.Factory.flutter,
    );
  }

  void _onRiveLoaded(Rive.RiveLoaded state) {
    _startTrigger?.dispose();
    // The current .riv assets expose the running action as a state machine input.
    // ignore: deprecated_member_use
    _startTrigger = state.controller.stateMachine.trigger(
      RiveSettingConst.runningTriggerName,
    );

    if (widget.isRunning) {
      _startTrigger?.fire();
    }
  }

  @override
  void didUpdateWidget(covariant RiveCharacter oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.assetPath != oldWidget.assetPath) {
      final previousFileLoader = _fileLoader;
      _startTrigger?.dispose();
      _startTrigger = null;
      _fileLoader = _createFileLoader();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        previousFileLoader.dispose();
      });
    }

    if (widget.isRunning) {
      _startTrigger?.fire();
    }
  }

  @override
  void dispose() {
    _startTrigger?.dispose();
    _fileLoader.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
      child: Container(
        width: WidgetSizes.avatarCircleSize,
        height: WidgetSizes.avatarCircleSize,
        child: Rive.RiveWidgetBuilder(
          key: ValueKey(_fileLoader),
          fileLoader: _fileLoader,
          artboardSelector: Rive.ArtboardSelector.byName('Artboard'),
          stateMachineSelector: Rive.StateMachineSelector.byName(
            RiveSettingConst.stateMachineName,
          ),
          onLoaded: _onRiveLoaded,
          builder:
              (context, state) => switch (state) {
                Rive.RiveLoading() => const SizedBox.shrink(),
                Rive.RiveFailed() => Image.asset(
                  widget.assetPath,
                  fit: BoxFit.contain,
                ),
                Rive.RiveLoaded() => Rive.RiveWidget(
                  controller: state.controller,
                  fit: Rive.Fit.contain,
                ),
              },
        ),
      ),
    );
  }
}
