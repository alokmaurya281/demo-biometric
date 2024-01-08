import 'package:biomteric_auth/modules/auth/controllers/login_controller.dart';
import 'package:biomteric_auth/modules/custom/bindings/custom_binding.dart';
import 'package:biomteric_auth/routes/app_pages.dart';
import 'package:biomteric_auth/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: LoginController().isAuthenticated.value
          ? AppRoutes.home
          : AppPages.initial,
      getPages: AppPages.routes,
      initialBinding: CustomBinding(),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
    );
  }
}
