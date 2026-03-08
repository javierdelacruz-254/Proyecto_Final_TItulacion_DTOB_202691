import 'package:flutter/material.dart';
import 'package:lactaamor/features/home/models/especialista_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DetalleEspecialistaScreen extends StatelessWidget {
  final Especialista especialista;

  const DetalleEspecialistaScreen({super.key, required this.especialista});

  Future<void> _abrirWhatsApp(String telefono) async {
    final numero = telefono.replaceAll(RegExp(r'\D'), '');
    final url = Uri.parse("https://wa.me/$numero");

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'No se pudo abrir WhatsApp';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(especialista.nombre)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(especialista.foto),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              especialista.especializacion,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(especialista.descripcion),
            const SizedBox(height: 20),
            Text("📞 ${especialista.telefono}"),
            Text("📧 ${especialista.email}"),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () {
                _abrirWhatsApp(especialista.telefono);
              },
              icon: const Icon(Icons.chat),
              label: const Text("Contactar por WhatsApp"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
