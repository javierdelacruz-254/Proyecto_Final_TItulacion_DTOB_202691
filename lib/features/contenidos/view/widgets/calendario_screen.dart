import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CalendarioScreen extends StatefulWidget {
  const CalendarioScreen({super.key});

  @override
  State<CalendarioScreen> createState() => _CalendarioScreenState();
}

class _CalendarioScreenState extends State<CalendarioScreen> {
  final uid = FirebaseAuth.instance.currentUser!.uid;

  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  Map<DateTime, Map<String, dynamic>> registros = {};

  @override
  void initState() {
    super.initState();
    cargarRegistros();
  }

  Future<void> cargarRegistros() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('registros_diarios')
        .get();

    Map<DateTime, Map<String, dynamic>> datos = {};

    for (var doc in snapshot.docs) {
      final data = doc.data();
      Timestamp timestamp = data['fecha'];

      DateTime fecha = timestamp.toDate();
      DateTime fechaSolo = DateTime(fecha.year, fecha.month, fecha.day);

      datos[fechaSolo] = data;
    }

    setState(() {
      registros = datos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Calendario")),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: focusedDay,
            firstDay: DateTime(2020),
            lastDay: DateTime(2030),
            selectedDayPredicate: (day) =>
                isSameDay(selectedDay, day),
            onDaySelected: (selected, focused) {
              setState(() {
                selectedDay = selected;
                focusedDay = focused;
              });
            },
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, day, events) {
                DateTime fechaSolo =
                    DateTime(day.year, day.month, day.day);

                if (registros.containsKey(fechaSolo)) {
                  return const Positioned(
                    bottom: 5,
                    child: Icon(
                      Icons.circle,
                      size: 8,
                      color: Colors.pink,
                    ),
                  );
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 20),
          if (selectedDay != null)
            _buildDetalleDia(selectedDay!)
        ],
      ),
    );
  }

  Widget _buildDetalleDia(DateTime dia) {
    DateTime fechaSolo =
        DateTime(dia.year, dia.month, dia.day);

    if (!registros.containsKey(fechaSolo)) {
      return const Text("No hay registro este día");
    }

    final data = registros[fechaSolo]!;

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Estado ánimo: ${data['estado_animo']}"),
            Text("Peso: ${data['peso']} kg"),
            Text("Vitaminas: ${data['vitaminas'] ? "Sí" : "No"}"),
          ],
        ),
      ),
    );
  }
}