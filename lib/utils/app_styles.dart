import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static TextStyle getAppTextStyle({
  required String fontFamily,
  required Color color,
  required double fontSize,
  double letterSpacing = 0,
  required FontWeight fontWeight,
  FontStyle fontStyle = FontStyle.normal,
  required BuildContext context,
  bool isStrikethrough = false, 
  double? lineHeight,           
}) {
  double screenWidth = MediaQuery.of(context).size.width;
  double adjustedFontSize = fontSize;

  if (screenWidth <= 360) {
    adjustedFontSize = fontSize * 0.85;
  } else if (screenWidth <= 420) {
    adjustedFontSize = fontSize * 0.95;
  }

  adjustedFontSize = adjustedFontSize.clamp(8.0, fontSize + 10.0);
  TextStyle Function({TextStyle? textStyle}) fontGetter;

  switch (fontFamily.toLowerCase()) {
    case 'comic':
      fontGetter = GoogleFonts.comicNeue;
      break;
    default:
      fontGetter = GoogleFonts.roboto;
  }

  return fontGetter(
    textStyle: TextStyle(
      fontStyle: fontStyle,
      color: color,
      fontSize: adjustedFontSize,
      letterSpacing: letterSpacing,
      fontWeight: fontWeight,
      decoration: isStrikethrough ? TextDecoration.lineThrough : TextDecoration.none,
      decorationColor: Color(0xff8BBCA6),
      height: lineHeight,
    ),
  );
}
}
