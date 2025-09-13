import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_characters/bloc/character_bloc.dart';
import 'package:rick_and_morty_characters/utils/app_styles.dart';

class ReloadCharacterError extends StatelessWidget {
  const ReloadCharacterError({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Ошибка при получении данных!",
              textAlign: TextAlign.center,
              style: AppStyles.getAppTextStyle(
                color: Colors.redAccent,
                fontSize: 24,
                fontWeight: FontWeight.w600,
                context: context,
                fontFamily: 'comic',
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            SizedBox(
              width: screenWidth * 0.5,
              height: screenHeight * 0.06,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  context.read<CharacterBloc>().add(LoadCharacters());
                },
                child: Text(
                  "Повторить",
                  style: AppStyles.getAppTextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    context: context,
                    fontFamily: 'comic',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
