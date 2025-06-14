import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:run_or_not/design_system/color/app_colors.dart';
import 'package:run_or_not/design_system/text/custom_text_style.dart';

class CountInputTextField extends StatefulWidget {
  final int initialCount;
  final Function(int) onCountSubmitted;

  const CountInputTextField({
    super.key,
    required this.initialCount,
    required this.onCountSubmitted,
  });

  @override
  State<CountInputTextField> createState() => _CountInputTextFieldState();
}

class _CountInputTextFieldState extends State<CountInputTextField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialCount.toString());
  }

  @override
  void didUpdateWidget(CountInputTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialCount.toString() != _controller.text) {
      _controller.text = widget.initialCount.toString();
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
      if (newCount != widget.initialCount) {
        widget.onCountSubmitted(newCount);
      }
    } else {
      _controller.text = widget.initialCount.toString();
    }
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: AppColors.softBlack, width: 0.8),
      ),
      width: 72,
      child: TextField(
        controller: _controller,
        textAlign: TextAlign.center,
        style: CustomTextStyle.bodyLarge.copyWith(
          color: AppColors.softBlack,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          suffixText: '마리',
          suffixStyle: CustomTextStyle.bodyLarge.copyWith(
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
    );
  }
}
