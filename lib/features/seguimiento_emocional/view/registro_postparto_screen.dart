import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lactaamor/features/contenidos/view/widgets/centros_salud_screen.dart';
import 'package:lactaamor/features/seguimiento_emocional/view/widgets/bienestar_widget.dart';
import 'historial_seguimiento_screen.dart';


/// Formulario de registro diario para madre en etapa postparto.
/// Recibe [datosBebe] del perfil para mostrar información del bebé
/// y calcular su edad en semanas/meses.
class RegistroPostpartoScreen extends StatefulWidget {
  final String nombreMadre;
  final Map<String, dynamic> datosBebe;

  const RegistroPostpartoScreen({
    super.key,
    required this.nombreMadre,
    required this.datosBebe,
  });

  @override
  State<RegistroPostpartoScreen> createState() =>
      _RegistroPostpartoScreenState();
}

class _RegistroPostpartoScreenState
    extends State<RegistroPostpartoScreen> {
  final DateTime _hoy = DateTime.now();

  // ── Campos del formulario ──────────────────────────────────────────────
  int _estadoAnimo = 3;
  int _nivelEstres = 2;       // 1 Bajo · 2 Medio · 3 Alto
  double _horasSueno = 6;
  int _tomasLactancia = 0;
  final TextEditingController _pesoBebeCtrl = TextEditingController();
  final TextEditingController _notasCtrl = TextEditingController();
  final List<String> _sintomasSeleccionados = [];

  static const List<String> _sintomasPostparto = [
    'Dolor en puntos de sutura',
    'Sangrado abundante',
    'Fiebre',
    'Tristeza persistente',
    'Ansiedad',
    'Fatiga extrema',
    'Dolor de cabeza',
    'Problemas con lactancia',
  ];

  static const Set<String> _sintomasGraves = {
    'Sangrado abundante',
    'Fiebre',
    'Tristeza persistente',
    'Ansiedad',
  };

  bool get _hayAlerta =>
      _sintomasSeleccionados.any(_sintomasGraves.contains) ||
      _estadoAnimo <= 2;

  // ── Datos del bebé calculados ──────────────────────────────────────────

  /// Nombre o sexo del bebé para mostrar en pantalla
  String get _nombreBebe {
    final sexo = widget.datosBebe['sexo_bebe'] as String? ?? '';
    return sexo == 'masculino' ? 'tu bebé 👦' : 'tu bebé 👧';
  }

  /// Edad del bebé en semanas o meses
  String get _edadBebe {
    final raw = widget.datosBebe['fecha_nacimiento_bebe'];
    DateTime? nacimiento;

    if (raw is Timestamp) {
      nacimiento = raw.toDate();
    } else if (raw is String) {
      try {
        nacimiento = DateTime.parse(raw);
      } catch (_) {}
    }

    if (nacimiento == null) return '';

    final dias = _hoy.difference(nacimiento).inDays;
    if (dias < 7) return '$dias días';
    final semanas = (dias / 7).floor();
    if (semanas < 8) return '$semanas semanas';
    final meses = (dias / 30.44).floor();
    return '$meses ${meses == 1 ? 'mes' : 'meses'}';
  }

  /// Tipo de alimentación registrado (pecho / fórmula / mixto)
  String get _tipoAlimentacion {
    final tipo = widget.datosBebe['tipo_alimentacion'] as String? ?? 'pecho';
    const mapa = {
      'pecho': 'Lactancia materna',
      'formula': 'Fórmula',
      'mixto': 'Mixta',
    };
    return mapa[tipo] ?? tipo;
  }

  // ── Helpers visuales ───────────────────────────────────────────────────
  String _estresLabel(int v) =>
      const {1: 'Bajo 🟢', 2: 'Medio 🟡', 3: 'Alto 🔴'}[v]!;

  Color _estresColor(int v) =>
      const {1: Color(0xFF4CAF50), 2: Color(0xFFFF9800), 3: Color(0xFFF44336)}[v]!;

  // ── Guardar en Firestore ───────────────────────────────────────────────
  Future<void> _guardar() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final fechaKey = '${_hoy.year}-${_hoy.month}-${_hoy.day}';

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('registros_diarios')
        .doc(fechaKey)
        .set({
      'tipo': 'postparto',
      'fecha': Timestamp.fromDate(DateTime(_hoy.year, _hoy.month, _hoy.day)),
      'estado_animo': _estadoAnimo,
      'nivel_estres': _nivelEstres,
      'horas_sueno': _horasSueno,
      'tomas_lactancia': _tomasLactancia,
      'peso_bebe': _pesoBebeCtrl.text.trim(),
      'sintomas': _sintomasSeleccionados,
      'notas': _notasCtrl.text.trim(),
      'hay_alerta': _hayAlerta,
      'updated_at': Timestamp.now(),
    });

    if (!mounted) return;

    if (_hayAlerta) {
      _mostrarDialogoAlerta();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registro guardado correctamente 💙')),
      );
    }
  }

  void _mostrarDialogoAlerta() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.orange),
            SizedBox(width: 8),
            Expanded(child: Text('Hemos notado algo importante')),
          ],
        ),
        content: const Text(
          'Algunos síntomas o tu estado de ánimo pueden indicar '
          'que necesitas apoyo. No estás sola 💙\n\n'
          'Te recomendamos hablar con un profesional de salud '
          'o con alguien de confianza.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CentrosSaludScreen(),
                ),
              );
            },
            child: const Text('Ver centros de salud'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pesoBebeCtrl.dispose();
    _notasCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
        title: const Text('Mi Bienestar · Postparto'),
        actions: [
          IconButton(
            tooltip: 'Ver historial',
            icon: const Icon(Icons.bar_chart),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const HistorialEmocionalScreen()),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 40),
        child: Column(
          children: [
            // ── Banner bebé ────────────────────────────────────────────
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFC6B8A), Color(0xFFFF8FAB)],
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  const Text('👶', style: TextStyle(fontSize: 36)),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hola, ${widget.nombreMadre} 💕',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (_edadBebe.isNotEmpty)
                        Text(
                          '$_nombreBebe tiene $_edadBebe',
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 13),
                        ),
                      Text(
                        _tipoAlimentacion,
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ── Estado de ánimo ────────────────────────────────────────
            SeccionCard(
              icon: Icons.favorite,
              title: '¿Cómo te sientes hoy?',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [5, 4, 3, 2, 1]
                    .map((v) => EmojiButton(
                          valor: v,
                          isSelected: _estadoAnimo == v,
                          onTap: () => setState(() => _estadoAnimo = v),
                        ))
                    .toList(),
              ),
            ),

            // ── Nivel de estrés ────────────────────────────────────────
            SeccionCard(
              icon: Icons.bolt,
              title: 'Nivel de estrés',
              child: Column(
                children: [
                  Text(
                    _estresLabel(_nivelEstres),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: _estresColor(_nivelEstres),
                    ),
                  ),
                  Slider(
                    value: _nivelEstres.toDouble(),
                    min: 1,
                    max: 3,
                    divisions: 2,
                    activeColor: _estresColor(_nivelEstres),
                    onChanged: (v) =>
                        setState(() => _nivelEstres = v.round()),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Bajo', style: TextStyle(fontSize: 11, color: Color(0xFF4CAF50))),
                      Text('Medio', style: TextStyle(fontSize: 11, color: Color(0xFFFF9800))),
                      Text('Alto', style: TextStyle(fontSize: 11, color: Color(0xFFF44336))),
                    ],
                  ),
                ],
              ),
            ),

            // ── Horas de sueño ─────────────────────────────────────────
            SeccionCard(
              icon: Icons.bedtime,
              title: 'Horas de sueño',
              child: Column(
                children: [
                  Text(
                    '${_horasSueno.toStringAsFixed(1)} h',
                    style: const TextStyle(
                        fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  Slider(
                    value: _horasSueno,
                    min: 0,
                    max: 12,
                    divisions: 24,
                    activeColor: Colors.pink,
                    label: '${_horasSueno.toStringAsFixed(1)} h',
                    onChanged: (v) => setState(() => _horasSueno = v),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('0 h', style: TextStyle(fontSize: 11, color: Colors.grey)),
                      Text('6 h', style: TextStyle(fontSize: 11, color: Colors.grey)),
                      Text('12 h', style: TextStyle(fontSize: 11, color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),

            // ── Tomas de lactancia ─────────────────────────────────────
            // Solo se muestra si el tipo de alimentación incluye pecho
            if (widget.datosBebe['tipo_alimentacion'] == 'pecho' ||
                widget.datosBebe['tipo_alimentacion'] == 'mixto')
              SeccionCard(
                icon: Icons.child_care,
                title: 'Tomas de lactancia hoy',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => setState(() {
                        if (_tomasLactancia > 0) _tomasLactancia--;
                      }),
                      icon: const Icon(Icons.remove_circle_outline,
                          color: Colors.pink, size: 36),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        '$_tomasLactancia',
                        style: const TextStyle(
                            fontSize: 38, fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      onPressed: () =>
                          setState(() => _tomasLactancia++),
                      icon: const Icon(Icons.add_circle_outline,
                          color: Colors.pink, size: 36),
                    ),
                  ],
                ),
              ),

            // ── Peso del bebé ──────────────────────────────────────────
            SeccionCard(
              icon: Icons.monitor_weight,
              title: 'Peso del bebé (kg)',
              child: TextField(
                controller: _pesoBebeCtrl,
                keyboardType: const TextInputType.numberWithOptions(
                    decimal: true),
                decoration: InputDecoration(
                  hintText: widget.datosBebe['peso_al_nacer'] != null
                      ? 'Al nacer: ${widget.datosBebe['peso_al_nacer']} kg'
                      : 'Ejemplo: 4.2 kg',
                  suffixText: 'kg',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 16, horizontal: 16),
                ),
              ),
            ),

            // ── Síntomas postparto ─────────────────────────────────────
            SeccionCard(
              icon: Icons.medical_services,
              title: 'Síntomas de hoy',
              child: Wrap(
                spacing: 8,
                runSpacing: 4,
                children: _sintomasPostparto.map((s) {
                  final sel = _sintomasSeleccionados.contains(s);
                  final esGrave = _sintomasGraves.contains(s);
                  return FilterChip(
                    label: Text(s),
                    selected: sel,
                    selectedColor: esGrave
                        ? Colors.orange.shade100
                        : Colors.pink.shade100,
                    checkmarkColor:
                        esGrave ? Colors.orange : Colors.pink,
                    avatar: esGrave
                        ? Icon(Icons.warning_amber_rounded,
                            size: 14,
                            color: sel ? Colors.orange : Colors.grey.shade400)
                        : null,
                    onSelected: (v) => setState(() => v
                        ? _sintomasSeleccionados.add(s)
                        : _sintomasSeleccionados.remove(s)),
                  );
                }).toList(),
              ),
            ),

            // ── Notas ──────────────────────────────────────────────────
            SeccionCard(
              icon: Icons.notes,
              title: 'Notas personales (opcional)',
              child: TextField(
                controller: _notasCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: '¿Algo que quieras recordar de hoy?',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
              ),
            ),

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: _guardar,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                    horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Guardar Registro'),
            ),
          ],
        ),
      ),
    );
  }
}