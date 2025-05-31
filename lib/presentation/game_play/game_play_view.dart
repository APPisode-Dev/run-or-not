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
      // appBar: AppBar(title: const Text('GamePlay View')),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                _viewModel.send(GoBackButtonTapped());
              },
              child: const Text('Go Back'),
            ),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: _viewModel.state.characters.map((character) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  color: Color(character.hexColor),
                  child: Text(
                    character.name,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
