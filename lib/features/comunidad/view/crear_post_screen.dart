import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/features/comunidad/viewmodel/post_viewmodel.dart';

class CrearPostScreen extends ConsumerStatefulWidget {
  final dynamic user;

  const CrearPostScreen({super.key, required this.user});

  @override
  ConsumerState<CrearPostScreen> createState() => _CrearPostScreenState();
}

class _CrearPostScreenState extends ConsumerState<CrearPostScreen> {
  final TextEditingController contenidoController = TextEditingController();
  final TextEditingController tagsController = TextEditingController();

  bool loading = false;

  void publicarPost() async {
    final contenido = contenidoController.text.trim();
    final tagsTexto = tagsController.text.trim();

    if (contenido.isEmpty) return;

    setState(() {
      loading = true;
    });

    final List<String> tags = tagsTexto.isEmpty
        ? []
        : tagsTexto.split(",").map((e) => e.trim()).toList();

    await ref
        .read(postViewModelProvider.notifier)
        .crearPost(
          widget.user.uid,
          widget.user.fullname ?? "",
          contenido,
          tags,
        );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Crear publicación")),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: contenidoController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: "Comparte tu experiencia con otras madres...",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: tagsController,
              decoration: const InputDecoration(
                hintText: "Tags (ej: lactancia,sueño,bebé)",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: loading ? null : publicarPost,
                child: loading
                    ? const CircularProgressIndicator()
                    : const Text("Publicar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
