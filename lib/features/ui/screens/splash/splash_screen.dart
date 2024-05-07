import 'package:advanced_architecture_demo/core/constants/app_font_size.dart';
import 'package:advanced_architecture_demo/core/theme/colors/config_colors.dart';
import 'package:advanced_architecture_demo/features/bloc/localization/localization.dart';
import 'package:advanced_architecture_demo/features/ui/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../bloc/app_cubit/base_bloc_consumer.dart';
import '../../../bloc/splash/splash_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstantsColors.blueColor,
      body: SafeArea(
        child:BaseBlocConsumer<SplashCubit, void>(
        onSuccessBuilder: (ctx, state) {
      return Column(
          children: [
            SizedBox(height: .4.sh,),
            CustomText(
              text: context.localization.appName,
              color: ConstantsColors.whiteColor,
              fontSize: AppFontSize.large,
              alignment: AlignmentDirectional.center,
            ),
            SizedBox(height: .35.sh,),
            CustomText(
              text: context.localization.licenseActivated,
              color: ConstantsColors.whiteColor,
              fontSize: AppFontSize.small,
              alignment: AlignmentDirectional.center,
            )
          ],
        );}),
      ),
    );
  }
}
