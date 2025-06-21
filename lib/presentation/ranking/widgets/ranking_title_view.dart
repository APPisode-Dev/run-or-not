import 'package:flutter/material.dart';
import 'package:run_or_not/design_system/text/custom_text_style.dart';
import 'package:run_or_not/presentation/core/const/widget_sizes.dart';

class RankingTitleView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
        child: Container(
          height: WidgetSizes.rankingContainerHeight,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  "순위",
                  style: CustomTextStyle.bodyMedium.copyWith(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 32, 0),
                  child: Text(
                    "이름",
                    style: CustomTextStyle.bodyMedium.copyWith(color: Colors.black),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  "말",
                  style: CustomTextStyle.bodyMedium.copyWith(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}