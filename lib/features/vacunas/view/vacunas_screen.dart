import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/core/constants/vacunas_data.dart';
import 'package:lactaamor/features/home/viewmodel/home_viewmodel.dart';
import 'package:lactaamor/features/vacunas/viewmodel/vacunas_viewmodel.dart';

class VacunasScreen extends ConsumerWidget {
  const VacunasScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vacunasAplicadas = ref.watch(vacunasViewModelProvider);
    final vacunasVM = ref.read(vacunasViewModelProvider.notifier);

    int calcularEdadMeses(DateTime nacimiento) {
      final hoy = DateTime.now();

      int meses =
          (hoy.year - nacimiento.year) * 12 + (hoy.month - nacimiento.month);

      if (hoy.day < nacimiento.day) {
        meses--;
      }

      return meses;
    }

    final List vacunas = vacunasData["vacunas_bebe"];

    final state = ref.watch(homeViewModelProvider);

    final user = state.profile;

    final edadMeses = calcularEdadMeses(
      user?.fechaNacimientoBebe ?? DateTime.now(),
    );

    String estadoVacuna(int edadBebe, int edadVacuna, bool aplicada) {
      if (aplicada) return "aplicada";

      if (edadBebe >= edadVacuna) {
        return "atrasada";
      }

      return "proxima";
    }

    final uid = user?.uid;

    if (uid != null) {
      Future.microtask(() {
        ref.read(vacunasViewModelProvider.notifier).cargarVacunas(uid);
      });
    }

    Color colorEstado(String estado) {
      switch (estado) {
        case "aplicada":
          return Colors.green;
        case "atrasada":
          return Colors.red;
        default:
          return Colors.orange;
      }
    }

    DateTime fechaVacuna(DateTime nacimiento, int edadMeses) {
      return DateTime(
        nacimiento.year,
        nacimiento.month + edadMeses,
        nacimiento.day,
      );
    }

    String formatearFecha(DateTime fecha) {
      return "${fecha.day}/${fecha.month}/${fecha.year}";
    }

    Future<DateTime?> seleccionarFecha(BuildContext context) async {
      final hoy = DateTime.now();

      return await showDatePicker(
        context: context,
        initialDate: hoy,
        firstDate: DateTime(2020),
        lastDate: hoy,
        helpText: "Fecha de vacunación",
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Calendario de Vacunas")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: vacunas.length,
        itemBuilder: (context, index) {
          final grupo = vacunas[index];
          final List vacunasGrupo = grupo["vacunas"];

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Timeline
              Column(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: const BoxDecoration(
                      color: Colors.pink,
                      shape: BoxShape.circle,
                    ),
                  ),
                  if (index != vacunas.length - 1)
                    Container(
                      width: 2,
                      height: 120,
                      color: Colors.grey.shade300,
                    ),
                ],
              ),

              const SizedBox(width: 12),

              /// Contenido
              Expanded(
                child: Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Edad
                        Text(
                          grupo["edad"].toString().replaceAll("_", " "),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(height: 8),

                        /// Vacunas
                        ...vacunasGrupo.map((vacuna) {
                          final vacunaId = vacuna["id"];

                          final aplicada = vacunasAplicadas.containsKey(
                            vacunaId,
                          );

                          final estado = estadoVacuna(
                            edadMeses,
                            grupo["edad_meses"],
                            aplicada,
                          );

                          DateTime? fechaAplicacion;
                          DateTime? fechaProgramada;

                          if (aplicada) {
                            final data = vacunasAplicadas[vacunaId];
                            fechaAplicacion =
                                (data["fechaAplicacion"] as Timestamp).toDate();
                          } else if (estado == "proxima") {
                            fechaProgramada = fechaVacuna(
                              user?.fechaNacimientoBebe ?? DateTime.now(),
                              grupo["edad_meses"],
                            );
                          }

                          final bool habilitado =
                              estado == "atrasada" && !aplicada;

                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(
                              Icons.vaccines,
                              color: colorEstado(estado),
                            ),
                            title: Text(vacuna["nombre"]),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Dosis ${vacuna["dosis"]}"),

                                if (estado == "aplicada" &&
                                    fechaAplicacion != null)
                                  Text(
                                    "Aplicada: ${formatearFecha(fechaAplicacion)}",
                                    style: const TextStyle(color: Colors.green),
                                  ),

                                if (estado == "proxima" &&
                                    fechaProgramada != null)
                                  Text(
                                    "Próxima: ${formatearFecha(fechaProgramada)}",
                                    style: const TextStyle(
                                      color: Colors.orange,
                                    ),
                                  ),

                                if (estado == "atrasada")
                                  const Text(
                                    "Vacuna pendiente",
                                    style: TextStyle(color: Colors.red),
                                  ),
                              ],
                            ),
                            trailing: Checkbox(
                              value: aplicada,
                              activeColor: colorEstado(estado),
                              onChanged: habilitado
                                  ? (value) async {
                                      if (value == true &&
                                          uid != null &&
                                          !aplicada) {
                                        final fecha = await seleccionarFecha(
                                          context,
                                        );

                                        if (fecha != null) {
                                          await vacunasVM.registrarVacuna(
                                            uid,
                                            vacunaId,
                                            fecha,
                                          );
                                        }
                                      }
                                    }
                                  : null,
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
