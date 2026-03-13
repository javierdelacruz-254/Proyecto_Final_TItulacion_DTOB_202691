import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/core/constants/alertas_data.dart';
import 'package:lactaamor/core/constants/consejos_data.dart';
import 'package:lactaamor/core/constants/contenido_data.dart';
import 'package:lactaamor/core/constants/cuidados_bebe_data.dart';
import 'package:lactaamor/core/constants/recetas_data.dart';
import 'package:lactaamor/core/theme/app_colors.dart';
import 'package:lactaamor/features/contenidos/models/contenido_model.dart';
import 'package:lactaamor/features/home/models/registro_diario_model.dart';
import 'package:lactaamor/features/home/view/widgets/bebe_3d_viewer.dart';
import 'package:lactaamor/features/home/view/widgets/calendario_today.dart';
import 'package:lactaamor/features/home/view/widgets/consejo_card.dart';
import 'package:lactaamor/features/home/view/widgets/cuidados_card.dart';
import 'package:lactaamor/features/home/view/widgets/estadistica_bebe.dart';
import 'package:lactaamor/features/home/view/widgets/receta_card.dart';
import 'package:lactaamor/features/home/viewmodel/home_viewmodel.dart';
import 'package:lactaamor/features/home/viewmodel/registro_diario_viewmodel.dart';

class HoyScreen extends ConsumerStatefulWidget {
  const HoyScreen({super.key});

  @override
  ConsumerState<HoyScreen> createState() => _HoyScreenState();
}

