import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/features/auth/presentation/providers/auth_provider.dart';
import 'package:lactaamor/features/auth/presentation/screens/register_screen.dart';
import 'package:lactaamor/features/auth/presentation/screens/reset_password.dart';
import 'package:lactaamor/features/auth/presentation/widgets/auth_button.dart';
import 'package:lactaamor/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:lactaamor/features/home/presentation/screens/home_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> fadeAnimation;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    fadeAnimation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authProvider);

    ref.listen(authProvider, (previous, next) {
      if (next.status == AuthStatus.authenticated) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Inicio de sesión exitoso 🎉"),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }

      if (next.status == AuthStatus.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.message ?? "Error al iniciar sesión"),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    });

    return Scaffold(
      body: Stack(
        children: [
          const _WaveBackground(),

          SafeArea(
            child: FadeTransition(
              opacity: fadeAnimation,
              child: LayoutBuilder(
                builder: (context, constraits) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraits.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/img/logo_sin_nombre.png",
                                  width: 50,
                                  height: 50,
                                ),

                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "LactaAmor",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge
                                          ?.copyWith(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                          ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "Siempre acompañandote",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge
                                          ?.copyWith(
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            const SizedBox(height: 50),

                            Text(
                              "Iniciar Sesión",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineMedium
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                            ),

                            const SizedBox(height: 40),

                            AuthTextField(
                              controller: emailController,
                              hint: "Correo electrónico",
                              icon: Icons.email,
                            ),

                            const SizedBox(height: 15),

                            AuthTextField(
                              controller: passwordController,
                              hint: "Contraseña",
                              icon: Icons.lock,
                              isPassword: true,
                            ),

                            const SizedBox(height: 8),

                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          const ResetPasswordScreen(),
                                    ),
                                  );
                                },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets
                                      .zero, // evita padding extra feo
                                  minimumSize: const Size(0, 0),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text(
                                  "¿Olvidaste tu contraseña?",
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 30),

                            state.status == AuthStatus.loading
                                ? CircularProgressIndicator(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  )
                                : AuthButton(
                                    text: "Iniciar Sesión",
                                    onPressed: () {
                                      ref
                                          .read(authProvider.notifier)
                                          .login(
                                            emailController.text.trim(),
                                            passwordController.text.trim(),
                                          );
                                    },
                                  ),

                            const SizedBox(height: 25),

                            Center(
                              child: Text(
                                "O ingresa con",
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(color: Colors.grey[600]),
                              ),
                            ),

                            const SizedBox(height: 15),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                OutlinedButton.icon(
                                  onPressed: () {
                                    ref
                                        .read(authProvider.notifier)
                                        .loginWithGoogle();
                                  },
                                  icon: Image.asset(
                                    "assets/img/google.png",
                                    height: 20,
                                  ),
                                  label: const Text("Inicia Sesion con Google"),
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 60,
                                      vertical: 12,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),

                            Center(
                              child: RichText(
                                text: TextSpan(
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  children: [
                                    const TextSpan(text: "¿No tienes cuenta? "),
                                    WidgetSpan(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  const RegisterScreen(),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          "Regístrate",
                                          style: TextStyle(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WaveBackground extends StatelessWidget {
  const _WaveBackground();

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(child: CustomPaint(painter: _WavePainter()));
  }
}

class _WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintPrimary = Paint()
      ..color = const Color(0xFF00464F).withOpacity(0.15)
      ..style = PaintingStyle.fill;

    final pathPrimary = Path();

    // Ola verde
    pathPrimary.moveTo(0, size.height * 0.40);
    pathPrimary.cubicTo(
      size.width * 0.2,
      size.height * 0.35,
      size.width * 0.4,
      size.height * 0.55,
      size.width * 0.6,
      size.height * 0.45,
    );

    pathPrimary.cubicTo(
      size.width * 0.8,
      size.height * 0.35,
      size.width,
      size.height * 0.50,
      size.width,
      size.height * 0.45,
    );
    pathPrimary.lineTo(size.width, size.height);
    pathPrimary.lineTo(0, size.height);
    pathPrimary.close();

    canvas.drawPath(pathPrimary, paintPrimary);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
