import 'package:flutter/material.dart';
import 'package:flutter_social_demo/app/uikit/loader_page.dart';

class HomeLoadingScreen extends StatelessWidget {
  const HomeLoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBody: true,
      body: LoaderPage(),
    );
  }
}
