import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:run_or_not/design_system/color/app_colors.dart';
import 'package:run_or_not/design_system/text/custom_text_style.dart';
import 'package:run_or_not/domain/const/motion_effect_rule.dart';
import 'package:run_or_not/domain/model/character/custom_character.dart';
import 'package:run_or_not/domain/model/character/motion_effect.dart';
import 'package:run_or_not/presentation/core/const/widget_sizes.dart';
import 'package:run_or_not/presentation/game_play/game_play_view_model.dart';
import 'package:run_or_not/presentation/game_play/widgets/horse_motion_effect_view.dart';
import 'package:run_or_not/presentation/game_play/widgets/rive_character.dart';

class RaceLineListView extends StatelessWidget {
  final List<CustomCharacter> characters;
  final double maxWidth;

  const RaceLineListView({
    super.key,
    required this.characters,
    required this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: characters.length,
        itemBuilder: (context, index) {
          final character = characters[index];
          final isEven = index.isEven;

          return Selector<GamePlayViewModel, bool>(
            selector:
                (context, viewModel) =>
                    viewModel.state.characterList[index].isFinished,
            builder: (context, isFinished, _) {
              return Container(
                height: WidgetSizes.gamePlayContainerHeight,
                decoration: BoxDecoration(
                  color: _getLineBackgroundColor(isEven, isFinished),
                ),
                child: Stack(
                  children: [
                    _characterAvatarView(index, character.assetName),
                    _characterNameView(character.name),
                    _rankView(index),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _characterAvatarView(int index, String assetPath) {
    return Selector<GamePlayViewModel, (double, bool, bool, MotionEffect)>(
      selector: (context, viewModel) {
        final _character = viewModel.state.characterList[index];
        return (
          _character.positionX,
          _character.isFinished,
          viewModel.state.isStarting,
          _character.motionEffect,
        );
      },
      builder: (context, tuple, _) {
        final (_positionX, _isFinished, isStart, motionEffect) = tuple;
        if (_isFinished) return const SizedBox.shrink();

        return AnimatedPositioned(
          duration: MotionEffectRule.gameTickDuration,
          left: _positionX.clamp(0, maxWidth),
          child: HorseMotionEffectView(
            motionEffect: motionEffect,
            child: RiveCharacter(assetPath: assetPath, isRunning: isStart),
          ),
        );
      },
    );
  }

  Widget _characterNameView(String name) {
    return Positioned(
      top: 2,
      right: 6,
      child: Text(
        name,
        style: CustomTextStyle.bodySmall.copyWith(color: Colors.black),
      ),
    );
  }

  Widget _rankView(int index) {
    return Selector<GamePlayViewModel, (bool, int?)>(
      selector: (context, viewModel) {
        final _character = viewModel.state.characterList[index];
        return (_character.isFinished, _character.rank);
      },
      builder: (context, tuple, _) {
        final (_isFinished, _rank) = tuple;
        return (_isFinished && _rank != null)
            ? Padding(
              padding: const EdgeInsets.fromLTRB(6, 2, 0, 0),
              child: Text(
                "$_rank등",
                style: CustomTextStyle.bodySmall.copyWith(color: Colors.black),
              ),
            )
            : const SizedBox.shrink();
      },
    );
  }

  Color _getLineBackgroundColor(bool isEven, bool isFinished) {
    if (isFinished) {
      return AppColors.peach;
    } else {
      if (isEven) {
        return Colors.transparent;
      } else {
        return AppColors.paleLemon.withValues(alpha: 0.5);
      }
    }
  }
}
