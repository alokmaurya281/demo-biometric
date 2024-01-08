import 'dart:developer';

import 'package:biomteric_auth/modules/auth/controllers/login_controller.dart';
import 'package:biomteric_auth/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  // const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LoginController>(
          // init: LoginController(),
          builder: ((c) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (c.isDeviceSupportedBiometric.value)
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow.shade400,
                    ),
                    onPressed: () async {
                      await c.authenticate();
                      if (c.isAuthenticated.value) {
                        log('Authenticated');
                        Get.toNamed(AppRoutes.home);
                      } else {
                        log('Not Authenticated');
                      }
                    },
                    child: const Text(
                      'Authenticate with Fingerprint',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              if (!c.isDeviceSupportedBiometric.value)
                const Center(
                  child: Text('Not Supported'),
                ),
            ],
          ),
        );
      })),
    );
  }
}
