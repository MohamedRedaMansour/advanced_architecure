import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'colors/config_colors.dart';



final appBarTheme = AppBarTheme(
  centerTitle: true,
  backgroundColor: Colors.transparent,
  elevation: 0,
  iconTheme:  IconThemeData(
    color:  ConstantsColors.mainBackgroundColorMedium,
    size: 20,
  ),
  titleTextStyle: TextStyle(
    fontSize: 20.sp,
    color: ConstantsColors.secondaryColor,
    fontWeight: FontWeight.bold,
  ),
);
