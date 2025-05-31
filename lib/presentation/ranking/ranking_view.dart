import 'package:flutter/material.dart';

class RankingView extends StatelessWidget {
  const RankingView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text('Ranking View')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
          },
          child: const Text('Go to ???'),
        ),
      ),
    );
  }
}
