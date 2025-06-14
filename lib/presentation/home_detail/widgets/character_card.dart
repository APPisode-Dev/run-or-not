import 'package:flutter/material.dart';
import 'package:run_or_not/design_system/color/app_colors.dart';
import 'package:run_or_not/design_system/text/custom_text_style.dart';
import 'package:run_or_not/presentation/core/const/widget_sizes.dart';
import 'package:run_or_not/presentation/home_detail/widgets/character_name_text_field.dart';

class CharacterCard extends StatelessWidget {
  final int index;
  final String currentName;
  final String imagePath;
  final Function(int, String) onNameChanged;
  final Function(int)? onImageTap;
  final VoidCallback? onRemove;

  const CharacterCard({
    super.key,
    required this.index,
    required this.currentName,
    required this.imagePath,
    required this.onNameChanged,
    this.onImageTap,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.apricot,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => onImageTap?.call(index),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.grayText, width: 1),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: Image.asset(
                        imagePath,
                        width: WidgetSizes.avatarCircleSize,
                        height: WidgetSizes.avatarCircleSize,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppColors.peach,
                            child: const Icon(
                              Icons.person,
                              color: AppColors.white,
                              size: 24,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: AppColors.peach,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.softBlack,
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Transform.translate(
                          offset: const Offset(0, 1.0),
                          child: Text(
                            "${index + 1}",
                            style: CustomTextStyle.bodyXSmall.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.softBlack,
                              height: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: CharacterNameTextField(
                        initialName: currentName,
                        onNameChanged: (newName) {
                          onNameChanged(index, newName);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (onRemove != null)
            Positioned(
              top: 4,
              right: 4,
              child: GestureDetector(
                onTap: onRemove,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: AppColors.coral,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: AppColors.white,
                    size: 12,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