class _HoyScreenState extends ConsumerState<HoyScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(homeViewModelProvider.notifier).loadUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final state = ref.watch(homeViewModelProvider);
    final registroDiario = ref.watch(registroDiarioViewModelProvider);

    final uid = state.profile?.uid;
    final hoyKey =
        "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";

    if (uid != null) {
      Future.microtask(() => registroDiario.cargarRegistroDelDia(uid, hoyKey));
    }

    final RegistroDiarioModel? registro =
        registroDiario.registroDiarioModel ??
        (registroDiario.todosRegistros.isNotEmpty
            ? registroDiario.todosRegistros.first
            : null);

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

    if (state.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final user = state.profile;

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("No se pudo cargar usuario")),
      );
    }

    final dioALuz = user.haDadoLuz;

    final semanas = dioALuz ? user.semanasPostParto : user.semanasEmbarazo;
    final dias = dioALuz ? user.diasPostParto : user.diasEmbarazo;

    //final totalSemanas = dioALuz ? 52 : 40;

    //final progreso = (semanas / totalSemanas).clamp(0.0, 1.0);

    final descripcion = _descripcionPorSemana(semanas, dioALuz);
    final imagen = _imagenPorSemana(semanas, dioALuz);

    final comparacion = _comparacionBebe(semanas, dioALuz);

    List<Map<String, dynamic>> alertasDetectadas = [];

    if (registro != null) {
      alertasDetectadas = detectarAlertas(registro, dioALuz);
    }

    return Scaffold(
      backgroundColor: isDark ? Color(0xFF0F1A1C) : const Color(0xFFF8F4F6),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CalendarioToday(),

              _cardBebeEstado(
                dioALuz: dioALuz,
                semanas: semanas,
                dias: dias,
                comparacion: comparacion,
                descripcion: descripcion,
                user: user,
                imagen: imagen,
              ),

              const SizedBox(height: 40),
              if (dioALuz)
                CuidadosHoyCard(
                  cuidados: obtenerCuidadosHoy(dias),
                  articulosMap: articulosMap,
                ),
              const SizedBox(height: 40),

              ConsejoCard(
                semanas: semanas,
                dioALuz: dioALuz,
                recomendaciones: recomendaciones,
                articulosMap: articulosMap,
                registroBasicoModel: registro,
              ),

              const SizedBox(height: 20),

              RecetaCard(
                user: user,
                articulosMap: articulosMap,
                todosRecetas: recetas
                    .map(
                      (r) => {
                        "id": r["id"],
                        "titulo": r["titulo"],
                        "descripcion": r["descripcion"],
                        "imagen": r["imagen"],
                        "seccion": r["seccion"], // madre o bebe
                        "condicion":
                            r["condicion"], // null o "lactanciaExclusiva"/"anemiaLactancia"
                        "articuloId":
                            r["articuloId"], // coincide con articulosMap
                      },
                    )
                    .toList(),
              ),
              const SizedBox(height: 20),

              /// TARJETA DESARROLLO
              _cardDesarrollo(descripcion),

              const SizedBox(height: 20),

              _cardAlertas(alertasDetectadas),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  /// TARJETA TAMAÑO DEL BEBÉ

  Widget _cardBebeEstado({
    required bool dioALuz,
    required int semanas,
    required int dias,
    required String comparacion,
    required String descripcion,
    required dynamic user,
    required String imagen,
  }) {
    Map<String, double> calcularCrecimiento(int semanas) {
      double peso = 0;
      double altura = 0;

      if (semanas <= 8) {
        peso = 1;
        altura = 1.6;
      } else if (semanas <= 12) {
        peso = 14;
        altura = 5.4;
      } else if (semanas <= 16) {
        peso = 100;
        altura = 11.6;
      } else if (semanas <= 20) {
        peso = 300;
        altura = 16.4;
      } else if (semanas <= 24) {
        peso = 600;
        altura = 30;
      } else if (semanas <= 30) {
        peso = 1300;
        altura = 39;
      } else if (semanas <= 36) {
        peso = 2600;
        altura = 47;
      } else {
        peso = 3200;
        altura = 50;
      }

      return {"peso": peso, "altura": altura};
    }

    final crecimiento = calcularCrecimiento(semanas);

    final peso = dioALuz ? user?.peso : crecimiento["peso"];
    final altura = dioALuz ? user.altura : crecimiento["altura"];

    final tabs = dioALuz
        ? const [Tab(text: "Bebé"), Tab(text: "Estadísticas")]
        : const [
            Tab(text: "Bebé"),
            Tab(text: "Comparación"),
            Tab(text: "Estadísticas"),
          ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultTabController(
            length: tabs.length,
            child: Column(
              children: [
                /// CONTENIDO
                SizedBox(
                  height: 325,
                  child: TabBarView(
                    children: dioALuz
                        ? [
                            _tabBebe(
                              semanas,
                              dias,
                              descripcion,
                              imagen,
                              dioALuz,
                            ),
                            TabEstadisticas(
                              peso: peso,
                              altura: altura,
                              semanas: semanas,
                              dias: dias,
                            ),
                          ]
                        : [
                            _tabBebe(
                              semanas,
                              dias,
                              descripcion,
                              imagen,
                              dioALuz,
                            ),
                            _tabComparacion(comparacion),
                            TabEstadisticas(
                              peso: peso,
                              altura: altura,
                              semanas: semanas,
                              dias: dias,
                            ),
                          ],
                  ),
                ),
                const SizedBox(height: 8),

                /// TABS
                TabBar(
                  labelColor: AppColors.primary,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: AppColors.primary,
                  tabs: tabs,
                  dividerColor: Colors.transparent,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// TABS PARA LA SECCION CARD

  Widget _tabBebe(
    int semanas,
    int dias,
    String descripcion,
    String imagen,
    bool dioALuz,
  ) {
    return Column(
      children: [
        Container(
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(14)),
          clipBehavior: Clip.hardEdge,
          child: Center(child: Bebe3dViewer(modelo: imagen)),
        ),

        const SizedBox(height: 10),

        Text(
          "$semanas semanas, $dias días",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            descripcion,
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _tabComparacion(String comparacion) {
    return Column(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.pink.shade50,
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Center(child: Text("Modelo 3D objeto comparativo")),
        ),

        const SizedBox(height: 15),

        Text(
          comparacion,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  /// TARJETA DESARROLLO
  Widget _cardDesarrollo(String descripcion) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1C2B2E) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.psychology_alt,
            color: isDark ? Colors.white : AppColors.textPrimary,
            size: 24,
          ),

          const SizedBox(width: 8),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Desarrollo de tu bebé esta semana",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : AppColors.textPrimary,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  descripcion,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.white : AppColors.textPrimary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // CUIDADOS HOY
  ///
  List<Map<String, dynamic>> obtenerCuidadosHoy(int edadDias) {
    int semana = edadDias ~/ 7;

    // Filtrar cuidados según edad
    List<Map<String, dynamic>> filtrados = cuidadosRN.where((cuidado) {
      final min = cuidado["edadMinDias"];
      final max = cuidado["edadMaxDias"];

      return edadDias >= min && edadDias <= max;
    }).toList();

    if (filtrados.isEmpty) return [];

    // Rotar lista según semana
    int inicio = semana % filtrados.length;

    List<Map<String, dynamic>> rotados = [
      ...filtrados.sublist(inicio),
      ...filtrados.sublist(0, inicio),
    ];

    // Mostrar solo 3
    return rotados.take(3).toList();
  }

  // ALERTAS
  ///
  List<Map<String, dynamic>> detectarAlertas(
    RegistroDiarioModel registro,
    bool dioALuz,
  ) {
    final tipo = dioALuz ? "postparto" : "embarazo";

    final List<Map<String, dynamic>> activas = [];

    for (var alerta in alertas) {
      if (alerta["tipo"] != tipo) continue;

      final campo = alerta["campo"];
      final condicion = alerta["condicion"];
      final valor = alerta["valor"];

      final Map<String, dynamic> data = registro.toMap();

      final dato = data[campo];

      if (dato == null || dato is! num) continue;

      bool cumple = false;

      switch (condicion) {
        case ">=":
          cumple = dato >= valor;
          break;
        case "<=":
          cumple = dato <= valor;
          break;
        case ">":
          cumple = dato > valor;
          break;
        case "<":
          cumple = dato < valor;
          break;
        case "==":
          cumple = dato == valor;
          break;
      }

      if (cumple) {
        activas.add({
          ...alerta,
          "valor_detectado": dato,
          "fecha_generada": Timestamp.now(),
          "estado": "activa",
        });
      }
    }
    return activas;
  }

  Widget _cardAlertas(List<Map<String, dynamic>> alertas) {
    if (alertas.isEmpty) return const SizedBox();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF3A1E1E),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.red, size: 24),
              SizedBox(width: 8),
              Text(
                "Signos de alerta",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          ...alertas.map((a) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.circle, size: 8, color: Colors.red),
                  const SizedBox(width: 8),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          a["titulo"],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          a["mensaje"],
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  /// COMPARACION DEL BEBE

  String _comparacionBebe(int semanas, bool dioALuz) {
    if (!dioALuz) {
      if (semanas < 8) return "Tu bebé es del tamaño de una semilla 🌱";
      if (semanas < 12) return "Tu bebé es del tamaño de una fresa 🍓";
      if (semanas < 16) return "Tu bebé es del tamaño de una palta 🥑";
      if (semanas < 20) return "Tu bebé es del tamaño de un mango 🥭";
      if (semanas < 30) return "Tu bebé es del tamaño de una piña 🍍";
      return "Tu bebé es del tamaño de una sandía 🍉";
    } else {
      if (semanas < 4) {
        return "Tu bebé aún es muy pequeñito, similar a un gatito 🐱";
      }
      if (semanas < 12) return "Tu bebé ya reconoce tu voz y crece rápidamente";
      if (semanas < 24) return "Tu bebé empieza a sonreír y observar el mundo";
      return "Tu bebé está desarrollando más habilidades cada día";
    }
  }

  // DESCRIPCIÓN SEGÚN SEMANAS
  static String _descripcionPorSemana(int semanas, bool dioALuz) {
    if (!dioALuz) {
      if (semanas <= 12) {
        return "Primer trimestre: Es normal sentir náuseas y fatiga. El bebé está formando sus órganos principales.";
      } else if (semanas <= 27) {
        return "Segundo trimestre: El bebé ya puede escuchar tu voz y sus movimientos son más fuertes.";
      } else {
        return "Tercer trimestre: El bebé está ganando peso rápidamente y preparándose para nacer.";
      }
    } else {
      if (semanas <= 4) {
        return "Tu bebé se está adaptando al mundo exterior. El contacto piel con piel fortalece el vínculo.";
      } else if (semanas <= 12) {
        return "Tu bebé empieza a sonreír y reconocer tu voz. La lactancia fortalece su sistema inmune.";
      } else if (semanas <= 24) {
        return "Tu bebé está desarrollando fuerza y coordinación cada día.";
      } else {
        return "Tu bebé continúa creciendo y aprendiendo nuevas habilidades.";
      }
    }
  }

  // IMAGEN SEGÚN SEMANAS
  static String _imagenPorSemana(int semanas, bool dioALuz) {
    if (!dioALuz) {
      if (semanas <= 4) {
        return "assets/3d/embrion.glb";
      } else if (semanas <= 12) {
        return "assets/3d/baby.glb";
      } else {
        return "assets/3d/bebograndeembarazo.glb";
      }
    } else {
      if (semanas <= 12) {
        return "assets/3d/recien_nacido.glb";
      } else {
        return "assets/3d/recien_nacido.glb";
      }
    }
  }
}
