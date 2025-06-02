import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:run_or_not/domain/use_case/game/game_use_case.dart';
import 'package:run_or_not/presentation/game_play/game_play_view_model.dart';
import 'package:run_or_not/presentation/home/home_view_model.dart';
import 'package:run_or_not/presentation/ranking/ranking_view_model.dart';
import 'package:run_or_not/presentation/router/app_router.dart';
import 'package:run_or_not/presentation/router/service/router_service.dart';
import 'package:run_or_not/presentation/router/service/router_service_impl.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  final router = createRouter();
  getIt.registerSingleton<GoRouter>(router);
  getIt.registerSingleton<RouterService>(RouterServiceImpl(router));

  getIt.registerLazySingleton<GameUseCase>(() => GameUseCase());

  getIt.registerFactory<HomeViewModel>(() => HomeViewModel(getIt<RouterService>()));
  getIt.registerFactoryParam<GamePlayViewModel, List<(String, int)>, void>(
    (characterTuples, _) => GamePlayViewModel(
        getIt<RouterService>(),
        characterTuples,
        getIt<GameUseCase>(),
    ),
  );
  getIt.registerFactory(() => RankingViewModel());
}
