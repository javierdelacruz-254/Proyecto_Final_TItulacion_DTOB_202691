import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/features/auth/viewmodel/auth_viewmodel.dart';

class CuentaScreen extends ConsumerWidget {
  const CuentaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authViewModelProvider);
    final user = state.user;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Sesión iniciada correctamente 🎉",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text("Nombres Completos: ${user?.fullname ?? ''}"),
              //Text("DNI: ${user?.dni ?? ''}"),
              //Text("Edad: ${user?.edad ?? ''}"),
              Text("Correo: ${user?.email ?? ''}"),
            ],
          ),
        ),
      ),
    );
  }
}
