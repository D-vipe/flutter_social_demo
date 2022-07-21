import 'package:flutter/material.dart';
import 'package:flutter_social_demo/app/constants/app_colors.dart';
import 'package:flutter_social_demo/app/constants/app_dictionary.dart';
import 'package:flutter_social_demo/app/theme/text_styles.dart';
import 'package:flutter_social_demo/resources/resources.dart';
import 'package:flutter_social_demo/screens/users_list/ui/list_screen.dart';
import 'package:flutter_svg/svg.dart';

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
    AppBarTitles.userProfile,
  ];
  int index = 0;

  @override
  void initState() {
    super.initState();
    index = widget.requestedIndex ?? 0;
    _pageController = PageController(initialPage: index);
    _updateFloatingButtons();
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
    debugPrint('current index: $index');
  }

  void _updateTabWidgets() {
    tabs = [
      const ListScreen(),
      Container(
        child: const Center(
          child: Text('Posts'),
        ),
      ),
      Container(
        child: const Center(
          child: Text('Gallery'),
        ),
      ),
      Container(
        child: const Center(
          child: Text('Profile'),
        ),
      ),
    ];
  }

  void _updateFloatingButtons() {
    floatingButtons = [
      null,
      FloatingActionButton(
        onPressed: () {
          debugPrint('clicked!');
        },
        backgroundColor: AppColors.mainTheme,
        child: const Icon(Icons.add),
      ),
      null,
      null,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        centerTitle: true,
        backgroundColor: AppColors.mainTheme,
        title: Text(
          appBarTitles[index],
          style: AppTextStyle.comforta16W400.apply(color: AppColors.white),
        ),
      ),
      backgroundColor: AppColors.white,
      extendBody: true,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: tabs,
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 3,
        color: AppColors.mainTheme,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, top: 8),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  AppIcons.usersList,
                  color: index == 0 ? AppColors.black : AppColors.white,
                  width: 25,
                ),
                splashRadius: .1,
                onPressed: () => onChangedTab(0),
              ),
              Container(
                margin: const EdgeInsets.only(right: 25),
                child: IconButton(
                  icon: SvgPicture.asset(
                    AppIcons.posts,
                    color: index == 1 ? AppColors.black : AppColors.white,
                    width: 25,
                  ),
                  splashRadius: .1,
                  onPressed: () => onChangedTab(1),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 25),
                child: IconButton(
                  icon: SvgPicture.asset(
                    AppIcons.gallery,
                    color: index == 2 ? AppColors.black : AppColors.white,
                    width: 25,
                  ),
                  splashRadius: .1,
                  onPressed: () => onChangedTab(2),
                ),
              ),
              IconButton(
                icon: SvgPicture.asset(
                  AppIcons.profile,
                  color: index == 3 ? AppColors.black : AppColors.white,
                  width: 25,
                ),
                splashRadius: .1,
                onPressed: () => onChangedTab(3),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: floatingButtons[index],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
