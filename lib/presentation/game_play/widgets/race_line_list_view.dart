import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:run_or_not/design_system/color/app_colors.dart';
import 'package:run_or_not/design_system/text/custom_text_style.dart';
import 'package:run_or_not/domain/model/character/custom_character.dart';
import 'package:run_or_not/presentation/core/const/widget_sizes.dart';
import 'package:run_or_not/presentation/core/widgets/avatar_view.dart';
import 'package:run_or_not/presentation/game_play/game_play_view_model.dart';

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
      child: ListView(
        children:
            characters.asMap().entries.map((entry) {
              final _index = entry.key;
              final _character = entry.value;
              final _isEven = _index % 2 == 0;

              return Selector<GamePlayViewModel, bool>(
                selector:
                    (context, viewModel) =>
                        viewModel.state.characterList[_index].isFinished,
                builder: (context, isFinished, _) {
                  return Container(
                    height: WidgetSizes.gamePlayContainerHeight,
                    decoration: BoxDecoration(
                      color: _getLineBackgroundColor(_isEven, isFinished),
                    ),
                    child: Stack(
                      children: [
                        _characterAvatarView(_index, _character.assetName),
                        _characterNameView(_character.name),
                        _rankView(_index),
                      ],
                    ),
                  );
                },
              );
            }).toList(),
      ),
    );
  }

  Widget _characterAvatarView(int index, String assetName) {
    return Selector<GamePlayViewModel, (double, bool)>(
      selector: (context, viewModel) {
        final _character = viewModel.state.characterList[index];
        return (_character.positionX, _character.isFinished);
      },
      builder: (context, tuple, _) {
        final (_positionX, _isFinished) = tuple;
        if (_isFinished) return const SizedBox.shrink();

        return AnimatedPositioned(
          duration: const Duration(milliseconds: 100),
          left: _positionX.clamp(0, maxWidth),
          child: AvatarView(assetName: assetName),
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
