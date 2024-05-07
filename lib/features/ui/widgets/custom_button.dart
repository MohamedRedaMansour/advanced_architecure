import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_font_size.dart';
import '../../../core/theme/colors/config_colors.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? radius;
  final EdgeInsetsGeometry? contentPadding;
  final Color? color;
  final Color? textColor;
  final Color? hoveColor;
  final FontWeight? textWeight;
  final double? textSize;
  final double? elevation;
  final double? gapLeadingText;
  final Widget? child;
  final double width;
  final double height;
  final Color borderColor;
  final Color? shadowColor;
  final Color? overlayColor;
  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.radius,
    this.contentPadding,
    this.color,
    this.textColor,
    this.hoveColor,
    this.textSize,
    this.textWeight,
    this.elevation,
    this.width= 248.0,
    this.height=44.0,
    this.borderColor =  ConstantsColors.primaryColor,
    this.shadowColor,
    this.overlayColor,
  })  : child = null,
        gapLeadingText = null,
        super(key: key);

  const CustomButton.icon({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.child,
    this.gapLeadingText = 10,
    this.radius,
    this.contentPadding,
    this.color,
    this.shadowColor,
    this.textColor,
    this.hoveColor,
    this.textSize,
    this.textWeight,
    this.elevation,
    this.width=248.0,
    this.height=44.0,
    this.overlayColor,
  }) :this.borderColor=ConstantsColors.primaryColor, super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      height: height.h,
      child: TextButton(
        onPressed: onPressed,
        clipBehavior: Clip.antiAlias,
        style:Theme.of(context).elevatedButtonTheme.style!.copyWith(
            elevation: MaterialStateProperty.all(elevation??0),
            overlayColor: MaterialStateProperty.all(overlayColor),
            shadowColor: MaterialStateProperty.all(shadowColor??ConstantsColors.greyColor),
          backgroundColor: MaterialStateProperty.all(color??ConstantsColors.primaryColor),
          shape:  MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r), side: BorderSide(color: borderColor)))
        ),
        child: child == null
            ? CustomText(
                text: text,
                color: textColor ?? Colors.white,
                alignment: AlignmentDirectional.center,
                maxLines: 1,
                fontSize: textSize?? AppFontSize.medium,
                fontWeight: textWeight?? FontWeight.w600,

              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  child!,
                  SizedBox(width: gapLeadingText),
                  CustomText(
                    text: text,
                    color: textColor ?? Colors.white,
                    alignment: AlignmentDirectional.center,
                    maxLines: 1,
                    fontSize: textSize?? AppFontSize.medium,
                    fontWeight: textWeight ?? FontWeight.w600,
                  )
                ],
              ),
      ),
    );
  }
}
