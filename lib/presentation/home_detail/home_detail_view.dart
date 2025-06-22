import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:run_or_not/design_system/color/app_colors.dart';
import 'package:run_or_not/design_system/text/custom_text_style.dart';
import 'package:run_or_not/presentation/home_detail/home_detail_intent.dart';
import 'package:run_or_not/presentation/home_detail/home_detail_state.dart';
import 'package:run_or_not/presentation/home_detail/home_detail_view_model.dart';
import 'package:run_or_not/presentation/home_detail/widgets/character_card.dart';
import 'package:run_or_not/presentation/home_detail/widgets/character_count_stepper.dart';
import 'package:run_or_not/presentation/home_detail/widgets/character_select_view.dart';
import 'package:run_or_not/presentation/home_detail/widgets/start_game_button.dart';

class HomeDetailView extends StatelessWidget {
  final HomeDetailViewModel detailViewModel;

  const HomeDetailView({super.key, required this.detailViewModel});

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final isPortrait = orientation == Orientation.portrait;

    if (!detailViewModel.state.hasReplaceRouter) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        detailViewModel.send(ReplaceHomeDetailRouter());
      });
    }

    final _appBar = AppBar(
      title: Text(
        "캐릭터 이름 설정",
        style: CustomTextStyle.heading3.copyWith(color: AppColors.softBlack),
      ),
      centerTitle: true,
      backgroundColor: AppColors.paleLemon,
      elevation: 0,
      scrolledUnderElevation: 0,
    );

    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: AppColors.paleLemon,
            appBar: _appBar,
            body: _homeDetailBody(isPortrait: isPortrait),
          ),
        ),
        _alertView(),
      ],
    );
  }

  Widget _homeDetailBody({required bool isPortrait}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child:
          isPortrait
              ? Column(
                children: [
                  _titleText(),
                  const SizedBox(height: 32),
                  _characterStepper(),
                  const SizedBox(height: 16),
                  Expanded(child: _characterGridView(isPortrait)),
                  const SizedBox(height: 24),
                  _startGameButton(),
                ],
              )
              : Row(
                children: [
                  SizedBox(
                    width: 250,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return SingleChildScrollView(
                          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(minHeight: constraints.maxHeight),
                            child: IntrinsicHeight(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _titleText(),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                                    child: _characterStepper(),
                                  ),
                                  const Spacer(),
                                  _startGameButton(),
                                  const SizedBox(height: 16),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(child: _characterGridView(isPortrait)),
                ],
              ),
    );
  }

  Widget _titleText() {
    return Text(
      "캐릭터의 이름을 입력하세요\n(10자 이내로)",
      textAlign: TextAlign.center,
      style: CustomTextStyle.titleMedium.copyWith(color: AppColors.softBlack),
    );
  }

  Widget _characterStepper() {
    return Selector<HomeDetailViewModel, (int, bool, bool)>(
      selector:
          (context, viewModel) => (
            viewModel.state.characterCount,
            viewModel.state.canAddCharacter,
            viewModel.state.canRemoveCharacter,
          ),
      builder: (context, data, _) {
        final (characterCount, canAdd, canRemove) = data;
        return CharacterCountStepper(
          characterCount: characterCount,
          canAddCharacter: canAdd,
          canRemoveCharacter: canRemove,
          onAddCharacter: () => detailViewModel.send(AddCharacter()),
          onRemoveCharacter: () => detailViewModel.send(RemoveLastCharacter()),
          onCountChanged:
              (newCount) => detailViewModel.send(SetCharacterCount(newCount)),
        );
      },
    );
  }

  Widget _characterGridView(bool isPortrait) {
    return Selector<HomeDetailViewModel, (List<String>, List<String>, bool)>(
      selector:
          (context, viewModel) => (
            viewModel.state.characterNames,
            viewModel.state.characterImages,
            viewModel.state.canRemoveCharacter,
          ),
      builder: (context, data, _) {
        final (characterNames, characterImages, canRemove) = data;
        return GridView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isPortrait ? 2 : 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: isPortrait ? 1.4 : 1.0,
          ),
          itemCount: characterNames.length,
          itemBuilder: (context, index) {
            return CharacterCard(
              index: index,
              currentName: characterNames[index],
              imagePath: characterImages[index],
              onNameChanged:
                  (index, name) =>
                      detailViewModel.send(UpdateCharacterName(index, name)),
              onImageTap: (index) {
                FocusScope.of(context).unfocus();
                detailViewModel.send(CharacterImageTapped(index));
              },
              onRemove:
                  canRemove
                      ? () => detailViewModel.send(RemoveCharacter(index))
                      : null,
            );
          },
        );
      },
    );
  }

  Widget _startGameButton() {
    return Selector<HomeDetailViewModel, bool>(
      selector: (context, viewModel) => viewModel.state.canStartGame,
      builder: (context, canStartGame, _) {
        return StartGameButton(
          canStartGame: canStartGame,
          onStartGame: () => detailViewModel.send(NavigateToGamePlay()),
        );
      },
    );
  }

  Widget _alertView() {
    return Selector<HomeDetailViewModel, AlertCase?>(
      selector: (context, viewModel) => viewModel.state.alertCase,
      builder: (context, alertCase, _) {
        if (alertCase is! SelectCharacterAlert)
          return const SizedBox.shrink();

        final index = alertCase.index;

        return Positioned.fill(
          child: Container(
            color: Colors.black.withValues(alpha: 0.5),
            alignment: Alignment.center,
            child: Material(
                color: Colors.transparent,
                child: CharacterSelectionView(
                  currentCharacter: detailViewModel.state.characterImages[index],
                  onSelect: (imagePath) {
                    detailViewModel.send(UpdateCharacterImage(index, imagePath));
                  },
                  onCancel: () {
                    detailViewModel.send(DismissAlert());
                  },
                )
            ),
          ),
        );
      },
    );
  }
}
