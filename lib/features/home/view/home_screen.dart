import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/core/theme/app_colors.dart';
import 'package:lactaamor/core/theme/them_provider.dart';
import 'package:lactaamor/features/auth/view/login_screen.dart';
import 'package:lactaamor/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:lactaamor/features/comunidad/view/comunidad_screen.dart';
import 'package:lactaamor/features/contenidos/view/widgets/centros_salud_screen.dart';
import 'package:lactaamor/features/home/view/today.dart';
import 'package:lactaamor/features/home/viewmodel/home_viewmodel.dart';
import 'package:lactaamor/features/chatbot/view/chatbot_screen.dart';
import 'package:lactaamor/features/contenidos/view/contenido_screen.dart';
import 'package:lactaamor/features/perfil/view/account.dart';
import 'package:lactaamor/features/seguimiento_emocional/view/seguimiento_screen.dart';
import 'package:lactaamor/features/seguimiento_emocional/view/historial_seguimiento_screen.dart';
import 'package:lactaamor/features/splash/view/widgets/animated_wave_background.dart';
import 'package:lactaamor/features/vacunas/view/vacunas_screen.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';

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
    const ComunidadScreen(),
  ];

  Widget _drawerItem(
    BuildContext context, {
    required IconData icon,
    Color? iconColor,
    required String label,
    required VoidCallback onTap,
  }) {
    final color = iconColor ?? Theme.of(context).iconTheme.color;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        label,
        style: TextStyle(
          color: label == 'Cerrar sesión' ? Colors.red : textColor,
        ),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final state = ref.watch(homeViewModelProvider);
    final themeMode = ref.watch(themeProvider);
    //final notificationsEnabled = ref.watch(notificationsProvider);

    int currentThemeIndex;

    switch (themeMode) {
      case ThemeMode.system:
        currentThemeIndex = 0;
        break;
      case ThemeMode.light:
        currentThemeIndex = 1;
        break;
      case ThemeMode.dark:
        currentThemeIndex = 2;
        break;
    }

    bool notificacionesActivas = true;

    final user = state.profile;

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.transparent : Color(0xFFF8F4F6),
        elevation: 0,
        title: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user?.fullname ?? 'Sin nombre',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Text(
                    "Bienvenida a LactaAmor",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.primary,
              child: Icon(Icons.person, color: Colors.white, size: 20),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
          child: SizedBox(
            width: 300,
            child: Stack(
              children: [
                const AnimatedWaveBackground(),

                ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      height: 150,
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/img/logo_sin_nombre.png",
                            height: 50,
                            width: 50,
                          ),
                          const SizedBox(width: 12),

                          Text(
                            "LactaAmor",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),

                          const Spacer(),

                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    _drawerItem(
                      context,
                      icon: Icons.home,
                      label: "Inicio",
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const HomeScreen()),
                        );
                      },
                    ),

                    _drawerItem(
                      context,
                      icon: Icons.wechat,
                      label: "Centros de Salud",
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CentrosSaludScreen(),
                          ),
                        );
                      },
                    ),

                    _drawerItem(
                      context,
                      icon: Icons.medical_information,
                      label: "Calendario de vacunas",
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const VacunasScreen(),
                          ),
                        );
                      },
                    ),

                    _drawerItem(
                      context,
                      icon: Icons.book,
                      label: "Reportes",
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const HistorialScreen(),
                          ),
                        );
                      },
                    ),

                    const Divider(
                      height: 40,
                      color: Colors.transparent,
                      thickness: 0,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Modo oscuro",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    Center(
                      child: SizedBox(
                        width: 180,
                        child: AnimatedToggleSwitch<int>.rolling(
                          current: currentThemeIndex,
                          values: const [0, 1, 2],
                          indicatorIconScale: 1.2,
                          height: 45,
                          borderWidth: 2,

                          style: ToggleStyle(
                            borderColor: Theme.of(context).colorScheme.primary,
                            backgroundColor: Theme.of(context).cardColor,
                            indicatorColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                          ),

                          onChanged: (i) {
                            switch (i) {
                              case 0:
                                ref.read(themeProvider.notifier).setSystem();
                                break;
                              case 1:
                                ref.read(themeProvider.notifier).setLight();
                                break;
                              case 2:
                                ref.read(themeProvider.notifier).setDark();
                                break;
                            }
                          },

                          iconBuilder: (value, foreground) {
                            const icons = [
                              Icons.brightness_auto,
                              Icons.light_mode,
                              Icons.dark_mode,
                            ];

                            return Icon(
                              icons[value],
                              color: foreground ? Colors.white : Colors.grey,
                            );
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // NOTIFICACIONES
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Recibir notificaciones",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    Center(
                      child: SizedBox(
                        width: 180,
                        child: AnimatedToggleSwitch<bool>.rolling(
                          current: notificacionesActivas,
                          values: const [true, false],
                          indicatorIconScale: 1.2,
                          height: 45,
                          borderWidth: 2,

                          style: ToggleStyle(
                            borderColor: Theme.of(context).colorScheme.primary,
                            backgroundColor: Theme.of(context).cardColor,
                            indicatorColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                          ),

                          onChanged: (value) {
                            setState(() {
                              notificacionesActivas = value;
                            });
                          },

                          iconBuilder: (value, foreground) {
                            return Icon(
                              value
                                  ? Icons.notifications
                                  : Icons.notifications_off,
                              color: foreground ? Colors.white : Colors.grey,
                            );
                          },
                        ),
                      ),
                    ),

                    const Divider(
                      height: 40,
                      color: Colors.transparent,
                      thickness: 0,
                    ),

                    _drawerItem(
                      context,
                      icon: Icons.account_circle,
                      label: "Cuenta",
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CuentaScreen(),
                          ),
                        );
                      },
                    ),

                    _drawerItem(
                      context,
                      icon: Icons.logout,
                      iconColor: Colors.red,
                      label: "Cerrar sesión",
                      onTap: () {
                        ref.read(authViewModelProvider.notifier).logout();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => LoginScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: IndexedStack(index: _currentIndex, children: _pages),

      bottomNavigationBar: StylishBottomBar(
        backgroundColor: isDark ? Color(0xFF1C2B2E) : Colors.white,
        items: [
          BottomBarItem(
            icon: Icon(Icons.home),
            title: Text("Hoy", style: TextStyle(fontSize: 12)),
            selectedColor: AppColors.primary,
            selectedIcon: Icon(Icons.home, color: AppColors.primary),
          ),
          BottomBarItem(
            icon: Icon(Icons.track_changes),
            title: Text("Seguimiento", style: TextStyle(fontSize: 10)),
            selectedColor: AppColors.primary,
            selectedIcon: Icon(Icons.track_changes, color: AppColors.primary),
          ),
          BottomBarItem(
            icon: const SizedBox.shrink(),
            title: const SizedBox.shrink(),
          ),
          BottomBarItem(
            icon: Icon(Icons.article),
            title: Text("Contenido", style: TextStyle(fontSize: 12)),
            selectedColor: AppColors.primary,
            selectedIcon: Icon(Icons.article, color: AppColors.primary),
          ),
          BottomBarItem(
            icon: Icon(Icons.forum),
            title: Text("Comunidad", style: TextStyle(fontSize: 12)),
            selectedColor: AppColors.primary,
            selectedIcon: Icon(Icons.forum, color: AppColors.primary),
          ),
        ],
        fabLocation: StylishBarFabLocation.center,
        notchStyle: NotchStyle.circle,
        hasNotch: true,
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 2) return;
          if (_currentIndex != index) {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        option: AnimatedBarOptions(
          barAnimation: BarAnimation.fade,
          iconStyle: IconStyle.animated,
          padding: EdgeInsets.symmetric(vertical: 10),
        ),
      ),
      floatingActionButton: SizedBox(
        width: 50, // Tamaño del círculo
        height: 50,
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              _currentIndex = 2;
            });
          },
          shape: CircleBorder(),
          backgroundColor: isDark ? Color(0xFF1C2B2E) : Colors.white,
          child: Icon(
            Icons.auto_awesome_rounded,
            color: _currentIndex == 2 ? AppColors.primary : Colors.grey,
            size: 32,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
