import 'package:flutter/material.dart';
import 'package:run_or_not/design_system/button/custom_button.dart';
import 'package:run_or_not/design_system/color/app_colors.dart';
import 'package:run_or_not/design_system/text/custom_text_style.dart';

class StartGameButton extends StatelessWidget {
  final bool canStartGame;
  final VoidCallback onStartGame;
  final VoidCallback? onError;

  const StartGameButton({
    super.key,
    required this.canStartGame,
    required this.onStartGame,
    this.onError,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomButton(
        faceColor: canStartGame ? AppColors.peach : Colors.grey[300]!,
        borderRadius: 15,
        onPressed: canStartGame ? onStartGame : onError,
        child: Text(
          "게임 시작!",
          style: CustomTextStyle.buttonLarge.copyWith(
            color: canStartGame ? Colors.black : Colors.grey[600],
          ),
        ),
      ),
    );
  }
}
