import 'package:flutter/material.dart';
import 'package:run_or_not/design_system/button/custom_button.dart';
import 'package:run_or_not/design_system/color/app_colors.dart';
import 'package:run_or_not/design_system/text/custom_text_style.dart';

class CharacterCountControls extends StatelessWidget {
  final int characterCount;
  final bool canAddCharacter;
  final bool canRemoveCharacter;
  final VoidCallback onAddCharacter;
  final VoidCallback onRemoveCharacter;

  const CharacterCountControls({
    super.key,
    required this.characterCount,
    required this.canAddCharacter,
    required this.canRemoveCharacter,
    required this.onAddCharacter,
    required this.onRemoveCharacter,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomButton(
          faceColor: canRemoveCharacter ? AppColors.coral : Colors.grey[300]!,
          borderRadius: 12,
          childPadding: const EdgeInsets.all(8),
          onPressed: canRemoveCharacter ? onRemoveCharacter : null,
          child: Icon(
            Icons.remove,
            color: canRemoveCharacter ? Colors.white : Colors.grey[600],
            size: 20,
          ),
        ),

        const SizedBox(width: 16),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Text(
            '${characterCount}명',
            style: CustomTextStyle.bodyMedium.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(width: 16),

        CustomButton(
          faceColor: canAddCharacter ? AppColors.mintGreen : Colors.grey[300]!,
          borderRadius: 12,
          childPadding: const EdgeInsets.all(8),
          onPressed: canAddCharacter ? onAddCharacter : null,
          child: Icon(
            Icons.add,
            color: canAddCharacter ? Colors.white : Colors.grey[600],
            size: 20,
          ),
        ),
      ],
    );
  }
}
