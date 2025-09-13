import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:rick_and_morty_characters/screens/favorites/favorites_screen.dart';
import 'package:rick_and_morty_characters/screens/main/main_screen.dart';
import 'package:rick_and_morty_characters/utils/app_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  List<PersistentTabConfig> _buildNavBarTabs(BuildContext context) {
    return [
      _buildNavBarTab(
        context,
        screen: MainScreen(),
        iconPath: 'assets/icons/ic_home.png',
        title: "Главный экран",
      ),
      _buildNavBarTab(
        context,
        screen: FavoriteScreen(),
        iconPath: 'assets/icons/ic_favorite.png',
        title: "Избранное",
      ),
    ];
  }

  PersistentTabConfig _buildNavBarTab(
    BuildContext context, {
    required Widget screen,
    required String iconPath,
    required String title,
  }) {
    return PersistentTabConfig(
      screen: screen,
      item: _buildNavBarItem(context, iconPath, title),
    );
  }

  static ItemConfig _buildNavBarItem(BuildContext context, String assetPath, String title) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final activeColor = isDark ? Colors.white : Colors.deepPurple.shade900;
    final inactiveColor = isDark ? Colors.grey[700]! : Colors.grey;

    return ItemConfig(
      icon: Image.asset(assetPath, width: 24, height: 24, color: activeColor),
      inactiveIcon: Image.asset(assetPath, width: 24, height: 24, color: inactiveColor),
      title: title,
      textStyle: AppStyles.getAppTextStyle(
        color: activeColor,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        context: context,
        fontFamily: 'comic',
      ),
      activeForegroundColor: activeColor,
      inactiveForegroundColor: inactiveColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return PersistentTabView(
      tabs: _buildNavBarTabs(context),
      navBarBuilder: (navBarConfig) => Style1BottomNavBar(
        navBarConfig: navBarConfig,
        navBarDecoration: NavBarDecoration(
          color: isDark ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}
