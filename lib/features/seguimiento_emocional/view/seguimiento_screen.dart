import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lactaamor/features/seguimiento_emocional/view/historial_seguimiento_screen.dart';
import 'registro_embarazo_screen.dart';
import 'registro_postparto_screen.dart';

class BienestarScreen extends StatefulWidget {
  const BienestarScreen({super.key});

  static void mostrarHistorial(BuildContext context) {
    context.findAncestorStateOfType<_BienestarScreenState>()?._verHistorial();
  }

  static void mostrarFormulario(BuildContext context) {
    context.findAncestorStateOfType<_BienestarScreenState>()?._verFormulario();
  }

  @override
  State<BienestarScreen> createState() => _BienestarScreenState();
}

class _BienestarScreenState extends State<BienestarScreen> {
  bool _mostrarHistorial = false;

  void _verHistorial() => setState(() => _mostrarHistorial = true);
  void _verFormulario() => setState(() => _mostrarHistorial = false);

  @override
  Widget build(BuildContext context) {
    if (_mostrarHistorial) {
      return HistorialScreen(onVolver: _verFormulario);
    }

    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      return const Center(child: Text('Usuario no autenticado'));
    }

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
        final nombre = (data['fullname'] as String? ?? 'mamá').split(' ').first;

        if (esPostparto) {
          return RegistroPostpartoScreen(
            nombreMadre: nombre,
            datosBebe: data['datosBebe'] as Map<String, dynamic>,
            onGuardado: _verHistorial,
          );
        } else {
          return RegistroEmbarazoScreen(
            nombreMadre: nombre,
            embarazoActual:
                data['embarazoActual'] as Map<String, dynamic>? ?? {},
            perfilMedico: data['perfilMedico'] as Map<String, dynamic>? ?? {},
            onGuardado: _verHistorial,
          );
        }
      },
    );
  }
}
