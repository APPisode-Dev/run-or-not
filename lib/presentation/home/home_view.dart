import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:run_or_not/design_system/button/custom_button.dart';
import 'package:run_or_not/design_system/color/app_colors.dart';
import 'package:run_or_not/design_system/text/custom_text_style.dart';
import 'home_intent.dart';
import 'home_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(
      begin: 1.0,
      end: 1.10,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _viewModel = context.read<HomeViewModel>();
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      backgroundColor: AppColors.paleLemon,
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: isPortrait ? 60.0 : 20.0),
            child: ScaleTransition(
              scale: _animation,
              child: Text(
                '달릴까 말까 !?',
                textAlign: TextAlign.center,
                style: CustomTextStyle.heading1.copyWith(
                  color: AppColors.peach,
                  fontSize: 48,
                  shadows: [
                    Shadow(
                      offset: const Offset(2.0, 2.0),
                      blurRadius: 3.0,
                      color: AppColors.softBlack,
                    ),
                  ],
                ),
              ),
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
                      'assets/images/horse_yellow.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Row(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: CustomButton(
                          child: Text(
                            '시작하기',
                            style: CustomTextStyle.buttonLarge,
                          ),
                          faceColor: AppColors.peach,
                          borderRadius: 15,
                          onPressed: () {
                            _viewModel.send(NavigateToHomeDetail());
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: CustomButton(
                          child: Text(
                            '설정하기',
                            style: CustomTextStyle.buttonLarge,
                          ),
                          faceColor: AppColors.peach,
                          borderRadius: 15,
                          onPressed: () {
                            _viewModel.send(NavigateToHomeDetail());
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
