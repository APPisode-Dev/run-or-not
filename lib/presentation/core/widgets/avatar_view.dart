import 'package:flutter/material.dart';
import 'package:run_or_not/presentation/core/const/widget_sizes.dart';

class AvatarView extends StatelessWidget {
  final String assetName;

  AvatarView({
    super.key,
    required this.assetName,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
        child: Container(
          width: WidgetSizes.avatarCircleSize,
          height: WidgetSizes.avatarCircleSize,
          child: Image.asset(
            assetName,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}