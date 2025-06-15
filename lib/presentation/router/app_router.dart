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
          return ChangeNotifierProvider(
            create: (_) => getIt<HomeViewModel>(),
            child: HomeView(),
          );
        },
      ),
      GoRoute(
        path: AppScreen.homeDetail.path,
        builder: (context, state) {
          return ChangeNotifierProvider(
            create: (_) => getIt<HomeDetailViewModel>(),
            child: HomeDetailView(),
          );
        },
      ),
      GoRoute(
        path: AppScreen.gamePlay.path,
        builder: (context, state) {
          final characterTuples = state.extra as List<(String, String)>;

          return ChangeNotifierProvider(
            create: (_) => getIt<GamePlayViewModel>(param1: characterTuples),
            child: GamePlayView(),
          );
        },
      ),
      GoRoute(
        path: AppScreen.ranking.path,
        builder: (context, state) {
          final characterTuples = state.extra as List<(String, String, int)>;

          return ChangeNotifierProvider(
            create: (_) => getIt<RankingViewModel>(param1: characterTuples),
            child: RankingView(),
          );
        },
      ),
      GoRoute(
        path: AppScreen.setting.path,
        builder: (context, state) {
          return ChangeNotifierProvider(
            create: (_) => getIt<SettingViewModel>(),
            child: SettingView(),
          );
        },
      ),
    ],
  );
}
