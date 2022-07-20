import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_social_demo/app/config/app_router.dart';
import 'package:flutter_social_demo/app/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await SharedStorageService.init();
  // await HiveService.init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demo Auth App',
      locale: const Locale('ru'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
      ],
      theme: AppTheme.baseTheme(),
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: 'home',
    );
  }
}
