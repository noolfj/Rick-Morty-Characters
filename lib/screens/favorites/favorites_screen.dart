import 'package:flutter/material.dart';
import 'package:rick_and_morty_characters/utils/app_styles.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        forceMaterialTransparency: true,
        title:Text(
          'Избранное',
          style: AppStyles.getAppTextStyle(
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.w600,
            context: context,
            fontFamily: 'comic',
          ),
        ),
      ),
      body: Center(
        child: Text(
          'Избранные',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}