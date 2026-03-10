import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/features/auth/view/login_screen.dart';
import 'package:lactaamor/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:lactaamor/features/contenidos/view/widgets/centros_salud_screen.dart';
import 'package:lactaamor/features/home/view/today.dart';
import 'package:lactaamor/features/perfil/view/account.dart';
import 'package:lactaamor/features/chatbot/view/chatbot_screen.dart';
import 'package:lactaamor/features/contenidos/view/contenido_screen.dart';
import 'package:lactaamor/features/seguimiento_emocional/view/seguimiento_screen.dart';
import 'package:lactaamor/features/seguimiento_emocional/view/historial_seguimiento_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HoyScreen(),
    const BienestarScreen(),
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
              ref.read(authViewModelProvider.notifier).logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFFE91E63)),
              accountName: const Text("Usuario"),
              accountEmail: const Text("usuario@email.com"),
              currentAccountPicture: const CircleAvatar(
                child: Icon(Icons.person, size: 40),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Inicio"),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _currentIndex = 0;
                });
              },
            ),

            ListTile(
              leading: const Icon(Icons.calendar_month),
              title: const Text("Especialistas"),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _currentIndex = 1;
                });
              },
            ),

            ListTile(
              leading: const Icon(Icons.wechat),
              title: const Text("Centros de Salud"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CentrosSaludScreen()),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.book),
              title: const Text("Reportes"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HistorialScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Configuración"),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text("Cuenta"),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _currentIndex = 4;
                });
              },
            ),

            const Divider(),

            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Cerrar sesión"),
              onTap: () {
                ref.read(authViewModelProvider.notifier).logout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: IndexedStack(index: _currentIndex, children: _pages),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.home), label: "Hoy"),
          BottomNavigationBarItem(
            icon: const Icon(Icons.calendar_month),
            label: "Seguimiento",
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
