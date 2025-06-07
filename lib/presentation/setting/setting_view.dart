import 'package:flutter/material.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text('Setting View')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {

          },
          child: const Text('Setting View'),
        ),
      ),
    );
  }
}
