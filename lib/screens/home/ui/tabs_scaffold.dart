// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:flutter_social_demo/app/constants/app_colors.dart';
import 'package:flutter_social_demo/app/constants/app_decorations.dart';
import 'package:flutter_social_demo/app/constants/app_dictionary.dart';
import 'package:flutter_social_demo/app/theme/text_styles.dart';
import 'package:flutter_social_demo/repository/models/profile_model.dart';
import 'package:flutter_social_demo/screens/albums/ui/albums_list_screen.dart';
import 'package:flutter_social_demo/screens/posts/ui/posts_list_screen.dart';
import 'package:flutter_social_demo/screens/profile/ui/profile_screen.dart';
import 'package:flutter_social_demo/screens/users_list/ui/users_list_screen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TabsScaffold extends StatefulWidget {
  final int? requestedIndex;
  final Profile profile;
  const TabsScaffold({
    Key? key,
    this.requestedIndex,
    required this.profile,
  }) : super(key: key);

  @override
  State<TabsScaffold> createState() => _TabsScaffoldState();
}

class _TabsScaffoldState extends State<TabsScaffold> {
  late PageController _pageController;
  List<FloatingActionButton?> floatingButtons = [];
  List<Widget> tabs = [];
  List<String> appBarTitles = [];
  List<Widget?> appBarActions = [];

  int index = 0;
  final bool _light = false;

  @override
  void initState() {
    super.initState();
    index = widget.requestedIndex ?? 0;
    _pageController = PageController(initialPage: index);
    _updateTabWidgets();
    _updateAppbarWidgets();
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  void onChangedTab(int value) {
    setState(() {
      index = value;
    });
    _pageController.jumpToPage(index);
  }

  void _updateTabWidgets() {
    tabs = [
      const UsersListView(),
      const PostsListView(),
      const AlbumsListView(),
      ProfileView(
        onChangedTab: onChangedTab,
      ),
    ];
  }

  void _updateAppbarWidgets() {
    appBarTitles = [
      AppBarTitles.userList,
      AppBarTitles.userPosts,
      AppBarTitles.userGallery,
      widget.profile.user.username,
    ];

    appBarActions = [
      null,
      null,
      null,
      IconButton(
        splashRadius: .1,
        splashColor: AppColors.transparent,
        onPressed: _showSettingsSheet,
        icon: const Icon(MdiIcons.cog),
      ),
    ];
  }

  Future _showSettingsSheet() {
    return showModalBottomSheet<void>(
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
        ),
        builder: (BuildContext context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              height: 360,
              decoration: AppDecorations.roundedBox,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    width: 40,
                    decoration: AppDecorations.roundedBox.copyWith(color: Theme.of(context).colorScheme.onBackground),
                    height: 1,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    decoration: AppDecorations.roundedBox,
                    child: Text(
                      AppDictionary.settingsTitle,
                      style: AppTextStyle.comforta14W400.apply(color: Theme.of(context).colorScheme.onBackground),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // BottomSheetForm(
                  //   sendForm: sendForm,
                  // ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        centerTitle: true,
        // backgroundColor: AppColors.mainTheme,
        title: Text(
          appBarTitles[index],
          style: AppTextStyle.comforta16W400.apply(color: AppColors.white),
        ),
        actions: appBarActions[index] != null ? [appBarActions[index]!] : null,
      ),
      extendBody: true,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: tabs,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (idx) => onChangedTab(idx),
        // iconSize: 35,
        fixedColor: Theme.of(context).colorScheme.secondary,
        items: const [
          BottomNavigationBarItem(
            label: BottomNavigationTitle.userList,
            icon: Icon(
              MdiIcons.viewList,
            ),
          ),
          BottomNavigationBarItem(
            label: BottomNavigationTitle.userPosts,
            icon: Icon(
              MdiIcons.post,
            ),
          ),
          BottomNavigationBarItem(
            label: BottomNavigationTitle.userGallery,
            icon: Icon(
              MdiIcons.viewGallery,
            ),
          ),
          BottomNavigationBarItem(
            label: BottomNavigationTitle.userProfile,
            icon: Icon(
              MdiIcons.account,
            ),
          ),
        ],
      ),
    );
  }
}
