import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:run_or_not/core/di/injector.dart';
import 'package:run_or_not/presentation/game_play/game_play_view.dart';
import 'package:run_or_not/presentation/game_play/game_play_view_model.dart';
import 'package:run_or_not/presentation/home/home_view.dart';
import 'package:run_or_not/presentation/home/home_view_model.dart';
import 'package:run_or_not/presentation/home_detail/home_detail_view.dart';
import 'package:run_or_not/presentation/home_detail/home_detail_view_model.dart';
import 'package:run_or_not/presentation/ranking/ranking_view.dart';
import 'package:run_or_not/presentation/ranking/ranking_view_model.dart';
import 'package:run_or_not/presentation/setting/setting_view.dart';
import 'package:run_or_not/presentation/setting/setting_view_model.dart';
import 'app_screen.dart';

GoRouter createRouter() {
  return GoRouter(
    initialLocation: AppScreen.home.path,
    routes: [
      GoRoute(
        path: AppScreen.home.path,
        builder: (context, state) {
          final homeViewModel = getIt<HomeViewModel>();
          return ChangeNotifierProvider(
            create: (_) => homeViewModel,
            child: HomeView(homeViewModel: homeViewModel),
          );
        },
      ),
      GoRoute(
        path: AppScreen.homeDetail.path,
        builder: (context, state) {
          final detailViewModel = getIt<HomeDetailViewModel>();
          final resetFlag = state.uri.queryParameters['reset'];
          final shouldReset = resetFlag == 'true';
          if (shouldReset) {
            detailViewModel.resetViewModel();
          }

          return ChangeNotifierProvider.value(
            value: detailViewModel,
            child: HomeDetailView(detailViewModel: detailViewModel),
          );
        },
      ),
      GoRoute(
        path: AppScreen.gamePlay.path,
        builder: (context, state) {
          final characterTuples = state.extra as List<(String, String)>;
          final gamePlayViewModel = getIt<GamePlayViewModel>(param1: characterTuples);

          return ChangeNotifierProvider.value(
            value: gamePlayViewModel,
            child: GamePlayView(gamePlayViewModel: gamePlayViewModel),
          );
        },
      ),
      GoRoute(
        path: AppScreen.ranking.path,
        builder: (context, state) {
          final characterTuples = state.extra as List<(String, String, int)>;
          final rankingViewModel = getIt<RankingViewModel>(param1: characterTuples);

          return ChangeNotifierProvider(
            create: (_) => rankingViewModel,
            child: RankingView(rankingViewModel: rankingViewModel),
          );
        },
      ),
      GoRoute(
        path: AppScreen.setting.path,
        builder: (context, state) {
          final settingViewModel = getIt<SettingViewModel>();
          return ChangeNotifierProvider(
            create: (_) => settingViewModel,
            child: SettingView(settingViewModel: settingViewModel),
          );
        },
      ),
    ],
  );
}
