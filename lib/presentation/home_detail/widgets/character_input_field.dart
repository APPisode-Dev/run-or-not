import 'package:flutter/material.dart';
import 'package:run_or_not/design_system/color/app_colors.dart';
import 'package:run_or_not/design_system/text/custom_text_style.dart';

class CharacterInputField extends StatefulWidget {
  final int index;
  final String currentName;
  final String imagePath;
  final Function(int, String) onNameChanged;
  final Function(int)? onImageTap;
  final VoidCallback? onRemove;

  const CharacterInputField({
    super.key,
    required this.index,
    required this.currentName,
    required this.imagePath,
    required this.onNameChanged,
    this.onImageTap,
    this.onRemove,
  });

  @override
  State<CharacterInputField> createState() => _CharacterInputFieldState();
}

class _CharacterInputFieldState extends State<CharacterInputField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(text: widget.currentName);
    _controller.addListener(() {
      widget.onNameChanged(widget.index, _controller.text);
    });
  }

  @override
  void didUpdateWidget(CharacterInputField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.currentName != _controller.text) {
      _controller.text = widget.currentName;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                  onTap: () => widget.onImageTap?.call(widget.index),
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
                        widget.imagePath,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppColors.peach,
                            child: const Icon(
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
                          "${widget.index + 1}",
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
                        controller: _controller,
                        style: CustomTextStyle.bodyXSmall.copyWith(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          hintText: "이름을 입력해주세요",
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
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (widget.onRemove != null)
            Positioned(
              top: 4,
              right: 4,
              child: GestureDetector(
                onTap: widget.onRemove,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: AppColors.coral,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.close, color: Colors.white, size: 12),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
