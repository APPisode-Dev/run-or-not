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
    required this.isRunning
  });

  @override
  State<RiveCharacter> createState() => _RiveCharacterState();
}

class _RiveCharacterState extends State<RiveCharacter> {
  Rive.SMITrigger? _startTrigger;

  void _onRiveInit(Rive.Artboard artboard) {
    final controller = Rive.StateMachineController.fromArtboard(artboard, RiveSettingConst.stateMachineName);

    if (controller == null) {
      return;
    }

    artboard.addController(controller);

    final input = controller.findSMI(RiveSettingConst.runningTriggerName);
    _startTrigger = input;
  }

  @override
  void didUpdateWidget(covariant RiveCharacter oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isRunning) {
      _startTrigger?.fire();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
      child: Container(
        width: WidgetSizes.avatarCircleSize,
        height: WidgetSizes.avatarCircleSize,
        child: Rive.RiveAnimation.asset(
          widget.assetPath.toRivePath(),
          artboard: 'Artboard',
          onInit: _onRiveInit,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
