import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:run_or_not/presentation/home_detail/home_detail_intent.dart';
import 'package:run_or_not/presentation/home_detail/home_detail_view_model.dart';

class HomeDetailView extends StatelessWidget {
  const HomeDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final _viewModel = context.read<HomeDetailViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text("Home Detail")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("This is Home Detail View"),
          ElevatedButton(
            onPressed: () =>
                _viewModel.send(NavigateToGamePlay()),
            child: const Text("Game Play View 이동"),
          ),
        ],
      ),
    );
  }
}