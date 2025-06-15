import 'package:flutter/material.dart';
import 'package:run_or_not/presentation/game_play/game_play_intent.dart';
import 'package:run_or_not/presentation/game_play/game_play_view_model.dart';
import 'package:run_or_not/presentation/game_play/widgets/game_play_button.dart';
import 'package:run_or_not/presentation/game_play/widgets/race_line_list_view.dart';

class GamePlayView extends StatelessWidget {
  final GamePlayViewModel gamePlayViewModel;
  
  const GamePlayView({super.key, required this.gamePlayViewModel});

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    final _maxWidth = _mediaQuery.size.width;
    final _horizontalSafeArea = _mediaQuery.padding.left + _mediaQuery.padding.right;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      gamePlayViewModel.send(UpdateMaxDeviceWidthAndSafeArea(_maxWidth, _horizontalSafeArea));
    });

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            RaceLineListView(
              characters: gamePlayViewModel.state.characterList,
              maxWidth: _maxWidth,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GamePlayButton(
                goBackButtonAction: () {
                  gamePlayViewModel.send(GoBackButtonTapped());
                },
                startButtonAction: () {
                  gamePlayViewModel.send(StartButtonTapped());
                },
                rankingButtonAction: () {
                  gamePlayViewModel.send(RankingButtonTapped());
                },
                retryButtonAction: () {
                  gamePlayViewModel.send(RetryButtonTapped());
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}