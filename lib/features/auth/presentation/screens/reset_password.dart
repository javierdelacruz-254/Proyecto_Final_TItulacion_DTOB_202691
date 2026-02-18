import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/features/auth/presentation/providers/auth_provider.dart';
import 'package:lactaamor/features/auth/presentation/widgets/auth_button.dart';
import 'package:lactaamor/features/auth/presentation/widgets/auth_text_field.dart';

class ResetPasswordScreen extends ConsumerWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final state = ref.watch(authProvider);

    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next.message != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.message!)));
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text("Recuperar contraseña")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Text(
              "Ingresa tu correo y te enviaremos un enlace para restablecer tu contraseña.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            AuthTextField(
              controller: emailController,
              hint: "Correo electrónico",
              icon: Icons.email,
            ),
            const SizedBox(height: 30),
            state.status == AuthStatus.loading
                ? const CircularProgressIndicator()
                : AuthButton(
                    text: "Enviar enlace",
                    onPressed: () {
                      ref
                          .read(authProvider.notifier)
                          .resetPassword(emailController.text.trim());
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
