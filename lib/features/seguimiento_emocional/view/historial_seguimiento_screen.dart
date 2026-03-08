import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/// Pantalla separada que muestra el historial emocional
/// de los últimos 7 días con un gráfico de barras simple
/// y la lista de registros detallados.
class HistorialEmocionalScreen extends StatelessWidget {
  const HistorialEmocionalScreen({super.key});

  // ── Helpers ─────────────────────────────────────────────────────────────
  static const _emojis = {5: '😄', 4: '🙂', 3: '😐', 2: '😟', 1: '😢'};
  static const _labels = {
    5: 'Muy bien',
    4: 'Bien',
    3: 'Regular',
    2: 'Mal',
    1: 'Muy mal',
  };
  static const _colores = {
    5: Color(0xFF4CAF50),
    4: Color(0xFF8BC34A),
    3: Color(0xFFFFC107),
    2: Color(0xFFFF9800),
    1: Color(0xFFF44336),
  };

  static final _diasSemana = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];

  // Genera los 7 días incluyendo hoy
  List<DateTime> get _ultimos7 {
    final now = DateTime.now();
    return List.generate(
      7,
      (i) => now.subtract(Duration(days: 6 - i)),
    );
  }

  // Clave de documento en Firestore
  String _fechaKey(DateTime d) => '${d.year}-${d.month}-${d.day}';

  // ── Carga ────────────────────────────────────────────────────────────────
  Future<List<_DiaRegistro>> _cargarHistorial(String uid) async {
    final dias = _ultimos7;
    final inicio = dias.first;
    final fin = dias.last;

    final snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('registros_diarios')
        .where(
          'fecha',
          isGreaterThanOrEqualTo: Timestamp.fromDate(
              DateTime(inicio.year, inicio.month, inicio.day)),
        )
        .where(
          'fecha',
          isLessThanOrEqualTo: Timestamp.fromDate(
              DateTime(fin.year, fin.month, fin.day, 23, 59)),
        )
        .get();

    // Indexa documentos por "año-mes-día"
    final Map<String, Map<String, dynamic>> porFecha = {
      for (final doc in snap.docs) doc.id: doc.data(),
    };

    return dias.map((d) {
      final data = porFecha[_fechaKey(d)];
      return _DiaRegistro(
        fecha: d,
        estadoAnimo: data?['estado_animo'] as int?,
        nivelEstres: data?['nivel_estres'] as int?,
        horasSueno: (data?['horas_sueno'] as num?)?.toDouble(),
        tomasLactancia: data?['tomas_lactancia'] as int?,
        tipo: data?['tipo'] as String?,
        hayAlerta: data?['hay_alerta'] as bool? ?? false,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == null) {
      return const Scaffold(
        body: Center(child: Text('Usuario no autenticado')),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
        title: const Text('Historial emocional'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<_DiaRegistro>>(
        future: _cargarHistorial(uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.pink),
            );
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final dias = snapshot.data ?? [];
          final registrados = dias.where((d) => d.estadoAnimo != null).length;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Encabezado resumen ─────────────────────────────────
                _TarjetaResumen(
                  registrados: registrados,
                  dias: dias,
                ),

                const SizedBox(height: 20),

                // ── Gráfico de barras ──────────────────────────────────
                const Text(
                  'Estado de ánimo',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                _GraficoBarras(dias: dias, diasSemana: _diasSemana),

                const SizedBox(height: 24),

                // ── Lista detallada ────────────────────────────────────
                const Text(
                  'Detalle por día',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                ...dias.reversed.map(
                  (d) => _TarjetaDia(
                    dia: d,
                    emojis: _emojis,
                    labels: _labels,
                    diasSemana: _diasSemana,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Modelo de datos
// ─────────────────────────────────────────────────────────────────────────────
class _DiaRegistro {
  final DateTime fecha;
  final int? estadoAnimo;
  final int? nivelEstres;
  final double? horasSueno;
  final int? tomasLactancia;
  final String? tipo;
  final bool hayAlerta;

  const _DiaRegistro({
    required this.fecha,
    this.estadoAnimo,
    this.nivelEstres,
    this.horasSueno,
    this.tomasLactancia,
    this.tipo,
    this.hayAlerta = false,
  });

  bool get tieneRegistro => estadoAnimo != null;
}

// ─────────────────────────────────────────────────────────────────────────────
//  Widget: tarjeta de resumen semanal
// ─────────────────────────────────────────────────────────────────────────────
class _TarjetaResumen extends StatelessWidget {
  final int registrados;
  final List<_DiaRegistro> dias;

  const _TarjetaResumen({
    required this.registrados,
    required this.dias,
  });

  // Promedio de estado de ánimo de los días registrados
  double get _promedio {
    final conRegistro = dias.where((d) => d.estadoAnimo != null).toList();
    if (conRegistro.isEmpty) return 0;
    final suma = conRegistro.fold<int>(
        0, (acc, d) => acc + (d.estadoAnimo ?? 0));
    return suma / conRegistro.length;
  }

  bool get _hayAlertaSemana => dias.any((d) => d.hayAlerta);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFC6B8A), Color(0xFFFF8FAB)],
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Esta semana',
            style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _StatChip(
                valor: '$registrados / 7',
                label: 'días registrados',
                icono: Icons.check_circle_outline,
              ),
              const SizedBox(width: 12),
              _StatChip(
                valor: _promedio > 0
                    ? _promedio.toStringAsFixed(1)
                    : '—',
                label: 'ánimo promedio',
                icono: Icons.favorite_border,
              ),
            ],
          ),
          if (_hayAlertaSemana) ...[
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
                  Text(
                    'Hubo días con alertas esta semana',
                    style: TextStyle(
                        color: Colors.orange,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String valor;
  final String label;
  final IconData icono;

  const _StatChip({
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
        children: [
          Icon(icono, color: Colors.white, size: 18),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(valor,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              Text(label,
                  style: const TextStyle(
                      color: Colors.white70, fontSize: 11)),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Widget: gráfico de barras manual (sin dependencias externas)
// ─────────────────────────────────────────────────────────────────────────────
class _GraficoBarras extends StatelessWidget {
  final List<_DiaRegistro> dias;
  final List<String> diasSemana;

  const _GraficoBarras({required this.dias, required this.diasSemana});

  static const _colores = {
    5: Color(0xFF4CAF50),
    4: Color(0xFF8BC34A),
    3: Color(0xFFFFC107),
    2: Color(0xFFFF9800),
    1: Color(0xFFF44336),
  };
  static const _emojis = {5: '😄', 4: '🙂', 3: '😐', 2: '😟', 1: '😢'};

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05), blurRadius: 6),
        ],
      ),
      child: Column(
        children: [
          // Barras
          SizedBox(
            height: 130,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: dias.map((d) {
                final animo = d.estadoAnimo;
                final esHoy = d.fecha.day == now.day &&
                    d.fecha.month == now.month &&
                    d.fecha.year == now.year;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Emoji encima de la barra
                    Text(
                      animo != null ? (_emojis[animo] ?? '') : '',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    // Barra animada
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeOut,
                      width: 28,
                      height: animo != null ? (animo / 5) * 80 : 4,
                      decoration: BoxDecoration(
                        color: animo != null
                            ? (_colores[animo] ?? Colors.grey)
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

          // Etiquetas de días
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: dias.map((d) {
              final esHoy = d.fecha.day == now.day &&
                  d.fecha.month == now.month &&
                  d.fecha.year == now.year;
              return SizedBox(
                width: 28,
                child: Text(
                  diasSemana[d.fecha.weekday - 1],
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

          // Leyenda
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 4,
            alignment: WrapAlignment.center,
            children: const [
              _LeyendaItem(color: Color(0xFF4CAF50), label: 'Muy bien'),
              _LeyendaItem(color: Color(0xFF8BC34A), label: 'Bien'),
              _LeyendaItem(color: Color(0xFFFFC107), label: 'Regular'),
              _LeyendaItem(color: Color(0xFFFF9800), label: 'Mal'),
              _LeyendaItem(color: Color(0xFFF44336), label: 'Muy mal'),
            ],
          ),
        ],
      ),
    );
  }
}

class _LeyendaItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LeyendaItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            width: 10,
            height: 10,
            decoration:
                BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 11)),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Widget: tarjeta de detalle por día
// ─────────────────────────────────────────────────────────────────────────────
class _TarjetaDia extends StatelessWidget {
  final _DiaRegistro dia;
  final Map<int, String> emojis;
  final Map<int, String> labels;
  final List<String> diasSemana;

  const _TarjetaDia({
    required this.dia,
    required this.emojis,
    required this.labels,
    required this.diasSemana,
  });

  static const _estresLabels = {1: 'Bajo', 2: 'Medio', 3: 'Alto'};

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final esHoy = dia.fecha.day == now.day &&
        dia.fecha.month == now.month &&
        dia.fecha.year == now.year;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: esHoy
            ? Border.all(color: Colors.pink, width: 1.5)
            : dia.hayAlerta
                ? Border.all(color: Colors.orange, width: 1.5)
                : null,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04), blurRadius: 4),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Fecha
          SizedBox(
            width: 44,
            child: Column(
              children: [
                Text(
                  '${dia.fecha.day}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: esHoy ? Colors.pink : Colors.black87,
                  ),
                ),
                Text(
                  diasSemana[dia.fecha.weekday - 1],
                  style: TextStyle(
                    fontSize: 11,
                    color: esHoy ? Colors.pink : Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          const VerticalDivider(width: 20),

          // Contenido
          Expanded(
            child: dia.tieneRegistro
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Ánimo
                      Row(
                        children: [
                          Text(
                            emojis[dia.estadoAnimo] ?? '○',
                            style: const TextStyle(fontSize: 22),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            labels[dia.estadoAnimo] ?? '',
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          ),
                          if (dia.hayAlerta) ...[
                            const SizedBox(width: 8),
                            const Icon(Icons.warning_amber_rounded,
                                color: Colors.orange, size: 16),
                          ],
                        ],
                      ),

                      // Campos extra postparto
                      if (dia.tipo == 'postparto') ...[
                        const SizedBox(height: 6),
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: [
                            if (dia.nivelEstres != null)
                              _PillInfo(
                                icono: Icons.bolt,
                                texto:
                                    'Estrés: ${_estresLabels[dia.nivelEstres] ?? ''}',
                              ),
                            if (dia.horasSueno != null)
                              _PillInfo(
                                icono: Icons.bedtime,
                                texto:
                                    '${dia.horasSueno!.toStringAsFixed(1)} h sueño',
                              ),
                            if (dia.tomasLactancia != null)
                              _PillInfo(
                                icono: Icons.child_care,
                                texto: '${dia.tomasLactancia} tomas',
                              ),
                          ],
                        ),
                      ],
                    ],
                  )
                : const Text(
                    'Sin registro',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
          ),
        ],
      ),
    );
  }
}

class _PillInfo extends StatelessWidget {
  final IconData icono;
  final String texto;

  const _PillInfo({required this.icono, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.pink.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icono, size: 12, color: Colors.pink),
          const SizedBox(width: 4),
          Text(texto,
              style:
                  const TextStyle(fontSize: 11, color: Colors.black87)),
        ],
      ),
    );
  }
}