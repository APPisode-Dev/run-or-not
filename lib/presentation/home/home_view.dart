import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_intent.dart';
import 'home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final _viewModel = context.read<HomeViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Selector<HomeViewModel, bool>(
            selector: (context, vm) => vm.state.isLoading,
            builder: (context, isLoading, _) {
              return isLoading
                  ? const CircularProgressIndicator()
                  : const SizedBox.shrink();
            },
          ),
          const SizedBox(height: 16),
          Selector<HomeViewModel, String>(
            selector: (context, vm) => vm.state.message,
            builder: (context, message, _) {
              return Text(message);
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () =>
                _viewModel.send(ChangeButtonTapped()),
            child: const Text("메시지 체인지"),
          ),
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
