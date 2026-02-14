import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/features/auth/presentation/widgets/auth_button.dart';
import 'package:lactaamor/features/auth/presentation/widgets/auth_header.dart';
import 'package:lactaamor/features/auth/presentation/widgets/auth_text_field.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8FB),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const AuthHeader(
                title: "Bienvenida",
                subtitle: "Estamos contigo en cada etapa 💜",
              ),
              const SizedBox(height: 40),

              AuthTextField(
                controller: emailController,
                hint: "Correo electrónico",
              ),

              AuthTextField(
                controller: passwordController,
                hint: "Contraseña",
                isPassword: true,
              ),

              AuthButton(
                text: "Iniciar Sesión",
                loading: false,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
