import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/features/auth/presentation/providers/auth_provider.dart';
import 'package:lactaamor/features/auth/presentation/screens/login_screen.dart';
import 'package:lactaamor/features/auth/presentation/widgets/auth_button.dart';
import 'package:lactaamor/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:lottie/lottie.dart';

class NewPasswordScreen extends ConsumerWidget {
  final String code;

  const NewPasswordScreen({super.key, required this.code});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newpasswordController = TextEditingController();

    final state = ref.watch(authProvider);
    final formKey = GlobalKey<FormState>();

    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next.message != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.message!)));
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
              'assets/lottie/nuevo_password.json',
              width: 150,
              height: 150,
            ),
            Text(
              "Porfavor ingresa tu correo y te enviaremos un código de verificación.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Form(
              key: formKey,
              child: Column(
                children: [
                  AuthTextField(
                    controller: newpasswordController,
                    hint: "Nueva contraseña",
                    icon: Icons.lock,
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Ingresa tu nueva contraseña";
                      }
                      if (value.length < 6) {
                        return "Debe tener al menos 6 caracteres";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  AuthButton(
                    text: "Enviar código",
                    isLoading: state.status == AuthStatus.loading,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        ref
                            .read(authProvider.notifier)
                            .confirmResestUseCase(
                              code,
                              newpasswordController.text.trim(),
                            );
                        if (state.status == AuthStatus.codeSent) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => LoginScreen()),
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
