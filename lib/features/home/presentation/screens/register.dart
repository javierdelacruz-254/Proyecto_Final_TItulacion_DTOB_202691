import 'package:flutter/material.dart';

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  State<RegistroScreen> createState() =>
      _RegistroEmbarazoScreenState();
}

class _RegistroEmbarazoScreenState
    extends State<RegistroScreen> {
  DateTime selectedDate = DateTime.now();
  bool vitaminasTomadas = false;
  String estadoAnimo = "🙂";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text("Registro Embarazo"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            // Fecha actual
            Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),

            const Divider(),

            // Cómo te sientes
            _buildSection(
              icon: Icons.favorite,
              title: "¿Cómo te sientes hoy?",
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _emojiButton("😄"),
                  _emojiButton("🙂"),
                  _emojiButton("😐"),
                  _emojiButton("😢"),
                ],
              ),
            ),

            // Síntomas
            _buildSection(
              icon: Icons.medical_services,
              title: "Síntomas",
              child: Wrap(
                spacing: 10,
                children: const [
                  Chip(label: Text("Náuseas")),
                  Chip(label: Text("Dolor de espalda")),
                  Chip(label: Text("Fatiga")),
                  Chip(label: Text("Acidez")),
                ],
              ),
            ),

            // Movimientos del bebé
            _buildSection(
              icon: Icons.child_care,
              title: "Movimientos del bebé",
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Registrar movimiento"),
              ),
            ),

            // Vitaminas
            _buildSection(
              icon: Icons.medication,
              title: "Vitaminas prenatales",
              child: Switch(
                value: vitaminasTomadas,
                onChanged: (value) {
                  setState(() {
                    vitaminasTomadas = value;
                  });
                },
              ),
            ),

            // Peso
            _buildSection(
              icon: Icons.monitor_weight,
              title: "Peso actual",
              child: const TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Ejemplo: 65 kg",
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required IconData icon,
    required String title,
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.pink),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _emojiButton(String emoji) {
    return GestureDetector(
      onTap: () {
        setState(() {
          estadoAnimo = emoji;
        });
      },
      child: Text(
        emoji,
        style: const TextStyle(fontSize: 28),
      ),
    );
  }
}
