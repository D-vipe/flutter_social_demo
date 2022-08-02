// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:flutter_social_demo/app/uikit/error_page.dart';

class HomeErrorScreen extends StatelessWidget {
  final String message;
  const HomeErrorScreen({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: ErrorPage(message: message),
    );
  }
}
