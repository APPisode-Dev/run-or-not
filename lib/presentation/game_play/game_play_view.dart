import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:run_or_not/presentation/game_play/game_play_intent.dart';
import 'package:run_or_not/presentation/game_play/game_play_view_model.dart';
import 'package:run_or_not/presentation/game_play/widgets/race_line_list_view.dart';

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
            RaceLineListView(
              characters: _viewModel.state.characterList,
              maxWidth: _maxWidth,
            )
          ],
        ),
      ),
    );
  }

  // TODO: 임시 버튼
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