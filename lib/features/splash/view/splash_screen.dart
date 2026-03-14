import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lactaamor/core/services/push_notification_service.dart';
import 'package:lactaamor/features/auth/view/login_screen.dart';
import 'package:lactaamor/features/auth/view/new_password_screen.dart';
import 'package:lactaamor/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:lactaamor/features/home/view/home_screen.dart';
import 'package:lactaamor/firebase_options.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  final AppLinks _appLinks = AppLinks();

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      // 1. Inicializacion de Firebase
      await Firebase.initializeApp(options: DefaultFirebaseOptions.android);

      // 2. Inicializacion de  Push Notifications
      final auth = ref.read(authViewModelProvider);
      final userId = auth.user?.uid;
      await PushNotificationService.initialize(userId: userId);

      // 3. Inicializacion de otros servicios (Firestore, API, etc.)
      await ref.read(authViewModelProvider.notifier).checkLoggedIn();
      await FirebaseMessaging.instance.requestPermission();

      // 4. Inicializacion de Deep Links
      await _handleDeepLinks();

      // 5. Cualquier otra inicialización (settings, localization, etc.)
      await initializeDateFormatting('es_PE', null);

      // 6. Espera mínima para animación (opcional)
      await Future.delayed(const Duration(milliseconds: 800));

      // 7. Al terminar, navega a la pantalla correspondiente
      if (!mounted) return;

      final viewModel = ref.read(authViewModelProvider);
      final user = viewModel.user;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              user != null ? const HomeScreen() : const LoginScreen(),
        ),
      );
    } catch (e, st) {
      print('Error inicializando app: $e\n$st');
    }
  }

  Future<void> _handleDeepLinks() async {
    final uri = await _appLinks.getInitialLink();
    if (uri != null) {
      _processLink(uri);
    }

    _appLinks.uriLinkStream.listen((uri) {
      _processLink(uri);
    });
  }

  void _processLink(Uri uri) {
    if (uri.queryParameters["mode"] == "resetPassword") {
      final oobCode = uri.queryParameters["oobCode"];
      if (oobCode != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => NewPasswordScreen(code: oobCode)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/img/logo.png', width: 150),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
            const SizedBox(height: 10),
            const Text('Cargando tu app...', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
