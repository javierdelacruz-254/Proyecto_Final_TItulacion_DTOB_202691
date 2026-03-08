import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lactaamor/features/seguimiento_emocional/view/historial_seguimiento_screen.dart';
import 'registro_embarazo_screen.dart';
import 'registro_postparto_screen.dart';

class BienestarScreen extends StatelessWidget {
  const BienestarScreen({super.key});

  // Clave global para poder navegar al historial desde los formularios hijos
  static final navigatorKey = GlobalKey<NavigatorState>();

  /// Navega al historial desde cualquier widget hijo
  static void irAlHistorial() {
    navigatorKey.currentState
        ?.pushNamedAndRemoveUntil('/historial', (r) => r.isFirst);
  }

  /// Regresa al formulario desde el historial
  static void irAlFormulario() {
    navigatorKey.currentState?.popUntil((r) => r.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == null) {
      return const Center(child: Text('Usuario no autenticado'));
    }

    return Navigator(
      key: navigatorKey,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/historial':
            return MaterialPageRoute(
              builder: (_) => const HistorialScreen(),
              settings: settings,
            );
          case '/':
          default:
            return MaterialPageRoute(
              builder: (_) => _FormularioSegunPerfil(uid: uid),
              settings: settings,
            );
        }
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  _FormularioSegunPerfil
//  Lee el perfil en tiempo real y decide qué formulario mostrar.
// ─────────────────────────────────────────────────────────────────────────────
class _FormularioSegunPerfil extends StatelessWidget {
  final String uid;
  const _FormularioSegunPerfil({required this.uid});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.pink),
          );
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Center(child: Text('Perfil no encontrado'));
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;

        final perfilMaterno =
            data['perfilMaterno'] as Map<String, dynamic>? ?? {};
        final haDadoLuz = perfilMaterno['ha_dado_luz'] as bool? ?? false;
        final tieneBebeData =
            data.containsKey('datosBebe') && data['datosBebe'] != null;

        final esPostparto = haDadoLuz && tieneBebeData;
        final nombre =
            (data['fullname'] as String? ?? 'mamá').split(' ').first;

        if (esPostparto) {
          return RegistroPostpartoScreen(
            nombreMadre: nombre,
            datosBebe: data['datosBebe'] as Map<String, dynamic>,
          );
        } else {
          return RegistroEmbarazoScreen(
            nombreMadre: nombre,
            embarazoActual:
                data['embarazoActual'] as Map<String, dynamic>? ?? {},
            perfilMedico:
                data['perfilMedico'] as Map<String, dynamic>? ?? {},
          );
        }
      },
    );
  }
}