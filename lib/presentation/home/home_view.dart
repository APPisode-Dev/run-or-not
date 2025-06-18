import 'package:flutter/material.dart';
import 'package:run_or_not/presentation/core/const/app_assets.dart';
import 'package:run_or_not/design_system/button/custom_button.dart';
import 'package:run_or_not/design_system/color/app_colors.dart';
import 'package:run_or_not/design_system/text/custom_text_style.dart';
import 'package:run_or_not/presentation/home/widgets/animated_title_text.dart';
import 'home_intent.dart';
import 'home_view_model.dart';

class HomeView extends StatelessWidget {
  final HomeViewModel homeViewModel;
  final isSettingButtonVisible = false;

  const HomeView({super.key, required this.homeViewModel});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      backgroundColor: AppColors.paleLemon,
      body: Column(
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                top:
                    MediaQuery.of(context).size.height *
                    (isPortrait ? 0.05 : 0.02),
              ),
              child: const AnimatedTitleText(),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Flexible(
                    flex: 20,
                    child: Image.asset(
                      AppAssets.horseYellow,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SafeArea(
                    top: false,
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: screenHeight * (isPortrait ? 0.03 : 0.02),
                      ),
                      child: Row(
                        spacing: 10,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          homeButton(
                            text: '시작하기',
                            action: () {
                              homeViewModel.send(StartButtonTapped());
                            },
                          ),
                          if (isSettingButtonVisible)
                            homeButton(
                                text: '설정하기',
                                action: () {
                                  homeViewModel.send(SettingButtonTapped());
                              }
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget homeButton({required String text, required VoidCallback action}) {
    return CustomButton(
      child: Text(text, style: CustomTextStyle.buttonLarge),
      faceColor: AppColors.peach,
      borderRadius: 15,
      onPressed: () {
        action();
      },
    );
  }
}
