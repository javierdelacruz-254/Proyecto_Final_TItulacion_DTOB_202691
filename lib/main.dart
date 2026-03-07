import 'package:app_links/app_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lactaamor/core/services/push_notification_service.dart';
import 'package:lactaamor/features/auth/view/login_screen.dart';
import 'package:lactaamor/features/auth/view/new_password_screen.dart';
import 'package:lactaamor/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:lactaamor/features/home/view/home_screen.dart';
import 'package:lactaamor/firebase_options.dart';
import 'core/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('📩 Notificación recibida en background: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await PushNotificationService.initialize();

  await initializeDateFormatting('es_PE', null);

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  final AppLinks _appLinks = AppLinks();
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    initDeepLinks();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(authViewModelProvider.notifier).checkLoggedIn();
      if (mounted) {
        setState(() => _initialized = true);
      }
    });
  }

  Future<void> initDeepLinks() async {
    final uri = await _appLinks.getInitialLink();

    if (uri != null) {
      handleResetLink(uri);
    }

    _appLinks.uriLinkStream.listen((uri) {
      handleResetLink(uri);
    });
  }

  void handleResetLink(Uri uri) {
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
    if (!_initialized) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }

    final authState = ref.watch(authViewModelProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: authState.user != null ? HomeScreen() : LoginScreen(),
    );
  }
}
