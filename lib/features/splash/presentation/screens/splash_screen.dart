import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lactaamor/core/theme/app_colors.dart';
import 'package:lactaamor/features/auth/view/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _entryController;
  late AnimationController _loaderController;
  late AnimationController _textController;

  late Animation<double> _fadeEntry;
  late Animation<double> _scaleEntry;
  late Animation<double> _textFade;

  final List<String> _messages = [
    "Preparando tu espacio seguro...",
    "Cargando información confiable...",
    "Estamos contigo en cada etapa...",
  ];

  int _currentMessage = 0;
  Timer? _textTimer;

  @override
  void initState() {
    super.initState();

    /// 🔹 Animación de aparición general
    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeEntry = CurvedAnimation(
      parent: _entryController,
      curve: Curves.easeOut,
    );

    _scaleEntry = Tween<double>(begin: 0.9, end: 1).animate(
      CurvedAnimation(parent: _entryController, curve: Curves.easeOutBack),
    );

    _entryController.forward();

    /// 🔹 Loader animado
    _loaderController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    /// 🔹 Animación texto
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _textFade = CurvedAnimation(
      parent: _textController,
      curve: Curves.easeInOut,
    );

    _textController.forward();

    _textTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      setState(() {
        _currentMessage = (_currentMessage + 1) % _messages.length;
      });
      _textController.forward(from: 0);
    });

    /// 🔹 Navegación automática con animación
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 700),
            pageBuilder: (_, animation, __) =>
                const LoginScreen(), // Cambia por tu HomeScreen
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _entryController.dispose();
    _loaderController.dispose();
    _textController.dispose();
    _textTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: -120,
              right: -120,
              child: _softCircle(AppColors.primaryLight),
            ),
            Positioned(
              bottom: -120,
              left: -120,
              child: _softCircle(AppColors.secondary),
            ),

            Center(
              child: FadeTransition(
                opacity: _fadeEntry,
                child: ScaleTransition(
                  scale: _scaleEntry,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // LOGO
                      Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.25),
                              blurRadius: 25,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.favorite_rounded,
                          color: Colors.white,
                          size: 48,
                        ),
                      ),

                      const SizedBox(height: 40),

                      RotationTransition(
                        turns: _loaderController,
                        child: SizedBox(
                          width: 42,
                          height: 42,
                          child: CircularProgressIndicator(
                            strokeWidth: 4,
                            valueColor: AlwaysStoppedAnimation(
                              AppColors.primary,
                            ),
                            backgroundColor: AppColors.primary.withOpacity(0.1),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      const Text(
                        "Inicializando...",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),

                      const SizedBox(height: 10),

                      FadeTransition(
                        opacity: _textFade,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Text(
                            _messages[_currentMessage],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Footer fijo abajo
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Container(
                    width: 160,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 50,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    "VERSIÓN 1.0.0",
                    style: TextStyle(
                      fontSize: 11,
                      letterSpacing: 2,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _softCircle(Color color) {
    return Container(
      width: 260,
      height: 260,
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        shape: BoxShape.circle,
      ),
    );
  }
}
