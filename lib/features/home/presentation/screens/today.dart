import 'package:flutter/material.dart';

class HoyScreen extends StatelessWidget {
    HoyScreen({Key? key}) : super(key: key);

  // DATOS
  final bool dioALuz = false; // Cambia a true para simular bebé nacido

  final DateTime fechaUltimaMenstruacion =
      DateTime(2025, 10, 1);

  final DateTime fechaNacimientoBebe =
      DateTime(2026, 1, 5);

  int _calcularSemanas(DateTime fecha) {
    return DateTime.now().difference(fecha).inDays ~/ 7;
  }

  @override
  Widget build(BuildContext context) {
    final semanas = dioALuz
        ? _calcularSemanas(fechaNacimientoBebe)
        : _calcularSemanas(fechaUltimaMenstruacion);

    final titulo = dioALuz
        ? "Tu bebé tiene $semanas semanas 👶"
        : "Tienes $semanas semanas de embarazo 🤰";

    final descripcion = dioALuz
        ? "En esta etapa tu bebé empieza a reconocer tu voz y mejora el control de su cabeza."
        : "Tu bebé mide aproximadamente 14 cm y ya puede mover brazos y piernas con mayor coordinación.";

    final imagen = dioALuz
        ? "https://images.unsplash.com/photo-1519681393784-d120267933ba?w=800"
        : "https://images.unsplash.com/photo-1505751172876-fa1923c5c528?w=800";

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              const SizedBox(height: 20),

              // 👤 Nombre ejemplo
              const Text(
                "Hola, María 🌸",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30),

              // 🟢 TARJETA PRINCIPAL
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.pink.shade50,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 10,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      titulo,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 20),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        imagen,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      descripcion,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 20),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Ver detalles de la semana",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // 📚 Sección secundaria
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Recomendado para ti",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // 🟡 Tarjetas pequeñas
              _infoCard("Alimentación saludable 🍎"),
              _infoCard("Ejercicios recomendados 🧘‍♀️"),
              _infoCard("Controles médicos 🏥"),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _infoCard(String texto) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
          )
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.arrow_forward_ios, size: 16),
          const SizedBox(width: 10),
          Text(
            texto,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
