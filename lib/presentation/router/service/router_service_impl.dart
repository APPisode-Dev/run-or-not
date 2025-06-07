import 'package:go_router/go_router.dart';
import 'package:run_or_not/presentation/router/app_screen.dart';
import 'package:run_or_not/presentation/router/service/router_service.dart';

class RouterServiceImpl implements RouterService {
  final GoRouter router;

  RouterServiceImpl(this.router);

  @override
  void navigateTo(String path, {Object? extra}) {
    router.push(path, extra: extra);
  }

  @override
  void goBack() {
    final _navigator = router.routerDelegate.navigatorKey.currentState;

    if (_navigator == null)
      return ;

    if (_navigator.canPop()) {
      _navigator.pop();
    }
  }

  @override
  void goRoot() {
    router.go(AppScreen.home.path);
  }
}
