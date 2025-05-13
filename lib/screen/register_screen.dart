import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:application_medicines/auth_controller.dart';

class RegisterScreen extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final RxString emailError = ''.obs; // Variable para mostrar error en email
  final RxString passwordError = ''.obs; // Variable para mostrar error en contraseña
  final RxString confirmPasswordError = ''.obs; // Variable para mostrar error en confirmación

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
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
            const SizedBox(height: 16),
            Obx(() => TextField(
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirmar Contraseña',
                    border: const OutlineInputBorder(),
                    errorText: confirmPasswordError.value.isEmpty ? null : confirmPasswordError.value,
                  ),
                  obscureText: true,
                )),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Validar inputs
                emailError.value = emailController.text.isEmpty ? 'El correo no puede estar vacío' : '';
                passwordError.value = passwordController.text.isEmpty ? 'La contraseña no puede estar vacía' : '';
                confirmPasswordError.value = confirmPasswordController.text.isEmpty
                    ? 'La confirmación no puede estar vacía'
                    : (passwordController.text != confirmPasswordController.text
                        ? 'Las contraseñas no coinciden'
                        : '');

                if (emailError.value.isEmpty &&
                    passwordError.value.isEmpty &&
                    confirmPasswordError.value.isEmpty) {
                  authController.createAccount(
                    emailController.text,
                    passwordController.text,
                  );
                }
              },
              child: const Text('Registrarse'),
            ),
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('¿Ya tienes cuenta? Inicia Sesión'),
            ),
          ],
        ),
      ),
    );
  }
}