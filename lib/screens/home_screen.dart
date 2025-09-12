import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:rick_and_morty_characters/screens/favorites/favorites_screen.dart';
import 'package:rick_and_morty_characters/screens/main/main_screen.dart';
import 'package:rick_and_morty_characters/utils/app_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppBottomNavBar();
  }
}

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({super.key});

  List<PersistentTabConfig> _tabs(BuildContext context) => [
        PersistentTabConfig(
          screen: MainScreen(),
          item: _tabNavItem('assets/icons/ic_home.png', "Главный экран", context),
        ),
        PersistentTabConfig(
          screen: FavoriteScreen(),
          item: _tabNavItem('assets/icons/ic_favorite.png', "Избранное", context),
        ),
      ];


static ItemConfig _tabNavItem(String assetPath, String title, BuildContext context) {
  return ItemConfig(
    icon: Image.asset(
      assetPath,
      width: 24,
      height: 24,
    ),
    title: title,
    textStyle:  AppStyles.getAppTextStyle(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      context: context,
      fontFamily: 'comic',
    ),
    inactiveIcon: Image.asset(
      assetPath,
      width: 24,
      height: 24,
      color: Colors.grey,
    ),
    activeForegroundColor: Colors.black,
    inactiveForegroundColor: Colors.grey,
  );
}


  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      tabs: _tabs(context),
      navBarBuilder: (navBarConfig) => Style1BottomNavBar(
        navBarConfig: navBarConfig,
      ),
    );
  }
}
