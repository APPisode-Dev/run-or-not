import 'package:flutter/material.dart';
import 'package:run_or_not/design_system/button/custom_button.dart';
import 'package:run_or_not/design_system/color/app_colors.dart';
import 'package:run_or_not/presentation/home_detail/widgets/count_input_text_field.dart';

class CharacterCountStepper extends StatelessWidget {
  final int characterCount;
  final bool canAddCharacter;
  final bool canRemoveCharacter;
  final VoidCallback onAddCharacter;
  final VoidCallback onRemoveCharacter;
  final Function(int) onCountChanged;

  const CharacterCountStepper({
    super.key,
    required this.characterCount,
    required this.canAddCharacter,
    required this.canRemoveCharacter,
    required this.onAddCharacter,
    required this.onRemoveCharacter,
    required this.onCountChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomButton(
          faceColor: canRemoveCharacter ? AppColors.coral : AppColors.grayText,
          borderRadius: 12,
          childPadding: const EdgeInsets.all(8),
          onPressed: canRemoveCharacter ? onRemoveCharacter : null,
          child: const Icon(Icons.remove, color: AppColors.white, size: 20),
        ),
        const SizedBox(width: 22),

        CountInputTextField(
          initialCount: characterCount,
          onCountSubmitted: onCountChanged,
        ),

        const SizedBox(width: 22),
        CustomButton(
          faceColor: canAddCharacter ? AppColors.mintGreen : AppColors.grayText,
          borderRadius: 12,
          childPadding: const EdgeInsets.all(8),
          onPressed: canAddCharacter ? onAddCharacter : null,
          child: const Icon(Icons.add, color: AppColors.white, size: 20),
        ),
      ],
    );
  }
}
