import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lactaamor/features/home/models/centro_salud_model.dart';
import 'package:url_launcher/url_launcher.dart';

class CentroDetalleScreen extends StatelessWidget {
  final CentroSalud centro;

  const CentroDetalleScreen({super.key, required this.centro});

  @override
  Widget build(BuildContext context) {
    final LatLng posicion = LatLng(centro.lat, centro.lng);

    return Scaffold(
      appBar: AppBar(title: Text(centro.nombre)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    centro.tipo,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),
                  Text("📍 ${centro.direccion}"),
                  Text("🏙 ${centro.distrito}"),

                  const SizedBox(height: 16),

                  Text(
                    "Servicios:",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  Wrap(
                    spacing: 8,
                    children: centro.servicios
                        .map((s) => Chip(label: Text(s)))
                        .toList(),
                  ),

                  const SizedBox(height: 20),

                  // BOTONES
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.directions),
                          label: const Text("Cómo llegar"),
                          onPressed: () async {
                            final url =
                                "https://www.google.com/maps/dir/?api=1&destination=${centro.lat},${centro.lng}";
                            await launchUrl(Uri.parse(url));
                          },
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.message),
                          label: const Text("WhatsApp"),
                          onPressed: () async {
                            final url = "https://wa.me/${centro.telefono}";
                            await launchUrl(Uri.parse(url));
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Ubicación",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 300,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: posicion,
                  zoom: 15,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId("centro"),
                    position: posicion,
                  ),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
