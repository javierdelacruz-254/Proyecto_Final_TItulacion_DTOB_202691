import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/features/auth/viewmodel/auth_state.dart';
import 'package:lactaamor/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:lactaamor/features/register/view/register_screen.dart';
import 'package:lactaamor/features/auth/view/reset_password.dart';
import 'package:lactaamor/features/home/view/home_screen.dart';
import 'package:lactaamor/features/splash/view/widgets/animated_wave_background.dart';
import 'package:lactaamor/shared/widgets/auth_button.dart';
import 'package:lactaamor/shared/widgets/auth_text_field.dart';

class LoginScreen extends ConsumerStatefulWidget {
  final String? autoEmail;
  final String? autoPassword;
  final bool autoLogin;

  const LoginScreen({
    super.key,
    this.autoEmail,
    this.autoPassword,
    this.autoLogin = false,
  });

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  bool _rememberMe = false;

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
    _loadSavedEmail();

    if (widget.autoLogin &&
        widget.autoEmail != null &&
        widget.autoPassword != null) {
      emailController.text = widget.autoEmail!;
      passwordController.text = widget.autoPassword!;
      _rememberMe = true; // opcional

      // Dejamos que el build se ejecute antes de disparar login
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(authViewModelProvider.notifier)
            .login(
              widget.autoEmail!.trim(),
              widget.autoPassword!.trim(),
              rememberMe: _rememberMe,
            );
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void _loadSavedEmail() async {
    final viewModel = ref.read(authViewModelProvider.notifier);

    final savedEmail = await viewModel.getSavedEmail();
    final rememberMe = await viewModel.getRememberMe();

    if (savedEmail != null) {
      emailController.text = savedEmail;
    }

    setState(() {
      _rememberMe = rememberMe;
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authViewModelProvider);

    ref.listen<AuthState>(authViewModelProvider, (previous, next) {
      if (next.user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Inicio de sesión exitoso"),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }

      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error ?? "Error al iniciar sesión"),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    });

    return Scaffold(
      body: Stack(
        children: [
          AnimatedWaveBackground(),

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
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                            ),

                            const SizedBox(height: 40),

                            Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  AuthTextField(
                                    controller: emailController,
                                    hint: "Correo electrónico",
                                    icon: Icons.email,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Por favor ingresa tu correo";
                                      }
                                      final emailRegex = RegExp(
                                        r'^[^@]+@[^@]+\.[^@]+',
                                      );
                                      if (!emailRegex.hasMatch(value)) {
                                        return "Correo inválido";
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 15),

                                  AuthTextField(
                                    controller: passwordController,
                                    hint: "Contraseña",
                                    icon: Icons.lock,
                                    isPassword: true,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Por favor ingresa tu contraseña";
                                      }
                                      if (value.length < 6) {
                                        return "La contraseña debe tener al menos 6 caracteres";
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 8),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      value: _rememberMe,
                                      onChanged: (value) {
                                        setState(() {
                                          _rememberMe = value ?? false;
                                        });
                                        ref
                                            .read(
                                              authViewModelProvider.notifier,
                                            )
                                            .saveRememberMe(_rememberMe);
                                        if (!_rememberMe) {
                                          ref
                                              .read(
                                                authViewModelProvider.notifier,
                                              )
                                              .saveEmail('');
                                        }
                                      },
                                    ),
                                    Text(
                                      "Recordarme",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            const SizedBox(height: 30),

                            AuthButton(
                              text: "Iniciar Sesión",

                              isLoading: state.isLoginLoading,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  ref
                                      .read(authViewModelProvider.notifier)
                                      .login(
                                        emailController.text.trim(),
                                        passwordController.text.trim(),
                                        rememberMe: _rememberMe,
                                      );
                                }
                              },
                            ),

                            const SizedBox(height: 16),

                            // "¿Olvidaste tu contraseña?" debajo del botón
                            Center(
                              child: TextButton(
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          const ResetPasswordScreen(),
                                    ),
                                  );
                                },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
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

                            const Spacer(),

                            Center(
                              child: RichText(
                                text: TextSpan(
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  children: [
                                    const TextSpan(text: "¿No tienes cuenta? "),
                                    WidgetSpan(
                                      alignment: PlaceholderAlignment.middle,
                                      child: GestureDetector(
                                        onTap: () {
                                          FocusScope.of(context).unfocus();
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
