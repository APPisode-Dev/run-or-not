import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:run_or_not/design_system/button/custom_button.dart';
import 'package:run_or_not/design_system/color/app_colors.dart';
import 'package:run_or_not/design_system/text/custom_text_style.dart';
import 'package:run_or_not/presentation/game_play/game_play_view_model.dart';

class GamePlayButton extends StatelessWidget {
  final VoidCallback goBackButtonAction;
  final VoidCallback startButtonAction;
  final VoidCallback rankingButtonAction;
  final VoidCallback retryButtonAction;

  const GamePlayButton({
    super.key,
    required this.goBackButtonAction,
    required this.startButtonAction,
    required this.rankingButtonAction,
    required this.retryButtonAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Center(child: _buttonView(goBackButtonAction, "뒤로 가기")),
        ),
        Expanded(
          child: Center(
            child: Selector<GamePlayViewModel, bool>(
              selector:
                  (context, viewModel) =>
                      viewModel.state.shouldShowRankingButton,
              builder: (context, shouldShowRankingButton, _) {
                return shouldShowRankingButton
                    ? _buttonView(retryButtonAction, "다시 하기")
                    : _buttonView(startButtonAction, "시작 하기");
              },
            ),
          ),
        ),
        Selector<GamePlayViewModel, bool>(
          selector:
              (context, viewModel) => viewModel.state.shouldShowRankingButton,
          builder: (context, shouldShowRankingButton, _) {
            return shouldShowRankingButton
                ? Expanded(
                  child: Center(
                    child: _buttonView(rankingButtonAction, "순위 보기"),
                  ),
                )
                : const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  Widget _buttonView(VoidCallback action, String title) {
    return CustomButton(
      child: Text(title, style: CustomTextStyle.bodySmall),
      faceColor: AppColors.peach,
      borderRadius: 15,
      onPressed: action,
      childPadding: EdgeInsets.fromLTRB(8, 4, 8, 4),
    );
  }
}
