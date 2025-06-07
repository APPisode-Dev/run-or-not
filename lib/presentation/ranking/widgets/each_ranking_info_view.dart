import 'package:flutter/material.dart';
import 'package:run_or_not/design_system/color/app_colors.dart';
import 'package:run_or_not/design_system/text/custom_text_style.dart';
import 'package:run_or_not/domain/model/character/custom_character.dart';
import 'package:run_or_not/presentation/core/const/widget_sizes.dart';
import 'package:run_or_not/presentation/core/widgets/avatar_view.dart';

class EachRankingInfoView extends StatelessWidget {
  final int index;
  final CustomCharacter customCharacter;
  final bool isEven;

  const EachRankingInfoView({
    super.key,
    required this.index,
    required this.customCharacter,
    required this.isEven,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isEven ? AppColors.paleLemon.withValues(alpha: 0.5) : Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
        child: Container(
          height: WidgetSizes.rankingContainerHeight,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: _characterRankDisplayView(),
              ),
              Expanded(
                flex: 7,
                child: _characterNameDisplayView(),
              ),
              Expanded(
                flex: 2,
                child: AvatarView(assetName: customCharacter.assetName),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _characterRankDisplayView() {
    final _medals = ["🥇", "🥈", "🥉"];
    final _hasMedal = index < 3;

    return Center(
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          if (!_hasMedal)
          Text(
            "${index + 1}",
            style: CustomTextStyle.bodyMedium.copyWith(color: Colors.black),
            textAlign: TextAlign.center,
          ),
          if (_hasMedal)
            Text(
              _medals[index],
              style: CustomTextStyle.heading3,
            ),
        ],
      ),
    );
  }

  Widget _characterNameDisplayView() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 32, 0),
      child: Text(
        customCharacter.name,
        style: CustomTextStyle.bodyMedium.copyWith(color: Colors.black),
        textAlign: TextAlign.right,
      ),
    );
  }
}