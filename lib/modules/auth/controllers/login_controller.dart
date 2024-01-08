import 'dart:developer';

import 'package:biomteric_auth/modules/custom/controllers/custom_controller.dart';
import 'package:biomteric_auth/routes/app_routes.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class LoginController extends CustomController {
  RxBool isDeviceSupportedBiometric = false.obs;
  RxBool canCheckBiometric = false.obs;
  late RxList<BiometricType> availableBiometrics;
  RxBool isAuthenticated = false.obs;

  final LocalAuthentication biometricAuth = LocalAuthentication();

  @override
  void onInit() async {
    await isBiometrciSupported();
    await checkBiometrics();
    super.onInit();
  }

  @override
  void onReady() async {
    await authenticate();
    super.onReady();
  }

  Future<void> isBiometrciSupported() async {
    if (await biometricAuth.isDeviceSupported()) {
      isDeviceSupportedBiometric = true.obs;
    } else {
      isDeviceSupportedBiometric = false.obs;
    }
  }

  Future<void> checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await biometricAuth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      log(e.toString());
    }

    canCheckBiometric.value = canCheckBiometrics;
  }

  Future<void> getAvailableBiometrics() async {
    late List<BiometricType> allavailableBiometrics;
    try {
      allavailableBiometrics = await biometricAuth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[].obs;
      log(e.toString());
    }

    availableBiometrics = allavailableBiometrics.obs;
  }

  Future<void> authenticate() async {
    try {
      await getAvailableBiometrics();
      if (isDeviceSupportedBiometric.value) {
        bool isAuthenticate = await biometricAuth.authenticate(
          localizedReason: 'Scan your fingerprint  to authenticate',
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true,
            useErrorDialogs: true,
          ),
        );
        if (isAuthenticate) {
          // Authentication successful, navigate to the main screen
          isAuthenticated = isAuthenticate.obs;
          Get.offNamed(AppRoutes.home); // Replace with your main screen route
        } else {
          isAuthenticated.value = false;
        }
      } else {
        isAuthenticated.value = false;
        log('Not Supported');
      }
    } on PlatformException catch (e) {
      log(e.toString());
      isAuthenticated.value = false;
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
