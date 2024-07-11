import 'dart:developer';

import 'package:biomteric_auth/modules/auth/controllers/login_controller.dart';
import 'package:biomteric_auth/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LoginController>(builder: ((c) {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: 300,
                height: 500,
                padding: const EdgeInsets.all(16),
                // height: 300,
                // width: 300,
                child: SvgPicture.asset('assets/images/bg1.svg'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
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
                      child: Text('Biometric Authentication Not Supported'),
                    ),
                ],
              ),
            ),
          ],
        );
      })),
    );
  }
}
