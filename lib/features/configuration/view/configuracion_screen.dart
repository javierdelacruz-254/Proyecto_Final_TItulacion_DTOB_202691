import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/core/theme/them_provider.dart';

class ConfiguracionScreen extends ConsumerWidget {
  const ConfiguracionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    String getLabel(ThemeMode mode) {
      switch (mode) {
        case ThemeMode.light:
          return "Claro";
        case ThemeMode.dark:
          return "Oscuro";
        case ThemeMode.system:
          return "Automático (según el dispositivo)";
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Configuración")),
      body: ListView(
        children: [
          /// APARIENCIA
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              "Apariencia",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text("Modo oscuro"),
            subtitle: Text(getLabel(themeMode)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (_) {
                  return SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.brightness_auto),
                          title: const Text("Automático"),
                          onTap: () {
                            ref.read(themeProvider.notifier).setSystem();
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.light_mode),
                          title: const Text("Modo claro"),
                          onTap: () {
                            ref.read(themeProvider.notifier).setLight();
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.dark_mode),
                          title: const Text("Modo oscuro"),
                          onTap: () {
                            ref.read(themeProvider.notifier).setDark();
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.palette),
            title: const Text("Apariencia"),
            subtitle: const Text("Colores y estilo visual"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          const Divider(),

          /// NOTIFICACIONES
          SwitchListTile(
            secondary: const Icon(Icons.notifications),
            title: const Text("Notificaciones"),
            subtitle: const Text("Recibir recordatorios y avisos"),
            value: true,
            onChanged: (value) {},
          ),

          const Divider(),

          /// LENGUAJE
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text("Lenguaje"),
            subtitle: const Text("Español"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          const Divider(),

          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              "Seguridad",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          /// PRIVACIDAD
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text("Privacidad y seguridad"),
            subtitle: const Text("Permisos y protección de datos"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          const Divider(),

          /// AYUDA
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text("Ayuda", style: TextStyle(fontWeight: FontWeight.bold)),
          ),

          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text("Preguntas frecuentes (FAQ)"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          const Divider(),

          /// SOBRE LA APP
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text("Sobre la app"),
            subtitle: const Text("Información de la aplicación"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
