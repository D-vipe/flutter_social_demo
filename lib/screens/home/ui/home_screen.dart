// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:flutter_social_demo/app/constants/errors_const.dart';
import 'package:flutter_social_demo/models/profile_model.dart';
import 'package:flutter_social_demo/screens/home/bloc/init_cubit.dart';
import 'package:flutter_social_demo/screens/home/ui/home_error.dart';
import 'package:flutter_social_demo/screens/home/ui/home_loading.dart';
import 'package:flutter_social_demo/screens/home/ui/tabs_scaffold.dart';

class HomeScreen extends StatefulWidget {
  final int? requestedIndex;
  const HomeScreen({
    Key? key,
    this.requestedIndex,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int requestedIndex = 0;

  @override
  void initState() {
    super.initState();
    requestedIndex = widget.requestedIndex ?? 0;
  }

  Future<bool> _onWillPop() async {
    if (!Navigator.canPop(context)) {
      setState(() => requestedIndex = 0);
    }
    return Navigator.canPop(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: TabsScaffold(
          // profile: profile,
          requestedIndex: requestedIndex,
        ));

    // TOOO replace with redux
    // BlocBuilder<InitialCubit, InitialState>(
    //   builder: (context, state) {
    //     final bool receivedState = state is InitialReceived;
    //     final bool loadingState = state is InitialRequested;
    //     String errorMessage = '';
    //     Profile? profile;
    //
    //     if (receivedState) {
    //       profile = state.data;
    //     }
    //
    //     return loadingState
    //         ? const HomeLoadingScreen()
    //         : receivedState
    //             ? profile != null
    //                 ? TabsScaffold(
    //                     profile: profile,
    //                     requestedIndex: requestedIndex,
    //                   )
    //                 : const HomeErrorScreen(message: GeneralErrors.emptyUser)
    //             : HomeErrorScreen(message: errorMessage);
    //   },
    // ),
  }
}
