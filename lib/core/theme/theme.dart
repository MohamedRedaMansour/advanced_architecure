import 'package:advanced_architecture_demo/core/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_bar_theme.dart';
import 'bottom_sheet_theme.dart';
import 'button_theme.dart';
import 'colors/config_colors.dart';
import 'icon_theme.dart';
import 'input_decoration_theme.dart';

class Themes {
  buildThemeData({required bool isArabic}) => ThemeData(
        primaryColor: ConstantsColors.secondaryColor,
        scaffoldBackgroundColor: ConstantsColors.greyColor,
        disabledColor: Colors.grey.shade400,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: ConstantsColors.lightGreyColor,
          primary: ConstantsColors.mainBackgroundColorMedium,
        ),
        // fontFamily: isArabic
        //     ? GoogleFonts.cairo().fontFamily
        //     : GoogleFonts.ubuntu().fontFamily,
        appBarTheme: appBarTheme,
        textTheme: textTheme.apply(fontSizeFactor: 1.sp),
        inputDecorationTheme: inputDecorationTheme,
        iconTheme: iconTheme,
        buttonTheme: buttonTheme,
        elevatedButtonTheme: elevatedButtonThemeData,
        bottomSheetTheme: bottomSheetTheme,
        floatingActionButtonTheme: floatingActionButtonThemeData,
      );

  //TTT: the dark theme
  // final darkTheme = ThemeData.dark().copyWith(
  //   primaryColor: Colors.blueGrey[800],
  // );


}
