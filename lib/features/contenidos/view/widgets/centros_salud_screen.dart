import 'package:flutter/material.dart';
import 'package:lactaamor/features/home/data/centros_mock_data.dart';
import 'package:lactaamor/features/home/models/centro_salud_model.dart';
import 'package:lactaamor/features/home/presentation/screens/centro_detalle_screen.dart';

class CentrosSaludScreen extends StatefulWidget {
  const CentrosSaludScreen({super.key});

  @override
  State<CentrosSaludScreen> createState() => _CentrosSaludScreenState();
}

class _CentrosSaludScreenState extends State<CentrosSaludScreen> {

  String filtroDistrito = "";
  String filtroTipo = "";
  String filtroServicio = "";

  List<CentroSalud> centros = listaCentros; // tu data mock o Firebase

  @override
  Widget build(BuildContext context) {

    final filtrados = centros.where((centro) {

      final coincideDistrito = filtroDistrito.isEmpty ||
          centro.distrito.toLowerCase().contains(filtroDistrito.toLowerCase());

      final coincideTipo = filtroTipo.isEmpty ||
          centro.tipo == filtroTipo;

      final coincideServicio = filtroServicio.isEmpty ||
          centro.servicios.contains(filtroServicio);

      return coincideDistrito &&
             coincideTipo &&
             coincideServicio;

    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Centros de Salud")),
      body: Column(
        children: [

          // Buscador Distrito
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: const InputDecoration(
                labelText: "Buscar por distrito",
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() => filtroDistrito = value);
              },
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: filtrados.length,
              itemBuilder: (context, index) {

                final centro = filtrados[index];

                return ListTile(
                  title: Text(centro.nombre),
                  subtitle: Text("${centro.tipo} • ${centro.distrito}"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CentroDetalleScreen(
                          centro: centro,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}