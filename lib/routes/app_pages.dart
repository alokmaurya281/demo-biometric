import 'package:biomteric_auth/modules/auth/bindings/login_binding.dart';
import 'package:biomteric_auth/modules/auth/views/login_view.dart';
import 'package:biomteric_auth/modules/home/bindings/home_binding.dart';
import 'package:biomteric_auth/modules/home/views/home_view.dart';
import 'package:biomteric_auth/routes/app_routes.dart';
import 'package:get/get.dart';

class AppPages {
  AppPages._();
  static const initial = AppRoutes.lgoin;

  static final routes = [
    GetPage(
      name: Paths.login,
      binding: LoginBinding(),
      page: () => LoginView(),
    ),
    GetPage(
      name: Paths.home,
      binding: HomeBinding(),
      page: () => HomeView(),
    ),
  ];
}
