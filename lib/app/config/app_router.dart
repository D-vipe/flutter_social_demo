// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:flutter_social_demo/app/config/route_arguments/detail_page_arguments.dart';
import 'package:flutter_social_demo/app/constants/routes_const.dart';
import 'package:flutter_social_demo/screens/albums/bloc/albums_cubit.dart';
import 'package:flutter_social_demo/screens/albums/ui/album_detail_screen.dart';
import 'package:flutter_social_demo/screens/home/bloc/init_cubit.dart';
import 'package:flutter_social_demo/screens/home/ui/home_screen.dart';
import 'package:flutter_social_demo/screens/posts/bloc/posts_cubit.dart';
import 'package:flutter_social_demo/screens/posts/ui/post_detail_screen.dart';
import 'package:flutter_social_demo/screens/profile/bloc/profile_cubit.dart';
import 'package:flutter_social_demo/screens/users_list/bloc/users_list_cubit.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.detailAlbum:
        return MaterialPageRoute(
            builder: (_) => AlbumDetailScreen(
                arguments: routeSettings.arguments as DetailPageArgument));
      case Routes.detailPost:
        return MaterialPageRoute(
            builder: (_) => PostDetailScreen(
                arguments: routeSettings.arguments as DetailPageArgument));
      case Routes.home:
      default:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (BuildContext context) => InitialCubit(),
              ),
              BlocProvider(
                create: (BuildContext context) => UsersListCubit(),
              ),
              BlocProvider(
                create: (BuildContext context) => PostsCubit(),
              ),
              BlocProvider(
                create: (BuildContext context) => AlbumsCubit(),
              ),
              BlocProvider(
                create: (BuildContext context) => ProfileCubit(),
              ),
            ],
            child: const HomeScreen(),
          ),
        );
    }
  }
}
