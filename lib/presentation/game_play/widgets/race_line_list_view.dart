import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:run_or_not/design_system/text/custom_text_style.dart';
import 'package:run_or_not/domain/model/character/custom_character.dart';
import 'package:run_or_not/presentation/game_play/game_play_view_model.dart';

class RaceLineListView extends StatelessWidget {
  final List<CustomCharacter> characters;
  final double maxWidth;
  final double _containerHeight = 44;
  final double _avatarCircleSize = 40;

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

              return Selector<GamePlayViewModel, bool>(
                selector:
                    (context, viewModel) =>
                        viewModel.state.characterList[_index].isFinished,
                builder: (context, isFinished, _) {
                  return Container(
                    height: _containerHeight,
                    decoration: BoxDecoration(
                      color: Color(
                        _character.hexColor,
                      ).withValues(alpha: isFinished ? 0.5 : 1.0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Stack(
                      children: [
                        _characterAvatarView(_index),
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

  Widget _characterAvatarView(int index) {
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
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
            child: Container(
              width: _avatarCircleSize,
              height: _avatarCircleSize,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 1),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _characterNameView(String name) {
    return Positioned(
      top: 2,
      right: 10,
      child: Text(
        name,
        style: CustomTextStyle.bodySmall.copyWith(color: Colors.white),
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
            ? Text(
              "$_rank등",
              style: CustomTextStyle.bodySmall.copyWith(color: Colors.black),
            )
            : const SizedBox.shrink();
      },
    );
  }
}
