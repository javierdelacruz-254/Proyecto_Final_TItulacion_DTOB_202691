import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lactaamor/features/home/models/especialista_model.dart';
import 'package:lactaamor/features/home/presentation/screens/detalle_especialista_screen.dart';

class EspecialistasScreen extends StatefulWidget {
  const EspecialistasScreen({super.key});

  @override
  State<EspecialistasScreen> createState() =>
      _EspecialistasScreenState();
}

class _EspecialistasScreenState
    extends State<EspecialistasScreen> {

  String searchText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Especialistas"),
      ),
      body: Column(
        children: [

          // BUSCADOR
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Buscar por especialización...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value.toLowerCase();
                });
              },
            ),
          ),

          // LISTA DESDE FIREBASE
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('especialistas')
                  .snapshots(),
              builder: (context, snapshot) {

                if (!snapshot.hasData) {
                  return const Center(
                      child: CircularProgressIndicator());
                }

                final docs = snapshot.data!.docs;

                final especialistas = docs
                    .map((doc) => Especialista.fromFirestore(
                        doc.id,
                        doc.data() as Map<String, dynamic>))
                    .where((esp) =>
                        esp.especializacion
                            .toLowerCase()
                            .contains(searchText))
                    .toList();

                return ListView.builder(
                  itemCount: especialistas.length,
                  itemBuilder: (context, index) {
                    final esp = especialistas[index];

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(esp.foto),
                      ),
                      title: Text(esp.nombre),
                      subtitle: Text(esp.especializacion),
                      trailing:
                          const Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                DetalleEspecialistaScreen(
                                    especialista: esp),
                          ),
                        );
                      },
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