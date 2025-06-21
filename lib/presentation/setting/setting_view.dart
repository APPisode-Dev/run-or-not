import 'package:flutter/material.dart';
import 'package:run_or_not/presentation/setting/setting_view_model.dart';

class SettingView extends StatelessWidget {
  final SettingViewModel settingViewModel;

  const SettingView({super.key, required this.settingViewModel});

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
