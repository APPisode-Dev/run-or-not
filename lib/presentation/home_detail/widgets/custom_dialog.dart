import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:run_or_not/design_system/button/custom_button.dart';
import 'package:run_or_not/design_system/color/app_colors.dart';
import 'package:run_or_not/design_system/text/custom_text_style.dart';
import 'package:run_or_not/presentation/core/const/app_assets.dart';

abstract class CustomDialog {
  static void show({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = "확인",
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    String emoji = "🐴",
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(20),
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.peach,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.softBlack, width: 2),
                    ),
                    child: Center(
                      child: Text(emoji, style: const TextStyle(fontSize: 28)),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    title,
                    style: CustomTextStyle.heading5.copyWith(
                      color: AppColors.softBlack,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 12),

                  Text(
                    message,
                    style: CustomTextStyle.bodyMedium.copyWith(
                      color: AppColors.darkText,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (cancelText != null) ...[
                        Expanded(
                          child: CustomButton(
                            faceColor: Colors.grey[300]!,
                            borderRadius: 15,
                            onPressed: () {
                              context.pop();
                              onCancel?.call();
                            },
                            child: Text(
                              cancelText,
                              style: CustomTextStyle.buttonMedium.copyWith(
                                color: AppColors.softBlack,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],

                      Expanded(
                        child: CustomButton(
                          faceColor: AppColors.peach,
                          borderRadius: 15,
                          onPressed: () {
                            context.pop();
                            onConfirm?.call();
                          },
                          child: Text(
                            confirmText,
                            style: CustomTextStyle.buttonMedium.copyWith(
                              color: AppColors.softBlack,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }

  static void showError({
    required BuildContext context,
    required String message,
    String title = "앗!",
    String confirmText = "확인",
    VoidCallback? onConfirm,
  }) {
    show(
      context: context,
      title: title,
      message: message,
      confirmText: confirmText,
      onConfirm: onConfirm,
      emoji: "😅",
    );
  }

  static void showSuccess({
    required BuildContext context,
    required String message,
    String title = "성공!",
    String confirmText = "확인",
    VoidCallback? onConfirm,
  }) {
    show(
      context: context,
      title: title,
      message: message,
      confirmText: confirmText,
      onConfirm: onConfirm,
      emoji: "🎉",
    );
  }

  static void showConfirm({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = "네",
    String cancelText = "아니오",
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
    String emoji = "🤔",
  }) {
    show(
      context: context,
      title: title,
      message: message,
      confirmText: confirmText,
      cancelText: cancelText,
      onConfirm: onConfirm,
      onCancel: onCancel,
      emoji: emoji,
    );
  }

  static Future<String?> showCharacterSelectorDialog({
    required BuildContext context,
    required String currentCharacter,
  }) {
    final availableCharacters = [
      {'image': AppAssets.horseYellow, 'name': '노란 말'},
      {'image': AppAssets.horseBlue, 'name': '파란 말'},
      {'image': AppAssets.horseRed, 'name': '빨간 말'},
      {'image': AppAssets.horseGreen, 'name': '초록 말'},
    ];

    return showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder:
          (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(20),
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.peach,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.softBlack, width: 2),
                    ),
                    child: Center(
                      child: Text("🐴", style: const TextStyle(fontSize: 28)),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    "캐릭터 선택",
                    style: CustomTextStyle.heading5.copyWith(
                      color: AppColors.softBlack,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "마음에 드는 캐릭터를 선택해주세요!",
                    style: CustomTextStyle.bodyMedium.copyWith(
                      color: AppColors.darkText,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 20),

                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.9,
                        ),
                    itemCount: availableCharacters.length,
                    itemBuilder: (context, index) {
                      final character = availableCharacters[index];
                      final isSelected = character['image'] == currentCharacter;

                      return GestureDetector(
                        onTap: () {
                          context.pop(character['image'] as String);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color:
                                  isSelected
                                      ? AppColors.peach
                                      : Colors.grey[300]!,
                              width: isSelected ? 3 : 1,
                            ),
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
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    character['image'] as String,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: AppColors.peach,
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),

                              const SizedBox(height: 8),

                              Text(
                                character['name'] as String,
                                style: CustomTextStyle.bodyXSmall.copyWith(
                                  color: AppColors.softBlack,
                                  fontWeight:
                                      isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                ),
                                textAlign: TextAlign.center,
                              ),

                              if (isSelected) ...[
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.peach,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    "선택됨",
                                    style: CustomTextStyle.bodyXSmall.copyWith(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ],
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
                    onPressed: () => context.pop(),
                    child: Text(
                      "취소",
                      style: CustomTextStyle.buttonMedium.copyWith(
                        color: AppColors.softBlack,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  static Future<String?> showCharacterSelectorBottomSheet({
    required BuildContext context,
    required String currentCharacter,
  }) {
    final availableCharacters = [
      {'image': AppAssets.horseYellow, 'name': '노란 말'},
      {'image': AppAssets.horseBlue, 'name': '파란 말'},
      {'image': AppAssets.horseRed, 'name': '빨간 말'},
      {'image': AppAssets.horseGreen, 'name': '초록 말'},
    ];

    return showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder:
          (context) => Container(
            decoration: BoxDecoration(
              color: AppColors.paleLemon,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              border: Border.all(color: AppColors.peach, width: 3),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.peach,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.softBlack,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "🐴",
                            style: const TextStyle(fontSize: 24),
                          ),
                        ),
                      ),

                      const SizedBox(width: 16),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "캐릭터 선택",
                              style: CustomTextStyle.heading4.copyWith(
                                color: AppColors.softBlack,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "마음에 드는 캐릭터를 골라보세요!",
                              style: CustomTextStyle.bodyMedium.copyWith(
                                color: AppColors.darkText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 1.1,
                        ),
                    itemCount: availableCharacters.length,
                    itemBuilder: (context, index) {
                      final character = availableCharacters[index];
                      final isSelected = character['image'] == currentCharacter;

                      return GestureDetector(
                        onTap: () {
                          context.pop(character['image'] as String);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color:
                                  isSelected
                                      ? AppColors.peach
                                      : Colors.grey[300]!,
                              width: isSelected ? 4 : 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    character['image'] as String,
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: AppColors.peach,
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.white,
                                          size: 40,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),

                              const SizedBox(height: 12),

                              Text(
                                character['name'] as String,
                                style: CustomTextStyle.bodyMedium.copyWith(
                                  color: AppColors.softBlack,
                                  fontWeight:
                                      isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                ),
                                textAlign: TextAlign.center,
                              ),

                              // 선택 표시
                              if (isSelected) ...[
                                const SizedBox(height: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.peach,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    "✓ 선택됨",
                                    style: CustomTextStyle.bodySmall.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  // 닫기 버튼
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      faceColor: Colors.grey[300]!,
                      borderRadius: 15,
                      onPressed: () => context.pop(),
                      child: Text(
                        "취소",
                        style: CustomTextStyle.buttonLarge.copyWith(
                          color: AppColors.softBlack,
                        ),
                      ),
                    ),
                  ),

                  // 키보드 패딩
                  SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                ],
              ),
            ),
          ),
    );
  }
}
