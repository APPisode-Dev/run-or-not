import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:run_or_not/design_system/color/app_colors.dart';
import 'package:run_or_not/design_system/text/custom_text_style.dart';
import 'package:run_or_not/presentation/home_detail/home_detail_intent.dart';
import 'package:run_or_not/presentation/home_detail/home_detail_view_model.dart';
import 'package:run_or_not/presentation/home_detail/widgets/character_count_controls.dart';
import 'package:run_or_not/presentation/home_detail/widgets/character_input_field.dart';
import 'package:run_or_not/presentation/home_detail/widgets/custom_dialog.dart';
import 'package:run_or_not/presentation/home_detail/widgets/start_game_button.dart';

class HomeDetailView extends StatelessWidget {
  const HomeDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Column(
          children: [
            Text(
              "캐릭터의 이름을 입력하세요 \n(10자 이내로)",
              style: CustomTextStyle.titleMedium.copyWith(
                color: AppColors.softBlack,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Selector<HomeDetailViewModel, (int, bool, bool)>(
              selector:
                  (context, viewModel) => (
                    viewModel.state.characterCount,
                    viewModel.state.canAddCharacter,
                    viewModel.state.canRemoveCharacter,
                  ),
              builder: (context, data, _) {
                final (characterCount, canAdd, canRemove) = data;
                return CharacterCountControls(
                  characterCount: characterCount,
                  canAddCharacter: canAdd,
                  canRemoveCharacter: canRemove,
                  onAddCharacter:
                      () => context.read<HomeDetailViewModel>().send(
                        AddCharacter(),
                      ),
                  onRemoveCharacter:
                      () => context.read<HomeDetailViewModel>().send(
                        RemoveLastCharacter(),
                      ),
                  onCountChanged: (newCount) {
                    context.read<HomeDetailViewModel>().send(
                      SetCharacterCount(newCount),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child:
                  Selector<HomeDetailViewModel, (List<String>, List<String>)>(
                    selector:
                        (context, viewModel) => (
                          viewModel.state.characterNames,
                          viewModel.state.characterImages,
                        ),
                    builder: (context, data, _) {
                      final (characterNames, characterImages) = data;

                      return GridView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 1.4,
                            ),
                        itemCount: characterNames.length,
                        itemBuilder: (context, index) {
                          return CharacterInputField(
                            index: index,
                            currentName: characterNames[index],
                            imagePath: characterImages[index],
                            onNameChanged: (index, name) {
                              context.read<HomeDetailViewModel>().send(
                                UpdateCharacterName(index, name),
                              );
                            },
                            onImageTap:
                                (index) => _showCharacterSelector(
                                  context,
                                  index,
                                  context.read<HomeDetailViewModel>(),
                                ),
                            onRemove:
                                index >= 2
                                    ? () => context
                                        .read<HomeDetailViewModel>()
                                        .send(RemoveCharacter(index))
                                    : null,
                          );
                        },
                      );
                    },
                  ),
            ),
            const SizedBox(height: 24),
            Selector<HomeDetailViewModel, bool>(
              selector: (context, viewModel) => (viewModel.state.canStartGame),
              builder: (context, data, _) {
                final canStartGame = data;
                return StartGameButton(
                  canStartGame: canStartGame,
                  onStartGame:
                      () => context.read<HomeDetailViewModel>().send(
                        NavigateToGamePlay(),
                      ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showCharacterSelector(
    BuildContext context,
    int index,
    HomeDetailViewModel viewModel,
  ) async {
    final currentImage = viewModel.state.characterImages[index];

    final result = await CustomDialog.showCharacterSelectorDialog(
      context: context,
      currentCharacter: currentImage,
    );

    if (result != null) {
      viewModel.send(UpdateCharacterImage(index, result));
    }
  }
}
