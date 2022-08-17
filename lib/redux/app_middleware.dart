import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:flutter_social_demo/redux/app_state.dart';
import 'package:flutter_social_demo/redux/middleware/user_middleware.dart';

List<Middleware<AppState>> createAppMiddleWare() {
  List<Middleware<AppState>> appMiddleware = [];
  appMiddleware.addAll(createUsersListMiddleware());
  appMiddleware.add(LoggingMiddleware.printer());
  return appMiddleware;
}
