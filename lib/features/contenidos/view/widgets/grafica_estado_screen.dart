import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GraficaEstadoScreen extends StatefulWidget {
  const GraficaEstadoScreen({super.key});

  @override
  State<GraficaEstadoScreen> createState() =>
      _GraficaEstadoScreenState();
}

class _GraficaEstadoScreenState
    extends State<GraficaEstadoScreen> {
  final uid = FirebaseAuth.instance.currentUser!.uid;

  List<FlSpot> spots = [];

  @override
  void initState() {
    super.initState();
    cargarDatos();
  }

  Future<void> cargarDatos() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('registros_diarios')
        .orderBy('fecha')
        .get();

    List<FlSpot> nuevosSpots = [];

    for (int i = 0; i < snapshot.docs.length; i++) {
      final data = snapshot.docs[i].data();
      int estado = data['estado_animo'] ?? 1;

      nuevosSpots.add(
        FlSpot(i.toDouble(), estado.toDouble()),
      );
    }

    setState(() {
      spots = nuevosSpots;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (spots.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text("Estado Emocional")),
        body: const Center(child: Text("No hay registros aún")),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Estado Emocional")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: LineChart(
          LineChartData(
            minY: 1,
            maxY: 5,
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                barWidth: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}