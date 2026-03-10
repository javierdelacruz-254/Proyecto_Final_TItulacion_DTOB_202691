import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SeguimientoEmbarazoScreen extends StatefulWidget {
  const SeguimientoEmbarazoScreen({super.key});

  @override
  State<SeguimientoEmbarazoScreen> createState() =>
      _SeguimientoEmbarazoScreenState();
}

class _SeguimientoEmbarazoScreenState extends State<SeguimientoEmbarazoScreen> {
  DateTime selectedDate = DateTime.now();
  bool vitaminasTomadas = false;
  int estadoAnimo = 3; 

  final TextEditingController pesoController = TextEditingController();

  List<String> sintomasSeleccionados = [];

  final List<String> sintomas = [
    "Náuseas",
    "Dolor de espalda",
    "Fatiga",
    "Acidez",
    "Hinchazón",
    "Calambres",
  ];

  String obtenerEmoji(int valor) {
    switch (valor) {
      case 5:
        return "😄";
      case 4:
        return "🙂";
      case 3:
        return "😐";
      case 2:
        return "😟";
      case 1:
        return "😢";
      default:
        return "😐";
    }
  }


  Future<void> guardarRegistro() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Usuario no autenticado")),
      );
      return;
    }

    final fechaHoy = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
    );

    await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .collection("registros_diarios")
        .doc("${fechaHoy.year}-${fechaHoy.month}-${fechaHoy.day}")
        .set({
      "fecha": Timestamp.fromDate(fechaHoy),
      "estado_animo": estadoAnimo, // 🔥 Se guarda como INT
      "sintomas": sintomasSeleccionados,
      "vitaminas": vitaminasTomadas,
      "peso": pesoController.text.trim(),
      "updated_at": Timestamp.now(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Registro guardado correctamente 💙")),
    );
  }

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
                  fontWeight: FontWeight.bold,
                ),
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
                  _emojiButton(5),
                  _emojiButton(4),
                  _emojiButton(3),
                  _emojiButton(2),
                  _emojiButton(1),
                ],
              ),
            ),

            //Síntomas
            _buildSection(
              icon: Icons.medical_services,
              title: "Síntomas",
              child: Wrap(
                spacing: 8,
                children: sintomas.map((sintoma) {
                  final isSelected =
                      sintomasSeleccionados.contains(sintoma);

                  return FilterChip(
                    label: Text(sintoma),
                    selected: isSelected,
                    onSelected: (value) {
                      setState(() {
                        if (value) {
                          sintomasSeleccionados.add(sintoma);
                        } else {
                          sintomasSeleccionados.remove(sintoma);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
            ),

            /// Vitaminas
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

            /// Peso
            _buildSection(
              icon: Icons.monitor_weight,
              title: "Peso actual",
              child: TextField(
                controller: pesoController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Ejemplo: 65 kg",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 16, horizontal: 16),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// GUARDAR
            ElevatedButton(
              onPressed: guardarRegistro,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                padding: const EdgeInsets.symmetric(
                    horizontal: 40, vertical: 15),
              ),
              child: const Text("Guardar Registro"),
            ),

            const SizedBox(height: 40),
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
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.pink),
              const SizedBox(width: 8),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _emojiButton(int valor) {

    final isSelected = estadoAnimo == valor;

    return GestureDetector(
      onTap: () {
        setState(() {
          estadoAnimo = valor;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.pink.shade100 : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          obtenerEmoji(valor),
          style: const TextStyle(fontSize: 28),
        ),
      ),
    );
}
}