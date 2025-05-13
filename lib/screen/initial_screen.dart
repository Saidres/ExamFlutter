import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:application_medicines/auth_controller.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    _checkAuth(authController);

    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  void _checkAuth(AuthController authController) async {
    final isAuthenticated = await authController.checkAuth();
    if (isAuthenticated) {
      // Redirigir a la pantalla de Home y eliminar el historial de navegación
      Get.offAllNamed('/medications');
    } else {
      // Redirigir a la pantalla de login y eliminar el historial de navegación
      Get.offAllNamed('/login');
    }
  }
}
