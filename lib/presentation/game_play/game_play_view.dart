import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:run_or_not/domain/model/character/custom_character.dart';
import 'package:run_or_not/presentation/game_play/game_play_intent.dart';
import 'package:run_or_not/presentation/game_play/game_play_view_model.dart';

class GamePlayView extends StatelessWidget {
  const GamePlayView({super.key});

  @override
  Widget build(BuildContext context) {
    final _viewModel = context.read<GamePlayViewModel>();
    final _mediaQuery = MediaQuery.of(context);
    final _maxWidth = _mediaQuery.size.width;
    final _horizontalSafeArea = _mediaQuery.padding.left + _mediaQuery.padding.right;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel.send(UpdateMaxDeviceWidthAndSafeArea(_maxWidth, _horizontalSafeArea));
    });

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buttonRowView(
              goBackButtonAction: () {
                _viewModel.send(GoBackButtonTapped());
              },
              startButtonAction: () {
                _viewModel.send(TimerStartButtonTapped());
              },
            ),
            _CharacterListView(
              characters: _viewModel.state.characterList,
              maxWidth: _maxWidth,
            )
          ],
        ),
      ),
    );
  }

  Widget _buttonRowView({
    required VoidCallback goBackButtonAction,
    required VoidCallback startButtonAction,
  }) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: goBackButtonAction,
          child: const Text('Go Back'),
        ),
        ElevatedButton(
          onPressed: startButtonAction,
          child: const Text('timer start'),
        ),
      ],
    );
  }
}

class _CharacterListView extends StatelessWidget {
  final List<CustomCharacter> characters;
  final double maxWidth;
  final double _containerHeight = 44;
  final double _avatarCircleSize = 40;

  const _CharacterListView({
    super.key,
    required this.characters,
    required this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: characters.asMap().entries.map((entry) {
          final index = entry.key;
          final character = entry.value;

          return Container(
            height: _containerHeight,
            decoration: BoxDecoration(
              color: Color(character.hexColor),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              children: [
                Selector<GamePlayViewModel, double>(
                  selector: (context, viewModel) => viewModel.state.characterList[index].positionX,
                  builder: (context, positionX, _) {
                    return _characterAvatarView(positionX);
                  },
                ),
                _characterNameView(character.name),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _characterAvatarView(double positionX) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 100),
      left: positionX.clamp(0, maxWidth),
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
  }

  Widget _characterNameView(String name) {
    return Positioned(
      top: 2,
      right: 10,
      child: Text(
        name,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}