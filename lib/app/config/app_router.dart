// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_social_demo/app/config/route_arguments/route_arguments.dart';

// Project imports:
import 'package:flutter_social_demo/app/constants/routes_const.dart';
import 'package:flutter_social_demo/screens/home/ui/home_screen.dart';
import 'package:flutter_social_demo/screens/posts/ui/post_detail_screen.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.detailPost:
        return MaterialPageRoute(
          builder: (_) => PostDetailScreen(
            arguments: routeSettings.arguments as PostDetailArguments,
          ),
        );
      case Routes.home:
      default:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
    }
  }
}
