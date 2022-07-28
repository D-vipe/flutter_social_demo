// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:flutter_social_demo/app/constants/app_colors.dart';
import 'package:flutter_social_demo/app/constants/app_dictionary.dart';
import 'package:flutter_social_demo/app/theme/text_styles.dart';
import 'package:flutter_social_demo/screens/albums/ui/albums_list_screen.dart';
import 'package:flutter_social_demo/screens/posts/ui/posts_list_screen.dart';
import 'package:flutter_social_demo/screens/profile/ui/profile_screen.dart';
import 'package:flutter_social_demo/screens/users_list/ui/users_list_screen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TabsScaffold extends StatefulWidget {
  final int? requestedIndex;
  const TabsScaffold({
    Key? key,
    this.requestedIndex,
  }) : super(key: key);

  @override
  State<TabsScaffold> createState() => _TabsScaffoldState();
}

class _TabsScaffoldState extends State<TabsScaffold> {
  late PageController _pageController;
  List<FloatingActionButton?> floatingButtons = [];
  List<Widget> tabs = [];
  List<String> appBarTitles = [
    AppBarTitles.userList,
    AppBarTitles.userPosts,
    AppBarTitles.userGallery,
  ];
  int index = 0;
  final bool _light = false;

  @override
  void initState() {
    super.initState();
    index = widget.requestedIndex ?? 0;
    _pageController = PageController(initialPage: index);
    _updateTabWidgets();
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
      const UsersListScreen(),
      const PostsListScreen(),
      const AlbumsListScreen(),
      ProfileScreen(
        onChangedTab: onChangedTab,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: index != 3
          ? AppBar(
              toolbarHeight: 50,
              centerTitle: true,
              // backgroundColor: AppColors.mainTheme,
              title: Text(
                appBarTitles[index],
                style: AppTextStyle.comforta16W400.apply(color: AppColors.white),
              ),
            )
          : null,
      // backgroundColor: _light ? AppColors.white : Theme.of(context).colorScheme.background,
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
