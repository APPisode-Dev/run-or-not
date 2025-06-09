import 'package:flutter/material.dart';
import 'package:run_or_not/design_system/color/app_colors.dart';
import 'package:run_or_not/design_system/text/custom_text_style.dart';

class CharacterInputField extends StatelessWidget {
  final int index;
  final TextEditingController controller;
  final String currentName;
  final String imagePath;
  final Function(int, String) onNameChanged;
  final Function(int)? onImageTap;
  final VoidCallback? onRemove;

  const CharacterInputField({
    super.key,
    required this.index,
    required this.controller,
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
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
                  border: Border.all(color: Colors.grey[300]!, width: 1),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: Image.asset(
                    imagePath,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppColors.peach,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
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
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: Center(
                    child: Text(
                      "${index + 1}",
                      style: CustomTextStyle.bodyXSmall.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 6),

                Expanded(
                  child: TextField(
                    controller: controller,
                    style: CustomTextStyle.bodyXSmall.copyWith(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: "이름",
                      hintStyle: CustomTextStyle.bodyXSmall.copyWith(
                        color: Colors.grey[600],
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                    ),
                    maxLength: 8,
                    buildCounter: (
                      context, {
                      required currentLength,
                      maxLength,
                      required isFocused,
                    }) {
                      return null;
                    },
                    onChanged: (value) {
                      onNameChanged(index, value);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
