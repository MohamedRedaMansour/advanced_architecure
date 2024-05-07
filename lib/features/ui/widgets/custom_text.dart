import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/colors/config_colors.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color color;
  final Color? bgColor;
  final AlignmentDirectional alignment;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final int? maxLines;
  final TextAlign? textAlign;
  final FontStyle? fontStyle;
  final TextOverflow? overflow;
  final TextDirection? textDirection;
  final bool isArabicText;
  final double? letterSpacing;
  final TextStyle? style;
  final EdgeInsetsGeometry? textPadding;
  final EdgeInsetsGeometry? textMargin;
  final double? textHeight;
  final TextDecoration? textDecoration;
  final TextScaler? textScaler;

  const CustomText(
      {Key? key,
      required this.text,
      this.fontSize,
      this.color = ConstantsColors.primaryColor,
      this.alignment = AlignmentDirectional.topStart,
      this.isArabicText = false,
      this.bgColor,
      this.fontFamily,
      this.fontWeight,
      this.maxLines,
      this.textAlign,
      this.fontStyle,
      this.overflow,
      this.textDirection,
      this.letterSpacing,
      this.style,
      this.textMargin,
      this.textHeight = 1.1,
      this.textPadding,
      this.textDecoration = TextDecoration.none,
      this.textScaler = TextScaler.noScaling})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      color: bgColor,
      padding: textPadding,
      margin: textMargin,
      child: Text(
        text,
        key: key,
        maxLines: maxLines,
        overflow: overflow ?? TextOverflow.ellipsis,
        textAlign: textAlign,
        textDirection: textDirection,
        textScaler: textScaler ,
        style: style ??
            TextStyle(
              decoration: textDecoration,
              color: color,
              fontSize: fontSize ?? 16.sp,
              letterSpacing: letterSpacing,
              fontWeight: fontWeight ?? FontWeight.normal,
              fontStyle: fontStyle ?? FontStyle.normal,
              height: textHeight,
            ),
      ),
    );
  }
}
