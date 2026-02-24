import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/features/auth/presentation/providers/auth_provider.dart';
import 'package:lactaamor/features/auth/presentation/screens/login_screen.dart';
import 'package:lactaamor/features/home/presentation/screens/account.dart';
import 'package:lactaamor/features/home/presentation/screens/chatbot.dart';
import 'package:lactaamor/features/home/presentation/screens/content.dart';
import 'package:lactaamor/features/home/presentation/screens/register.dart';
import 'package:lactaamor/features/home/presentation/screens/today.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HoyScreen(),
    const RegistroScreen(),
    const ChatBotScreen(),
    const ContenidoScreen(),
    const CuentaScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("LactaAmor 💕"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authProvider.notifier).logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex, 
        children: _pages),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: "Hoy",
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.calendar_month),
            label: "Registro",
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.wechat),
            label: "ChatBot",
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.book),
            label: "Contenido",
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.account_circle),
            label: "Cuenta",
          ),
        ],
      ),
    );
  }
}
