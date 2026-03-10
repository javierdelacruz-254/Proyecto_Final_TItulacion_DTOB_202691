import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/core/constants/consejos_data.dart';
import 'package:lactaamor/core/constants/contenido_data.dart';
import 'package:lactaamor/core/constants/cuidados_bebe_data.dart';
import 'package:lactaamor/core/constants/recetas_data.dart';
import 'package:lactaamor/features/contenidos/models/contenido_model.dart';
import 'package:lactaamor/features/home/models/registro_diario_model.dart';
import 'package:lactaamor/features/home/view/widgets/consejo_card.dart';
import 'package:lactaamor/features/home/view/widgets/cuidados_card.dart';
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

    final totalSemanas = dioALuz ? 52 : 40;

    final progreso = (semanas / totalSemanas).clamp(0.0, 1.0);

    final titulo = dioALuz
        ? "Tu bebé tiene $semanas semanas 👶"
        : "Tienes $semanas semanas de embarazo 🤰";

    final descripcion = _descripcionPorSemana(semanas, dioALuz);
    final imagen = _imagenPorSemana(semanas, dioALuz);

    final comparacion = _comparacionBebe(semanas, dioALuz);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F4F6),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              /// SALUDO
              Text(
                "Hola, ${user.fullname.split(" ").first} 🌸",
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                titulo,
                style: const TextStyle(fontSize: 18, color: Colors.black54),
              ),

              const SizedBox(height: 30),

              /// TARJETA PROGRESO
              _cardProgreso(progreso, dioALuz, semanas),

              const SizedBox(height: 20),

              /// TARJETA TAMAÑO DEL BEBÉ
              _cardTamanoBebe(imagen, comparacion),

              const SizedBox(height: 20),

              /// CONSEJO DEL DIA
              ConsejoCard(
                semanas: semanas,
                dioALuz: dioALuz,
                recomendaciones: recomendaciones,
                articulosMap: articulosMap,
              ),

              const SizedBox(height: 20),

              // RECOMENDACION DEL DIA CUIDADOS DEL BEBE
              if (dioALuz)
                CuidadosHoyCard(
                  cuidados: obtenerCuidadosHoy(dias),
                  articulosMap: articulosMap,
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

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  /// TARJETA PROGRESO

  Widget _cardProgreso(double progreso, bool dioALuz, int semanas) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            dioALuz ? "Desarrollo del bebé" : "Progreso del embarazo",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 12),

          LinearProgressIndicator(
            value: progreso,
            minHeight: 10,
            borderRadius: BorderRadius.circular(20),
            backgroundColor: Colors.grey.shade200,
            valueColor: AlwaysStoppedAnimation(
              dioALuz ? Colors.blue.shade300 : Colors.pink.shade300,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            "$semanas semanas",
            style: const TextStyle(color: Colors.black54),
          ),
        ],
      ),
    );
  }

  /// TARJETA TAMAÑO DEL BEBÉ

  Widget _cardTamanoBebe(String imagen, String comparacion) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          const Text(
            "Tamaño aproximado del bebé",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 16),

          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              imagen,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            comparacion,
            style: const TextStyle(fontSize: 15, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// TARJETA DESARROLLO
  Widget _cardDesarrollo(String descripcion) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Desarrollo esta semana",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            descripcion,
            style: const TextStyle(height: 1.5, color: Colors.black),
          ),
        ],
      ),
    );
  }

  // CUIDADOS HOY
  ///
  List<Map<String, dynamic>> obtenerCuidadosHoy(int edadDias) {
    return cuidadosRN
        .where((cuidado) {
          final min = cuidado["edadMinDias"];
          final max = cuidado["edadMaxDias"];

          return edadDias >= min && edadDias <= max;
        })
        .take(3)
        .toList();
  }

  /// DECORACION TARJETAS

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(25),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.06),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
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
      if (semanas <= 12) {
        return "https://res.cloudinary.com/dqqhqnbny/image/upload/v1771478394/bebe_12_lyo3vi.jpg";
      } else if (semanas <= 27) {
        return "https://res.cloudinary.com/dqqhqnbny/image/upload/v1771478394/bebe_24_mcq1nn.jpg";
      } else {
        return "https://res.cloudinary.com/dqqhqnbny/image/upload/v1771478394/bebe_36_zmrtzy.jpg";
      }
    } else {
      if (semanas <= 12) {
        return "https://res.cloudinary.com/dqqhqnbny/image/upload/v1771478826/nacido_12m_uvsrtb.jpg";
      } else {
        return "https://res.cloudinary.com/dqqhqnbny/image/upload/v1771478826/nacido_1y_pgvtjc.jpg";
      }
    }
  }
}
