// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:flutter_social_demo/app/config/app_router.dart';
import 'package:flutter_social_demo/app/theme/theme.dart';
import 'package:flutter_social_demo/redux/app_middleware.dart';
import 'package:flutter_social_demo/redux/app_reducer.dart';
import 'package:flutter_social_demo/redux/app_state.dart';
import 'package:flutter_social_demo/services/caching_service.dart';
import 'package:flutter_social_demo/services/hive_service.dart';
import 'package:flutter_social_demo/services/shared_preferences.dart';
import 'package:redux/redux.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedStorageService.init();
  await HiveService.init();

  // Imitate user logged in
  final String userId = SharedStorageService.getString(PreferenceKey.userId);
  if (userId.isEmpty) {
    await CachingService.setLoggedUser();
  }

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final store = Store<AppState>(
    appReducer,
    initialState: AppState.initialState(),
    middleware: createAppMiddleWare(),
  );

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Demo Social App',
        locale: const Locale('ru'),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
        ],
        theme: AppTheme.baseTheme(),
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: 'home',
      ),
    );
  }
}
