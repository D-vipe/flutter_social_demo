// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:flutter_social_demo/app/constants/routes_const.dart';
import 'package:flutter_social_demo/screens/home/ui/home_screen.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.home:
      default:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
    }
  }
}
