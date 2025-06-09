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

class HomeDetailView extends StatefulWidget {
  const HomeDetailView({super.key});

  @override
  State<HomeDetailView> createState() => _HomeDetailViewState();
}

class _HomeDetailViewState extends State<HomeDetailView> {
  final Map<int, TextEditingController> _controllers = {};

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.paleLemon,
      appBar: AppBar(
        title: Text(
          "캐릭터 이름 설정",
          style: CustomTextStyle.heading3.copyWith(color: Colors.black),
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
                      () => _removeLastCharacter(
                        context.read<HomeDetailViewModel>(),
                      ),
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
                      _syncControllers(characterNames);

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
                          final controller = _controllers[index];
                          if (controller == null)
                            return const SizedBox.shrink();

                          return CharacterInputField(
                            index: index,
                            controller: controller,
                            currentName: characterNames[index],
                            imagePath: characterImages[index],
                            onNameChanged: (index, name) {
                              context.read<HomeDetailViewModel>().send(
                                UpdateCharacterName(index, name),
                              );
                            },
                            onImageTap:
                                (index) => _showCharacterSelector(
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

            Selector<HomeDetailViewModel, (bool, int)>(
              selector:
                  (context, viewModel) => (
                    viewModel.state.canStartGame,
                    viewModel.state.validCharacterNames.length,
                  ),
              builder: (context, data, _) {
                final (canStartGame, validCount) = data;
                return StartGameButton(
                  canStartGame: canStartGame,
                  onStartGame:
                      () => context.read<HomeDetailViewModel>().send(
                        NavigateToGamePlay(),
                      ),
                  onError: () => _showErrorDialog("최소 2개의 유효한 이름을 입력해주세요!"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _syncControllers(List<String> characterNames) {
    final requiredIndices = Set<int>.from(
      List.generate(characterNames.length, (index) => index),
    );

    final toRemove =
        _controllers.keys
            .where((index) => !requiredIndices.contains(index))
            .toList();
    for (final index in toRemove) {
      _controllers[index]?.dispose();
      _controllers.remove(index);
    }

    for (int i = 0; i < characterNames.length; i++) {
      if (!_controllers.containsKey(i)) {
        _controllers[i] = TextEditingController(text: characterNames[i]);
      } else {
        final controller = _controllers[i]!;
        if (controller.text != characterNames[i] &&
            !controller.selection.isValid) {
          controller.text = characterNames[i];
        }
      }
    }
  }

  void _removeLastCharacter(HomeDetailViewModel viewModel) {
    final lastIndex = viewModel.state.characterNames.length - 1;
    if (lastIndex >= 0) {
      viewModel.send(RemoveCharacter(lastIndex));
    }
  }

  void _showErrorDialog(String message) {
    CustomDialog.showError(context: context, message: message);
  }

  void _showCharacterSelector(int index, HomeDetailViewModel viewModel) async {
    final currentImage = viewModel.state.characterImages[index];

    final result = await CustomDialog.showCharacterSelectorDialog(
      context: context,
      currentCharacter: currentImage,
    );

    // final result = await CuteDialog.showCharacterSelectorBottomSheet(
    //   context: context,
    //   currentCharacter: currentImage,
    // );

    if (result != null) {
      viewModel.send(UpdateCharacterImage(index, result));
    }
  }
}
