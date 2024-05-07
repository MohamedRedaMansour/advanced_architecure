import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_font_size.dart';
import 'colors/config_colors.dart';

InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    isDense: true,
    contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
    hintStyle: TextStyle(
        color: ConstantsColors.lightRed, height: 1.3, fontSize: 16.sp),
    filled: true,
    fillColor: ConstantsColors.lightRed,
    enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: ConstantsColors.lightGreyColor,
          width: 1.0,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(10.r),
        )),
    focusedBorder: OutlineInputBorder(
        borderSide:
            const BorderSide(color: ConstantsColors.grayShadeColor, width: 1.0),
        borderRadius: BorderRadius.all(
          Radius.circular(10.r),
        )),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: ConstantsColors.lightRed,
      ),
      borderRadius: BorderRadius.circular(4.r),
    ),
    errorStyle: TextStyle(
      fontSize: AppFontSize.mid_small,
      color: ConstantsColors.lightRed,
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(
        color: ConstantsColors.lightRed,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(4.r),
    ),
    border: OutlineInputBorder(
      borderSide: const BorderSide(
        color: ConstantsColors.greyColor,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(4.r),
    ),
    labelStyle: MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
      final Color color = states.contains(MaterialState.error)
          ? ConstantsColors.lightRed
          : Colors.black;
      return TextStyle(
        fontSize: 9.sp,
        color: color,
        fontWeight: FontWeight.normal,
      );
    }));
