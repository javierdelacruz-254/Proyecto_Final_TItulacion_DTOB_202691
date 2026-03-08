import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lactaamor/features/seguimiento_emocional/view/seguimiento_screen.dart';


/// Historial semanal completo: datos emocionales, clínicos de la madre
/// y seguimiento del bebé (postparto). Muestra los últimos 7 días.
class HistorialScreen extends StatefulWidget {
  final VoidCallback? onVolver;
  const HistorialScreen({super.key, this.onVolver});

  @override
  State<HistorialScreen> createState() => _HistorialScreenState();
}

class _HistorialScreenState extends State<HistorialScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      return const Scaffold(body: Center(child: Text('No autenticada')));
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
        title: const Text('Mi Historial'),
        centerTitle: true,
        leading: widget.onVolver != null
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                tooltip: 'Volver al registro',
                onPressed: widget.onVolver,
              )
            : null,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          tabs: const [
            Tab(icon: Icon(Icons.favorite), text: 'Yo'),
            Tab(icon: Icon(Icons.child_care), text: 'Bebé'),
          ],
        ),
      ),
      body: FutureBuilder<_DatosHistorial>(
        future: _cargarHistorial(uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.pink));
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final datos = snapshot.data!;

          return TabBarView(
            controller: _tabController,
            children: [
              // ── TAB 1: YO (madre) ─────────────────────────────────
              _TabMadre(registros: datos.registros),
              // ── TAB 2: BEBÉ ───────────────────────────────────────
              _TabBebe(registros: datos.registros),
            ],
          );
        },
      ),
    );
  }

  Future<_DatosHistorial> _cargarHistorial(String uid) async {
    final ahora = DateTime.now();
    final inicio = ahora.subtract(const Duration(days: 6));

    final snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('registros_diarios')
        .where('fecha',
            isGreaterThanOrEqualTo: Timestamp.fromDate(
                DateTime(inicio.year, inicio.month, inicio.day)))
        .where('fecha',
            isLessThanOrEqualTo: Timestamp.fromDate(
                DateTime(ahora.year, ahora.month, ahora.day, 23, 59)))
        .orderBy('fecha', descending: true)
        .get();

    final dias = List.generate(7, (i) => ahora.subtract(Duration(days: i)));
    final registrosPorFecha = <DateTime, Map<String, dynamic>>{};

    for (final doc in snap.docs) {
      final ts = doc.data()['fecha'] as Timestamp?;
      if (ts == null) continue;
      final d = ts.toDate();
      final key = DateTime(d.year, d.month, d.day);
      registrosPorFecha[key] = doc.data();
    }

    final lista = dias.map((d) {
      final key = DateTime(d.year, d.month, d.day);
      return _RegistroDia(
        fecha: d,
        datos: registrosPorFecha[key],
      );
    }).toList();

    return _DatosHistorial(registros: lista);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Modelos
// ─────────────────────────────────────────────────────────────────────────────

class _DatosHistorial {
  final List<_RegistroDia> registros;
  const _DatosHistorial({required this.registros});
}

class _RegistroDia {
  final DateTime fecha;
  final Map<String, dynamic>? datos;

  const _RegistroDia({required this.fecha, this.datos});

  bool get tieneRegistro => datos != null;
  bool get esPostparto => datos?['tipo'] == 'postparto';
  bool get hayAlerta => datos?['hay_alerta'] as bool? ?? false;
  bool get hayAlertaMadre => datos?['hay_alerta_madre'] as bool? ?? false;
  bool get hayAlertaBebe => datos?['hay_alerta_bebe'] as bool? ?? false;
}

// ─────────────────────────────────────────────────────────────────────────────
//  TAB MADRE
// ─────────────────────────────────────────────────────────────────────────────

class _TabMadre extends StatelessWidget {
  final List<_RegistroDia> registros;
  const _TabMadre({required this.registros});

  static const _emojis = {5: '😄', 4: '🙂', 3: '😐', 2: '😟', 1: '😢'};
  static const _animoLabels = {
    5: 'Muy bien', 4: 'Bien', 3: 'Regular', 2: 'Triste', 1: 'Muy mal',
  };
  static const _animoColores = {
    5: Color(0xFF4CAF50),
    4: Color(0xFF8BC34A),
    3: Color(0xFFFFC107),
    2: Color(0xFFFF9800),
    1: Color(0xFFF44336),
  };

  int get _registrados => registros.where((r) => r.tieneRegistro).length;

  double get _promedioAnimo {
    final con = registros
        .where((r) => r.datos?['estado_animo'] != null)
        .toList();
    if (con.isEmpty) return 0;
    return con.fold<int>(0, (a, r) => a + (r.datos!['estado_animo'] as int)) /
        con.length;
  }

  bool get _hayAlertaSemana =>
      registros.any((r) => r.hayAlertaMadre || (r.hayAlerta && !r.esPostparto));

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tarjeta resumen
          _TarjetaResumenMadre(
            registrados: _registrados,
            promedioAnimo: _promedioAnimo,
            hayAlerta: _hayAlertaSemana,
          ),

          const SizedBox(height: 20),

          // Gráfico de ánimo
          const Text('Estado de ánimo 7 días',
              style:
                  TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _GraficoAnimo(
              registros: registros,
              emojis: _emojis,
              colores: _animoColores),

          const SizedBox(height: 24),

          // Detalle día a día
          const Text('Detalle por día',
              style:
                  TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),

          ...registros.map((r) => _TarjetaDiaMadre(
                dia: r,
                emojis: _emojis,
                animoLabels: _animoLabels,
                animoColores: _animoColores,
              )),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  TAB BEBÉ
// ─────────────────────────────────────────────────────────────────────────────

class _TabBebe extends StatelessWidget {
  final List<_RegistroDia> registros;
  const _TabBebe({required this.registros});

  List<_RegistroDia> get _postparto =>
      registros.where((r) => r.esPostparto).toList();

  @override
  Widget build(BuildContext context) {
    if (_postparto.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('👶', style: TextStyle(fontSize: 48)),
            SizedBox(height: 12),
            Text('Los datos del bebé aparecerán\ncuando empiece el postparto',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Resumen bebé
          _TarjetaResumenBebe(registros: _postparto),

          const SizedBox(height: 20),

          // Gráfico temperatura
          if (_postparto.any((r) => r.datos?['temperatura_bebe'] != null)) ...[
            const Text('Temperatura del bebé',
                style:
                    TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _GraficoTemperatura(registros: _postparto),
            const SizedBox(height: 24),
          ],

          // Detalle bebé por día
          const Text('Detalle por día',
              style:
                  TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),

          ..._postparto.map((r) => _TarjetaDiaBebe(dia: r)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Widgets de resumen
// ─────────────────────────────────────────────────────────────────────────────

class _TarjetaResumenMadre extends StatelessWidget {
  final int registrados;
  final double promedioAnimo;
  final bool hayAlerta;

  const _TarjetaResumenMadre({
    required this.registrados,
    required this.promedioAnimo,
    required this.hayAlerta,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            colors: [Color(0xFFFC6B8A), Color(0xFFFF8FAB)]),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Esta semana',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500)),
          const SizedBox(height: 10),
          Row(
            children: [
              _StatPill(
                  valor: '$registrados/7',
                  label: 'días registrados',
                  icono: Icons.check_circle_outline),
              const SizedBox(width: 10),
              _StatPill(
                  valor: promedioAnimo > 0
                      ? promedioAnimo.toStringAsFixed(1)
                      : '—',
                  label: 'ánimo promedio',
                  icono: Icons.favorite_border),
            ],
          ),
          if (hayAlerta) ...[
            const SizedBox(height: 10),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.warning_amber_rounded,
                      color: Colors.orange, size: 16),
                  SizedBox(width: 6),
                  Text('Hubo alertas esta semana',
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 12,
                          fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _TarjetaResumenBebe extends StatelessWidget {
  final List<_RegistroDia> registros;
  const _TarjetaResumenBebe({required this.registros});

  double get _tempPromedio {
    final con = registros
        .where((r) => r.datos?['temperatura_bebe'] != null)
        .toList();
    if (con.isEmpty) return 0;
    return con.fold<double>(
            0, (a, r) => a + (r.datos!['temperatura_bebe'] as num).toDouble()) /
        con.length;
  }

  double get _pesoMasReciente {
    for (final r in registros) {
      final p = r.datos?['peso_bebe'];
      if (p != null) return double.tryParse(p.toString()) ?? 0;
    }
    return 0;
  }

  bool get _hayAlertaBebe =>
      registros.any((r) => r.hayAlertaBebe);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            colors: [Color(0xFF7986CB), Color(0xFF9FA8DA)]),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Bebé esta semana',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500)),
          const SizedBox(height: 10),
          Row(
            children: [
              if (_tempPromedio > 0)
                _StatPill(
                    valor: '${_tempPromedio.toStringAsFixed(1)}°C',
                    label: 'temp. promedio',
                    icono: Icons.thermostat),
              const SizedBox(width: 10),
              if (_pesoMasReciente > 0)
                _StatPill(
                    valor: '$_pesoMasReciente kg',
                    label: 'último peso',
                    icono: Icons.monitor_weight),
            ],
          ),
          if (_hayAlertaBebe) ...[
            const SizedBox(height: 10),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.warning_amber_rounded,
                      color: Colors.orange, size: 16),
                  SizedBox(width: 6),
                  Text('Hubo alertas del bebé esta semana',
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 12,
                          fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Gráficos
// ─────────────────────────────────────────────────────────────────────────────

class _GraficoAnimo extends StatelessWidget {
  final List<_RegistroDia> registros;
  final Map<int, String> emojis;
  final Map<int, Color> colores;

  const _GraficoAnimo({
    required this.registros,
    required this.emojis,
    required this.colores,
  });

  static const _dias = ['L', 'M', 'M', 'J', 'V', 'S', 'D'];

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 120,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: registros.reversed.map((r) {
                final animo = r.datos?['estado_animo'] as int?;
                final esHoy = r.fecha.day == now.day &&
                    r.fecha.month == now.month;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(animo != null ? (emojis[animo] ?? '') : '',
                        style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 4),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      width: 26,
                      height: animo != null ? (animo / 5) * 72 : 4,
                      decoration: BoxDecoration(
                        color: animo != null
                            ? (colores[animo] ?? Colors.grey)
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(6),
                        border: esHoy
                            ? Border.all(color: Colors.pink, width: 2)
                            : null,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: registros.reversed.map((r) {
              final esHoy = r.fecha.day == now.day &&
                  r.fecha.month == now.month;
              return SizedBox(
                width: 26,
                child: Text(
                  _dias[r.fecha.weekday - 1],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight:
                        esHoy ? FontWeight.bold : FontWeight.normal,
                    color: esHoy ? Colors.pink : Colors.grey,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _GraficoTemperatura extends StatelessWidget {
  final List<_RegistroDia> registros;
  const _GraficoTemperatura({required this.registros});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6),
        ],
      ),
      child: Column(
        children: [
          // Zona normal vs alerta
          const Row(
            children: [
              _LeyendaColor(color: Color(0xFF4CAF50), label: 'Normal (36–38°C)'),
              SizedBox(width: 16),
              _LeyendaColor(color: Color(0xFFF44336), label: 'Fuera de rango'),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 100,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: registros.reversed.map((r) {
                final temp = (r.datos?['temperatura_bebe'] as num?)?.toDouble();
                final esAlerta =
                    temp != null && (temp > 38.0 || temp < 36.0);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (temp != null)
                      Text(
                        '${temp.toStringAsFixed(1)}°',
                        style: TextStyle(
                          fontSize: 10,
                          color: esAlerta ? Colors.red : Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    const SizedBox(height: 2),
                    Container(
                      width: 24,
                      height: temp != null ? ((temp - 35) / 5) * 72 : 4,
                      decoration: BoxDecoration(
                        color: temp == null
                            ? Colors.grey.shade200
                            : esAlerta
                                ? const Color(0xFFF44336)
                                : const Color(0xFF4CAF50),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Tarjetas detalle por día
// ─────────────────────────────────────────────────────────────────────────────

class _TarjetaDiaMadre extends StatelessWidget {
  final _RegistroDia dia;
  final Map<int, String> emojis;
  final Map<int, String> animoLabels;
  final Map<int, Color> animoColores;

  const _TarjetaDiaMadre({
    required this.dia,
    required this.emojis,
    required this.animoLabels,
    required this.animoColores,
  });

  static const _dias = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];
  static const _estresLabels = {1: 'Bajo', 2: 'Medio', 3: 'Alto'};

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final esHoy = dia.fecha.day == now.day && dia.fecha.month == now.month;
    final animo = dia.datos?['estado_animo'] as int?;
    final estres = dia.datos?['nivel_estres'] as int?;
    final sueno = (dia.datos?['horas_sueno_madre'] ??
            dia.datos?['horas_sueno']) as num?;
    final presionSis = dia.datos?['presion_sistolica'] as int?;
    final presionDia = dia.datos?['presion_diastolica'] as int?;
    final sintomas = (dia.datos?['sintomas'] as List?)?.cast<String>() ?? [];
    final notas = dia.datos?['notas'] as String?;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: esHoy
            ? Border.all(color: Colors.pink, width: 1.5)
            : dia.hayAlertaMadre
                ? Border.all(color: Colors.orange, width: 1.5)
                : null,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04), blurRadius: 4),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cabecera fecha
          Row(
            children: [
              Text(
                '${dia.fecha.day} ${_dias[dia.fecha.weekday - 1]}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: esHoy ? Colors.pink : Colors.black87,
                ),
              ),
              if (esHoy) ...[
                const SizedBox(width: 6),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('Hoy',
                      style: TextStyle(color: Colors.white, fontSize: 10)),
                ),
              ],
              if (dia.hayAlertaMadre) ...[
                const SizedBox(width: 6),
                const Icon(Icons.warning_amber_rounded,
                    color: Colors.orange, size: 16),
              ],
            ],
          ),

          if (!dia.tieneRegistro) ...[
            const SizedBox(height: 6),
            const Text('Sin registro',
                style: TextStyle(color: Colors.grey, fontSize: 13)),
          ] else ...[
            const SizedBox(height: 10),

            // Fila ánimo + sueño + estrés
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: [
                if (animo != null)
                  _InfoChip(
                    texto:
                        '${emojis[animo]} ${animoLabels[animo]}',
                    color: (animoColores[animo] ?? Colors.grey)
                        .withOpacity(0.15),
                  ),
                if (estres != null)
                  _InfoChip(
                    texto:
                        '⚡ Estrés: ${_estresLabels[estres]}',
                    color: Colors.orange.withOpacity(0.1),
                  ),
                if (sueno != null)
                  _InfoChip(
                    texto: '🌙 ${sueno.toStringAsFixed(1)} h sueño',
                    color: Colors.indigo.withOpacity(0.1),
                  ),
                if (presionSis != null && presionDia != null)
                  _InfoChip(
                    texto: '❤️ $presionSis/$presionDia mmHg',
                    color: presionSis >= 140
                        ? Colors.red.withOpacity(0.15)
                        : Colors.green.withOpacity(0.1),
                  ),
              ],
            ),

            // Síntomas
            if (sintomas.isNotEmpty) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 4,
                runSpacing: 4,
                children: sintomas.map((s) => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.pink.shade50,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child:
                      Text(s, style: const TextStyle(fontSize: 11)),
                )).toList(),
              ),
            ],

            // Notas
            if (notas != null && notas.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text('📝 $notas',
                  style:
                      const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ],
        ],
      ),
    );
  }
}

class _TarjetaDiaBebe extends StatelessWidget {
  final _RegistroDia dia;
  const _TarjetaDiaBebe({required this.dia});

  static const _dias = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final esHoy = dia.fecha.day == now.day && dia.fecha.month == now.month;
    final temp = (dia.datos?['temperatura_bebe'] as num?)?.toDouble();
    final peso = dia.datos?['peso_bebe'];
    final tomas = dia.datos?['tomas_lactancia'] as int?;
    final panales = dia.datos?['panales_mojados'] as int?;
    final deposiciones = dia.datos?['deposiciones'] as int?;
    final colorDep = dia.datos?['color_deposicion'] as String?;
    final suenoBebe = (dia.datos?['horas_sueno_bebe'] as num?)?.toDouble();

    final tempAlerta = temp != null && (temp > 38.0 || temp < 36.0);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: esHoy
            ? Border.all(color: Colors.indigo, width: 1.5)
            : dia.hayAlertaBebe
                ? Border.all(color: Colors.orange, width: 1.5)
                : null,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04), blurRadius: 4),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '${dia.fecha.day} ${_dias[dia.fecha.weekday - 1]}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: esHoy ? Colors.indigo : Colors.black87,
                ),
              ),
              if (dia.hayAlertaBebe) ...[
                const SizedBox(width: 6),
                const Icon(Icons.warning_amber_rounded,
                    color: Colors.orange, size: 16),
              ],
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: [
              if (temp != null)
                _InfoChip(
                  texto: '🌡️ ${temp.toStringAsFixed(1)}°C',
                  color: tempAlerta
                      ? Colors.red.withOpacity(0.15)
                      : Colors.green.withOpacity(0.1),
                ),
              if (peso != null)
                _InfoChip(
                  texto: '⚖️ $peso kg',
                  color: Colors.purple.withOpacity(0.1),
                ),
              if (tomas != null)
                _InfoChip(
                  texto: '🤱 $tomas tomas',
                  color: Colors.pink.withOpacity(0.1),
                ),
              if (panales != null)
                _InfoChip(
                  texto: '💧 $panales pañales',
                  color: Colors.blue.withOpacity(0.1),
                ),
              if (deposiciones != null)
                _InfoChip(
                  texto: '🟤 $deposiciones deposiciones',
                  color: Colors.brown.withOpacity(0.1),
                ),
              if (suenoBebe != null)
                _InfoChip(
                  texto: '😴 ${suenoBebe.toStringAsFixed(1)} h sueño',
                  color: Colors.deepPurple.withOpacity(0.1),
                ),
            ],
          ),
          if (colorDep != null) ...[
            const SizedBox(height: 6),
            Text('Deposición: $colorDep',
                style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Widgets auxiliares
// ─────────────────────────────────────────────────────────────────────────────

class _StatPill extends StatelessWidget {
  final String valor;
  final String label;
  final IconData icono;

  const _StatPill({
    required this.valor,
    required this.label,
    required this.icono,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icono, color: Colors.white, size: 16),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(valor,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15)),
              Text(label,
                  style: const TextStyle(
                      color: Colors.white70, fontSize: 10)),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String texto;
  final Color color;

  const _InfoChip({required this.texto, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(texto,
          style: const TextStyle(fontSize: 12, color: Colors.black87)),
    );
  }
}

class _LeyendaColor extends StatelessWidget {
  final Color color;
  final String label;

  const _LeyendaColor({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            width: 12,
            height: 12,
            decoration:
                BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 11)),
      ],
    );
  }
}