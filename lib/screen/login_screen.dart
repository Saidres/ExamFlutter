import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:application_medicines/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final RxString emailError = ''.obs; // Variable para mostrar error en email
  final RxString passwordError = ''.obs; // Variable para mostrar error en contraseña

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar Sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Correo Electrónico',
                    border: const OutlineInputBorder(),
                    errorText: emailError.value.isEmpty ? null : emailError.value,
                  ),
                  keyboardType: TextInputType.emailAddress,
                )),
            const SizedBox(height: 16),
            Obx(() => TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    border: const OutlineInputBorder(),
                    errorText: passwordError.value.isEmpty ? null : passwordError.value,
                  ),
                  obscureText: true,
                )),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                // Validar inputs
                emailError.value = emailController.text.isEmpty ? 'El correo no puede estar vacío' : '';
                passwordError.value = passwordController.text.isEmpty ? 'La contraseña no puede estar vacía' : '';

                if (emailError.value.isEmpty && passwordError.value.isEmpty) {
                  await authController.login(
                    emailController.text,
                    passwordController.text,
                  );
                }
              },
              child: const Text('Iniciar Sesión'),
            ),
            TextButton(
              onPressed: () => Get.toNamed('/register'),
              child: const Text('¿No tienes cuenta? Regístrate'),
            ),
          ],
        ),
      ),
    );
  }
}