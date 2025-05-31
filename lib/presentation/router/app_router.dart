import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:run_or_not/core/di/injector.dart';
import 'package:run_or_not/domain/model/character/custom_character.dart';
import 'package:run_or_not/presentation/game_play/game_play_view.dart';
import 'package:run_or_not/presentation/game_play/game_play_view_model.dart';
import 'package:run_or_not/presentation/home/home_view.dart';
import 'package:run_or_not/presentation/home/home_view_model.dart';
import 'package:run_or_not/presentation/ranking/ranking_view.dart';
import 'package:run_or_not/presentation/ranking/ranking_view_model.dart';
import 'app_screen.dart';

GoRouter createRouter() {
  return GoRouter(
    initialLocation: AppScreen.home.path,
    routes: [
      GoRoute(
        path: AppScreen.home.path,
        builder: (context, state) {
          return ChangeNotifierProvider(
            create: (_) => getIt<HomeViewModel>() ,
            child: HomeView(),
          );
        },
      ),
      GoRoute(
        path: AppScreen.gamePlay.path,
        builder: (context, state) {
          final characters = state.extra as List<CustomCharacter>;

          return ChangeNotifierProvider(
            create: (_) => getIt<GamePlayViewModel>(param1: characters),
            child: GamePlayView(),
          );
        }
      ),
      GoRoute(
        path: AppScreen.ranking.path,
        builder: (context, state) {
          return ChangeNotifierProvider(
            create: (_) => getIt<RankingViewModel>() ,
            child: RankingView(),
          );
        }
      ),
    ],
  );
}
