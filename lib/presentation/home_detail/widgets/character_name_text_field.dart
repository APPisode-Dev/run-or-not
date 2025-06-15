import 'package:flutter/material.dart';
import 'package:run_or_not/design_system/color/app_colors.dart';
import 'package:run_or_not/design_system/text/custom_text_style.dart';

class CharacterNameTextField extends StatefulWidget {
  final String initialName;

  final Function(String) onNameChanged;

  const CharacterNameTextField({
    super.key,
    required this.initialName,
    required this.onNameChanged,
  });

  @override
  State<CharacterNameTextField> createState() => _CharacterNameTextFieldState();
}

class _CharacterNameTextFieldState extends State<CharacterNameTextField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialName);

    _controller.addListener(() {
      if (widget.initialName != _controller.text) {
        widget.onNameChanged(_controller.text);
      }
    });
  }

  @override
  void didUpdateWidget(CharacterNameTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialName != _controller.text) {
      _controller.text = widget.initialName;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      style: CustomTextStyle.bodyXSmall.copyWith(color: AppColors.softBlack),
      decoration: InputDecoration(
        hintText: "이름을 입력해주세요",
        hintStyle: CustomTextStyle.bodyXSmall.copyWith(
          color: AppColors.grayText,
        ),
        border: InputBorder.none,
        contentPadding: EdgeInsets.zero,
        isDense: true,
      ),
      maxLength: 10,
      buildCounter: (
        context, {
        required currentLength,
        maxLength,
        required isFocused,
      }) {
        return null;
      },
    );
  }
}
