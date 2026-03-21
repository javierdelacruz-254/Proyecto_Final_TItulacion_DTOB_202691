import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lactaamor/core/constants/contenido_data.dart';
import 'package:lactaamor/core/theme/app_colors.dart';
import 'package:lactaamor/features/contenidos/models/contenido_model.dart';
import 'package:lactaamor/features/contenidos/view/widgets/contenido_detalle_screen.dart';
import 'package:lactaamor/features/home/viewmodel/home_viewmodel.dart';
import 'package:lactaamor/features/vacunas/viewmodel/vacunas_viewmodel.dart';

class VacunasScreen extends ConsumerStatefulWidget {
  const VacunasScreen({super.key});

  @override
  ConsumerState<VacunasScreen> createState() => _VacunasScreenState();
}

class _VacunasScreenState extends ConsumerState<VacunasScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      final user = ref.read(homeViewModelProvider).profile;
      final uid = user?.uid;

      if (uid != null) {
        final vm = ref.read(vacunasViewModelProvider.notifier);

        await vm.obtenerVacunasInfo();
        await vm.cargarVacunas(uid);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final stateVacunas = ref.watch(vacunasViewModelProvider);
    final vacunasVM = ref.read(vacunasViewModelProvider.notifier);

    final vacunasAplicadas = stateVacunas.vacunasAplicadas;

    int calcularEdadMeses(DateTime nacimiento) {
      final hoy = DateTime.now();

      int meses =
          (hoy.year - nacimiento.year) * 12 + (hoy.month - nacimiento.month);

      if (hoy.day < nacimiento.day) {
        meses--;
      }

      return meses;
    }

    final state = ref.watch(homeViewModelProvider);

    final user = state.profile;

    final dioALuz = user?.haDadoLuz ?? false;

    final vacunas = dioALuz
        ? stateVacunas.vacunas?.vacunasBebe ?? []
        : stateVacunas.vacunas?.vacunasMadre ?? [];

    final edadMeses = dioALuz
        ? calcularEdadMeses(user?.fechaNacimientoBebe ?? DateTime.now())
        : calcularEdadMeses(user?.ultimaMenstruacion ?? DateTime.now());

    String estadoVacuna(int edadBebe, int edadVacuna, bool aplicada) {
      if (aplicada) return "aplicada";

      if (edadBebe >= edadVacuna) {
        return "atrasada";
      }

      return "proxima";
    }

    final uid = user?.uid;

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
      final formato = DateFormat("EEEE dd 'de' MMMM 'del' yyyy", "es_ES");

      return formato.format(fecha);
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

    final Map<String, ArticuloContenido> articulosMap = {};

    for (var tema in todosLosTemas) {
      for (var articulo in tema.articulos) {
        if (articulo.id.isNotEmpty) {
          articulosMap[articulo.id] = articulo;
        } else {
          debugPrint("⚠️ Artículo sin ID: ${articulo.titulo}");
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: Text('Calendario de vacunas'),

        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    dioALuz ? "Vacunas del bebé" : "Calendario de Vacunas",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(
                    right: 16,
                    left: 16,
                    top: 16,
                    bottom: 100,
                  ),
                  itemCount: vacunas.length,
                  itemBuilder: (context, index) {
                    final grupo = vacunas[index];
                    final vacunasGrupo = grupo.vacunas;

                    return Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  decoration: const BoxDecoration(
                                    color: AppColors.primary,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      /// Edad
                                      Text(
                                        dioALuz
                                            ? grupo.edad.replaceAll("_", " ")
                                            : "Trimestre ${grupo.trimestre}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),

                                      const SizedBox(height: 8),

                                      /// Vacunas
                                      ...vacunasGrupo.map((vacuna) {
                                        final vacunaId = vacuna.id;

                                        final aplicada = vacunasVM.estaAplicada(
                                          vacunaId,
                                        );

                                        final estado = estadoVacuna(
                                          edadMeses,
                                          dioALuz
                                              ? grupo.edadMeses ?? 0
                                              : grupo.trimestre ?? 0,
                                          aplicada,
                                        );

                                        DateTime? fechaAplicacion;
                                        DateTime? fechaProgramada;

                                        final fechaBase = dioALuz
                                            ? user?.fechaNacimientoBebe ??
                                                  DateTime.now()
                                            : user?.ultimaMenstruacion ??
                                                  DateTime.now();

                                        if (aplicada) {
                                          final data =
                                              vacunasAplicadas[vacunaId];
                                          fechaAplicacion =
                                              (data["fechaAplicacion"]
                                                      as Timestamp)
                                                  .toDate();
                                        } else if (estado == "proxima") {
                                          fechaProgramada = fechaVacuna(
                                            fechaBase,
                                            dioALuz
                                                ? grupo.edadMeses ?? 0
                                                : ((grupo.trimestre ?? 0) * 3),
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
                                          title: Text(vacuna.nombre),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Dosis ${vacuna.dosis}"),

                                              if (estado == "aplicada" &&
                                                  fechaAplicacion != null)
                                                Text(
                                                  "Aplicada: ${formatearFecha(fechaAplicacion)}",
                                                  style: const TextStyle(
                                                    color: Colors.green,
                                                  ),
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
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                  ),
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
                                                      final fecha =
                                                          await seleccionarFecha(
                                                            context,
                                                          );

                                                      if (fecha != null) {
                                                        AwesomeDialog(
                                                          context: context,
                                                          dialogType: DialogType
                                                              .question,
                                                          animType:
                                                              AnimType.scale,
                                                          title: 'Confirmar',
                                                          desc:
                                                              '¿Deseas registrar esta vacuna con la fecha seleccionada?',
                                                          btnCancelOnPress:
                                                              () {},
                                                          btnOkText:
                                                              "Sí, registrar",
                                                          btnOkOnPress: () async {
                                                            await vacunasVM
                                                                .registrarVacuna(
                                                                  uid,
                                                                  vacunaId,
                                                                  fecha,
                                                                );
                                                          },
                                                        ).show();
                                                      }
                                                    }
                                                  }
                                                : null,
                                          ),
                                          onTap: () {
                                            final articuloId =
                                                vacuna.articuloId;
                                            print(
                                              "Vacuna seleccionada: ${vacuna.nombre}",
                                            );
                                            print("ArticuloId: $articuloId");
                                            if (articulosMap.containsKey(
                                              articuloId,
                                            )) {
                                              final articulo =
                                                  articulosMap[articuloId]!;
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) =>
                                                      ContenidoDetalleScreen(
                                                        articulo: articulo,
                                                      ),
                                                ),
                                              );
                                            } else {
                                              // Opcional: mostrar un mensaje si no hay artículo
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    "Artículo no disponible",
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
