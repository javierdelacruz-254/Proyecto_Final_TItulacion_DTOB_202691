import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GraficaPesoScreen extends StatefulWidget {
  const GraficaPesoScreen({super.key});

  @override
  State<GraficaPesoScreen> createState() =>
      _GraficaPesoScreenState();
}

class _GraficaPesoScreenState
    extends State<GraficaPesoScreen> {
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

      String pesoString = data['peso'] ?? "0";
      double peso = double.tryParse(pesoString) ?? 0;

      nuevosSpots.add(
        FlSpot(i.toDouble(), peso),
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
        appBar: AppBar(title: const Text("Evolución de Peso")),
        body: const Center(child: Text("No hay registros aún")),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Evolución de Peso")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: LineChart(
          LineChartData(
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