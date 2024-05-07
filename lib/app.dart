import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

import 'core/constants/providers/cubit_providers_list.dart';
import 'core/navigation/router.dart' as route;
import 'core/theme/theme.dart';
import 'features/bloc/localization/localization_cubit.dart';
import 'features/ui/screens/splash/splash_screen.dart';
import 'main.dart';

final logger = Logger(
  printer: PrettyPrinter(
    lineLength: 90,
    methodCount: 0,
  ),
);

class FintechApp extends StatelessWidget {
  const FintechApp({super.key});


  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: CubitProvidersList.providerList,
      child: ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              navigatorKey: navigatorKey,
              builder: EasyLoading.init(),
              debugShowCheckedModeBanner: false,
              theme: Themes().buildThemeData(isArabic: true),
              home: (SplashScreen()),
              locale: LocalizationCubit.localeAr,
              supportedLocales:
              context.watch<LocalizationCubit>().supportedLocales,
              onGenerateRoute: route.generateRoute,
              localizationsDelegates:
              context.watch<LocalizationCubit>().localizationDelegates,
            );
          }),
    );
  }
}
