// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
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
        requestedIndex: requestedIndex,
      ),
    );
  }
}
