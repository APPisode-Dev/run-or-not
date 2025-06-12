import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:run_or_not/design_system/button/custom_button.dart';
import 'package:run_or_not/design_system/color/app_colors.dart';
import 'package:run_or_not/design_system/text/custom_text_style.dart';

class CharacterCountControls extends StatefulWidget {
  final int characterCount;
  final bool canAddCharacter;
  final bool canRemoveCharacter;
  final VoidCallback onAddCharacter;
  final VoidCallback onRemoveCharacter;
  final Function(int) onCountChanged;

  const CharacterCountControls({
    super.key,
    required this.characterCount,
    required this.canAddCharacter,
    required this.canRemoveCharacter,
    required this.onAddCharacter,
    required this.onRemoveCharacter,
    required this.onCountChanged,
  });

  @override
  State<CharacterCountControls> createState() => _CharacterCountControlsState();
}

class _CharacterCountControlsState extends State<CharacterCountControls> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.characterCount.toString());
  }

  @override
  void didUpdateWidget(CharacterCountControls oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.characterCount.toString() != _controller.text) {
      _controller.text = widget.characterCount.toString();
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final newCount = int.tryParse(_controller.text);

    if (newCount != null && newCount >= 2 && newCount <= 99) {
      if (newCount != widget.characterCount) {
        widget.onCountChanged(newCount);
      }
    } else {
      setState(() {
        _controller.text = widget.characterCount.toString();
      });
    }
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomButton(
          faceColor:
              widget.canRemoveCharacter ? AppColors.coral : AppColors.grayText,
          borderRadius: 12,
          childPadding: const EdgeInsets.all(8),
          onPressed:
              widget.canRemoveCharacter ? widget.onRemoveCharacter : null,
          child: Icon(Icons.remove, color: AppColors.white, size: 20),
        ),
        const SizedBox(width: 22),
        SizedBox(
          width: 48,
          child: TextField(
            controller: _controller,
            textAlign: TextAlign.center,
            style: CustomTextStyle.bodyMedium.copyWith(
              color: AppColors.softBlack,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              suffixText: '마리',
              suffixStyle: CustomTextStyle.bodyMedium.copyWith(
                color: AppColors.softBlack,
                fontWeight: FontWeight.bold,
              ),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(2),
            ],
            onSubmitted: (_) => _submit(),
            onTapOutside: (_) => _submit(),
          ),
        ),
        const SizedBox(width: 22),
        CustomButton(
          faceColor:
              widget.canAddCharacter ? AppColors.mintGreen : AppColors.grayText,
          borderRadius: 12,
          childPadding: const EdgeInsets.all(8),
          onPressed: widget.canAddCharacter ? widget.onAddCharacter : null,
          child: Icon(Icons.add, color: AppColors.white, size: 20),
        ),
      ],
    );
  }
}
