import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/features/auth/presentation/providers/auth_provider.dart';

class HoyScreen extends ConsumerWidget {
  const HoyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final user = authState.user;

    if (user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final bool dioALuz = user.haDadoLuz;

    int semanas = 0;
    int totalSemanas = dioALuz ? 52 : 40;

    // CALCULO DE SEMANAS: Si no ha dado a luz usamos semanasEmbarazo, si ya dio a luz se calcula desde fechaNacimientoBebe
    if (!dioALuz) {
      // Si está embarazada usamos semanasEmbarazo
      semanas = user.semanasEmbarazo ?? 0;
    } else if (user.fechaNacimientoBebe != null) {
      // Si ya dio a luz calculamos desde fechaNacimientoBebe
      semanas = DateTime.now()
              .difference(user.fechaNacimientoBebe!)
              .inDays ~/
          7;
    }

    if (semanas < 0) semanas = 0;

    final titulo = dioALuz
        ? "Tu hijo tiene $semanas semanas 👶"
        : "Tienes $semanas semanas de embarazo 🤰";

    final descripcion = _descripcionPorSemana(semanas, dioALuz);
    final imagen = _imagenPorSemana(semanas, dioALuz);

    final progreso = (semanas / totalSemanas).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F4F6),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              const SizedBox(height: 20),

              // Nombre del usuario
              Text(
                "Hola, ${user.nombres} 🌸",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Column(
                  children: [

                    // TÍTULO DINÁMICO
                    Text(
                      titulo,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 16),

                    // BARRA DE PROGRESO
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dioALuz
                              ? "Desarrollo del bebé"
                              : "Progreso del embarazo",
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: progreso,
                          minHeight: 10,
                          borderRadius: BorderRadius.circular(20),
                          backgroundColor: Colors.grey.shade200,
                          valueColor: AlwaysStoppedAnimation(
                            dioALuz
                                ? Colors.blue.shade300
                                : Colors.pink.shade300,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    // IMAGEN DINÁMICA
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        imagen,
                        height: 220,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // DESCRIPCIÓN DINÁMICA
                    Text(
                      descripcion,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // DESCRIPCIÓN SEGÚN SEMANAS
  static String _descripcionPorSemana(int semanas, bool dioALuz) {
    if (!dioALuz) {
      if (semanas <= 12) {
        return "Primer trimestre: Es normal sentir náuseas y fatiga. El bebé está formando sus órganos principales.";
      } else if (semanas <= 27) {
        return "Segundo trimestre: El bebé ya puede escuchar tu voz y sus movimientos son más fuertes.";
      } else {
        return "Tercer trimestre: El bebé está ganando peso rápidamente y preparándose para nacer.";
      }
    } else {
      if (semanas <= 4) {
        return "Tu bebé se está adaptando al mundo exterior. El contacto piel con piel fortalece el vínculo.";
      } else if (semanas <= 12) {
        return "Tu bebé empieza a sonreír y reconocer tu voz. La lactancia fortalece su sistema inmune.";
      } else if (semanas <= 24) {
        return "Tu bebé está desarrollando fuerza y coordinación cada día.";
      } else {
        return "Tu bebé continúa creciendo y aprendiendo nuevas habilidades.";
      }
    }
  }

  // IMAGEN SEGÚN SEMANAS
  static String _imagenPorSemana(int semanas, bool dioALuz) {
    if (!dioALuz) {
      if (semanas <= 12) {
        return "https://res.cloudinary.com/dqqhqnbny/image/upload/v1771478394/bebe_12_lyo3vi.jpg";
      } else if (semanas <= 27) {
        return "https://res.cloudinary.com/dqqhqnbny/image/upload/v1771478394/bebe_24_mcq1nn.jpg";
      } else {
        return "https://res.cloudinary.com/dqqhqnbny/image/upload/v1771478394/bebe_36_zmrtzy.jpg";
      }
    } else {
      if (semanas <= 12) {
        return "https://res.cloudinary.com/dqqhqnbny/image/upload/v1771478826/nacido_12m_uvsrtb.jpg";
      } else {
        return "https://res.cloudinary.com/dqqhqnbny/image/upload/v1771478826/nacido_1y_pgvtjc.jpg";
      }
    }
  }
}
