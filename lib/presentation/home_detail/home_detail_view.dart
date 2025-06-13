import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:run_or_not/design_system/color/app_colors.dart';
import 'package:run_or_not/design_system/text/custom_text_style.dart';
import 'package:run_or_not/presentation/home_detail/home_detail_intent.dart';
import 'package:run_or_not/presentation/home_detail/home_detail_view_model.dart';
import 'package:run_or_not/presentation/home_detail/widgets/character_card.dart';
import 'package:run_or_not/presentation/home_detail/widgets/character_count_stepper.dart';
import 'package:run_or_not/presentation/home_detail/widgets/start_game_button.dart';

class HomeDetailView extends StatelessWidget {
  const HomeDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final isPortrait = orientation == Orientation.portrait;

    final titleText = Text(
      "캐릭터의 이름을 입력하세요\n(10자 이내로)",
      textAlign: TextAlign.center,
      style: CustomTextStyle.titleMedium.copyWith(color: AppColors.softBlack),
    );

    final characterStepper = Selector<HomeDetailViewModel, (int, bool, bool)>(
      selector:
          (context, vm) => (
            vm.state.characterCount,
            vm.state.canAddCharacter,
            vm.state.canRemoveCharacter,
          ),
      builder: (context, data, _) {
        final (characterCount, canAdd, canRemove) = data;
        return CharacterCountStepper(
          characterCount: characterCount,
          canAddCharacter: canAdd,
          canRemoveCharacter: canRemove,
          onAddCharacter:
              () => context.read<HomeDetailViewModel>().send(AddCharacter()),
          onRemoveCharacter:
              () => context.read<HomeDetailViewModel>().send(
                RemoveLastCharacter(),
              ),
          onCountChanged:
              (newCount) => context.read<HomeDetailViewModel>().send(
                SetCharacterCount(newCount),
              ),
        );
      },
    );

    final characterGrid =
        Selector<HomeDetailViewModel, (List<String>, List<String>)>(
          selector:
              (context, vm) => (
                vm.state.characterNames,
                vm.state.characterImages,
              ),
          builder: (context, data, _) {
            final (characterNames, characterImages) = data;
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
                      (index, name) => context.read<HomeDetailViewModel>().send(
                        UpdateCharacterName(index, name),
                      ),
                  onImageTap: (index) {
                    // TODO: 향후 SideEffect 패턴 등으로 개선
                  },
                );
              },
            );
          },
        );

    final startGameButton = Selector<HomeDetailViewModel, bool>(
      selector: (context, vm) => vm.state.canStartGame,
      builder: (context, canStartGame, _) {
        return StartGameButton(
          canStartGame: canStartGame,
          onStartGame:
              () => context.read<HomeDetailViewModel>().send(
                NavigateToGamePlay(),
              ),
        );
      },
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.paleLemon,
      appBar: AppBar(
        title: Text(
          "캐릭터 이름 설정",
          style: CustomTextStyle.heading3.copyWith(color: AppColors.softBlack),
        ),
        centerTitle: true,
        backgroundColor: AppColors.paleLemon,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            isPortrait
                ? Column(
                  children: [
                    titleText,
                    const SizedBox(height: 32),
                    characterStepper,
                    const SizedBox(height: 16),
                    Expanded(child: characterGrid),
                    const SizedBox(height: 24),
                    startGameButton,
                  ],
                )
                : Row(
                  children: [
                    SizedBox(
                      width: 250,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          titleText,
                          const SizedBox(height: 32),
                          characterStepper,
                          const Spacer(),
                          startGameButton,
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(child: characterGrid),
                  ],
                ),
      ),
    );
  }
}
