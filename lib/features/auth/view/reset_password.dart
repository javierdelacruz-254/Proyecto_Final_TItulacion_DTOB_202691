import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/features/auth/view/enter_code_screen.dart';
import 'package:lactaamor/features/auth/view/widgets/auth_button.dart';
import 'package:lactaamor/features/auth/view/widgets/auth_text_field.dart';
import 'package:lactaamor/features/auth/viewmodel/auth_state.dart';
import 'package:lactaamor/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:lottie/lottie.dart';

class ResetPasswordScreen extends ConsumerWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final state = ref.watch(authViewModelProvider);
    final formKey = GlobalKey<FormState>();

    ref.listen<AuthState>(authViewModelProvider, (previous, next) {
      if (next.error != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.error!)));
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Recuperar contraseña"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Lottie.asset(
              'assets/lottie/olvide_contraseña.json',
              width: 150,
              height: 150,
            ),
            Text(
              "Por favor ingresa tu correo y te enviaremos un código de verificación.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Form(
              key: formKey,
              child: Column(
                children: [
                  AuthTextField(
                    controller: emailController,
                    hint: "Correo electrónico",
                    icon: Icons.email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Por favor ingresa tu correo de respaldo";
                      }
                      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                      if (!emailRegex.hasMatch(value)) {
                        return "Correo inválido";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  AuthButton(
                    text: "Enviar código",
                    isLoading: state.isLoading,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        ref
                            .read(authViewModelProvider.notifier)
                            .sendResetLink(emailController.text.trim());
                        if (state.isLoading == false) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EnterCodeScreen(
                                email: emailController.text.trim(),
                              ),
                            ),
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
