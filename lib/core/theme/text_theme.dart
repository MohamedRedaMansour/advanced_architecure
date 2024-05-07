

import 'package:flutter/material.dart';

import '../constants/app_font_size.dart';
import 'colors/config_colors.dart';

final textTheme = TextTheme(
  headline1: TextStyle(
    fontSize: AppFontSize.x_x_large,
    fontWeight: FontWeight.w600,
    color: ConstantsColors.primaryColor,
    //fontFamily:  GoogleFonts.cairo().fontFamily,
  ),
  headline2: TextStyle(
    fontSize: AppFontSize.x_large,
    fontWeight: FontWeight.w600,
    color: ConstantsColors.secondaryColor,
    //fontFamily:  GoogleFonts.cairo().fontFamily,
  ),
  headline3: TextStyle(
    fontSize: AppFontSize.large,
    fontWeight: FontWeight.w600,
    color: ConstantsColors.primaryColor,
    //fontFamily:  GoogleFonts.cairo().fontFamily,
  ),
  headline4: TextStyle(
    fontSize: AppFontSize.large,
    fontWeight: FontWeight.bold,
    color: ConstantsColors.grayShadeColor,
    //fontFamily:  GoogleFonts.cairo().fontFamily,
  ),
  headline5: TextStyle(
    fontSize: AppFontSize.medium,
    fontWeight: FontWeight.w600,
    color: ConstantsColors.secondaryColor,
    //fontFamily:  GoogleFonts.cairo().fontFamily,
  ),
   headline6: TextStyle(
    fontSize: AppFontSize.large,
    fontWeight: FontWeight.w600,
    color: ConstantsColors.secondaryColor,
   // fontFamily:  GoogleFonts.cairo().fontFamily,
  ),
  subtitle1: TextStyle(
    fontSize: AppFontSize.x_medium,
    fontWeight: FontWeight.w600,
    color: ConstantsColors.primaryColor,
   // fontFamily:  GoogleFonts.cairo().fontFamily,
  ),
  subtitle2: TextStyle(
    fontSize: AppFontSize.medium,
    fontWeight: FontWeight.w600,
    color: ConstantsColors.grayShadeColor,
   // fontFamily:  GoogleFonts.cairo().fontFamily,
  ),
  bodyText1: TextStyle(
    fontSize: AppFontSize.small,
    fontWeight: FontWeight.w600,
    color: ConstantsColors.primaryColor,
   // fontFamily:  GoogleFonts.cairo().fontFamily,
  ),
  bodyText2: TextStyle(
    fontSize: AppFontSize.small,
    fontWeight: FontWeight.w600,
    color: ConstantsColors.grayShadeColor,
  //  fontFamily:  GoogleFonts.cairo().fontFamily,
  ),
  button: TextStyle(
    fontSize: AppFontSize.medium,
    fontWeight: FontWeight.w600,
    color: ConstantsColors.secondaryColor,
   // fontFamily:  GoogleFonts.cairo().fontFamily,
  ),
);
