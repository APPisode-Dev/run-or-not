import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:run_or_not/presentation/game_play/game_play_intent.dart';
import 'package:run_or_not/presentation/game_play/game_play_view_model.dart';

class GamePlayView extends StatelessWidget {
  const GamePlayView({super.key});

  @override
  Widget build(BuildContext context) {
    final _viewModel = context.read<GamePlayViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('GamePlay View')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _viewModel.send(GoBackButtonTapped());
          },
          child: const Text('Go Back'),
        ),
      ),
    );
  }
}
