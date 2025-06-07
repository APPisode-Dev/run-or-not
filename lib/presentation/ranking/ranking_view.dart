import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:run_or_not/design_system/color/app_colors.dart';
import 'package:run_or_not/design_system/text/custom_text_style.dart';
import 'package:run_or_not/presentation/ranking/ranking_intent.dart';
import 'package:run_or_not/presentation/ranking/ranking_view_model.dart';
import 'package:run_or_not/presentation/ranking/widgets/each_ranking_info_view.dart';
import 'package:run_or_not/presentation/ranking/widgets/ranking_title_view.dart';

class RankingView extends StatelessWidget {
  const RankingView({super.key});

  @override
  Widget build(BuildContext context) {
    final _viewModel = context.read<RankingViewModel>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.home_outlined),
            onPressed: () {
              _viewModel.send(HomeButtonTapped());
            },
          ),
        ],
        title: Text(
          "보여줄까 말까?!",
          style: CustomTextStyle.heading3.copyWith(color: Colors.black),
        ),
        backgroundColor: AppColors.paleLemon,
      ),
      body: Column(
        children: [
          RankingTitleView(),
          Expanded(
              child: ListView(
                children: _viewModel.state.characterList
                    .asMap()
                    .entries
                    .map ((entry) {
                  final _index = entry.key;
                  final _character = entry.value;
                  final _isEven = _index % 2 == 0;

                  return EachRankingInfoView(
                      index: _index,
                      customCharacter: _character,
                      isEven: _isEven,
                  );
                }).toList(),
              ),
          ),
        ],
      )
    );
  }
}
