// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_localizations/flutter_localizations.dart';

// Project imports:
import 'package:flutter_social_demo/app/config/app_router.dart';
import 'package:flutter_social_demo/app/theme/theme.dart';
import 'package:flutter_social_demo/services/caching_service.dart';
import 'package:flutter_social_demo/services/hive_service.dart';
import 'package:flutter_social_demo/services/shared_preferences.dart';
import 'package:flutter_social_demo/services/theme_service.dart';

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
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  bool _light = true;

  @override
  void initState() {
    super.initState();
    _light = ThemeService.getCurrentTheme();
  }

  void changeTheme(bool lightTheme) {
    setState(() {
      _light = lightTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Social App',
      locale: const Locale('ru'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
      ],
      theme: _light ? AppTheme.lightTheme() : AppTheme.darkTheme(),
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: 'home',
    );
  }
}
