import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'core/bindings/controller_binder.dart';
import 'core/services/storage_service.dart';
import 'core/utils/theme/theme.dart';
import 'routes/app_routes.dart';

class Beautipholl extends StatelessWidget {
  const Beautipholl({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(402, 874),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: !StorageService.hasSeenOnboarding()
              ? AppRoute.onboardingScreen
              : StorageService.isLoggedIn()
                  ? AppRoute.homeScreen
                  : AppRoute.loginScreen,
          getPages: AppRoute.routes,
          initialBinding: ControllerBinder(),
          themeMode: ThemeMode.light,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
        );
      },
    );
  }
}
