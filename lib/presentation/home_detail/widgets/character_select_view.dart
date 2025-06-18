import 'package:flutter/material.dart';
import 'package:run_or_not/design_system/button/custom_button.dart';
import 'package:run_or_not/design_system/color/app_colors.dart';
import 'package:run_or_not/design_system/text/custom_text_style.dart';
import 'package:run_or_not/presentation/core/const/app_assets.dart';

class CharacterSelectionView extends StatelessWidget {
  final String? currentCharacter;
  final void Function(String) onSelect;
  final VoidCallback onCancel;

  const CharacterSelectionView({
    required this.currentCharacter,
    required this.onSelect,
    required this.onCancel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    final availableCharacters = [
      {'image': AppAssets.horseYellow, 'name': '노란 말'},
      {'image': AppAssets.horseBlue, 'name': '파란 말'},
      {'image': AppAssets.horseRed, 'name': '빨간 말'},
      {'image': AppAssets.horseGreen, 'name': '초록 말'},
    ];

    Widget content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "캐릭터 선택",
          style: CustomTextStyle.heading5.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.softBlack,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "마음에 드는 캐릭터를 선택해주세요!",
          style: CustomTextStyle.bodyMedium.copyWith(color: AppColors.darkText),
          textAlign: TextAlign.center,
        ),

        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: availableCharacters.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.9,
          ),
          itemBuilder: (context, index) {
            final character = availableCharacters[index];
            final isSelected = character['image'] == currentCharacter;

            return GestureDetector(
              onTap: () => onSelect(character['image'] as String),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: isSelected ? AppColors.peach : AppColors.grayText,
                    width: isSelected ? 3 : 1,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        character['image'] as String,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (_, __, ___) => Container(
                              color: AppColors.peach,
                              child: const Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                            ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      character['name'] as String,
                      style: CustomTextStyle.bodyXSmall.copyWith(
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                        color: AppColors.softBlack,
                      ),
                    ),
                    if (isSelected)
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.peach,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          "선택됨",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),

        const SizedBox(height: 20),

        CustomButton(
          faceColor: AppColors.coral,
          borderRadius: 15,
          onPressed: onCancel,
          child: Text(
            "취소",
            style: CustomTextStyle.buttonMedium.copyWith(
              color: AppColors.softBlack,
            ),
          ),
        ),
      ],
    );

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          padding: const EdgeInsets.all(20),
          constraints: BoxConstraints(
            maxWidth: orientation == Orientation.portrait ? 400 : 700,
          ),
          decoration: BoxDecoration(
            color: AppColors.paleLemon,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.peach, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: content,
        ),
      ),
    );
  }
}
