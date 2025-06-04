import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color faceColor;
  final Color? outlineColor;
  final double borderRadius;
  final EdgeInsetsGeometry childPadding;

  const CustomButton({
    super.key,
    required this.child,
    this.onPressed,
    required this.faceColor,
    this.outlineColor,
    this.borderRadius = 18.0,
    this.childPadding = const EdgeInsets.all(12.0),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Container(
          padding: childPadding,
          decoration: BoxDecoration(
            color: faceColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: _getOutlineBorder(outlineColor),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 1,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }

  Border? _getOutlineBorder(Color? outlineColor) {
    if (outlineColor == null) return null;
    return Border.all(color: outlineColor, width: 1.5);
  }
}
