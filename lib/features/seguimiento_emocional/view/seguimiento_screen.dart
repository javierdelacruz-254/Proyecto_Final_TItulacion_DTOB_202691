import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'registro_embarazo_screen.dart';
import 'registro_postparto_screen.dart';

class BienestarScreen extends StatelessWidget {
  const BienestarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == null) {
      return const Scaffold(
        body: Center(child: Text('Usuario no autenticado')),
      );
    }

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: Colors.pink),
            ),
          );
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Scaffold(
            body: Center(child: Text('Perfil no encontrado')),
          );
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;

        final perfilMaterno =
            data['perfilMaterno'] as Map<String, dynamic>? ?? {};
        final haDadoLuz = perfilMaterno['ha_dado_luz'] as bool? ?? false;

        final tieneBebeData = data.containsKey('datosBebe') &&
            data['datosBebe'] != null;

        final esPostparto = haDadoLuz && tieneBebeData;

        final nombreMadre =
            (data['fullname'] as String? ?? '').split(' ').first;

        if (esPostparto) {
          return RegistroPostpartoScreen(
            nombreMadre: nombreMadre,
            datosBebe: data['datosBebe'] as Map<String, dynamic>,
          );
        } else {
          return RegistroEmbarazoScreen(
            nombreMadre: nombreMadre,
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