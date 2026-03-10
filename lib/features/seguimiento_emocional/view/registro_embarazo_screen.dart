import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lactaamor/features/seguimiento_emocional/view/alerta_whatsapp_service.dart';
import 'package:lactaamor/features/seguimiento_emocional/view/widgets/bienestar_widget.dart';

class RegistroEmbarazoScreen extends StatefulWidget {
  final String nombreMadre;
  final Map<String, dynamic> embarazoActual;
  final Map<String, dynamic> perfilMedico;
  final VoidCallback? onGuardado;

  const RegistroEmbarazoScreen({
    super.key,
    required this.nombreMadre,
    required this.embarazoActual,
    required this.perfilMedico,
    this.onGuardado,
  });

  @override
  State<RegistroEmbarazoScreen> createState() =>
      _RegistroEmbarazoScreenState();
}

class _RegistroEmbarazoScreenState extends State<RegistroEmbarazoScreen> {
  final DateTime _hoy = DateTime.now();

  // ── Bienestar emocional ───────────────────────────────────────────────────
  int _estadoAnimo = 3;

  // ── Síntomas ──────────────────────────────────────────────────────────────
  final List<String> _sintomasSeleccionados = [];
  static const List<String> _sintomas = [
    'Náuseas',
    'Vómitos',
    'Dolor de espalda',
    'Fatiga',
    'Acidez',
    'Hinchazón',
    'Calambres',
    'Dolor de cabeza',
    'Visión borrosa',
    'Sangrado vaginal',
  ];
  static const Set<String> _sintomasGraves = {
    'Sangrado vaginal',
    'Visión borrosa',
    'Dolor de cabeza',
  };

  // ── Vitaminas / suplementos ───────────────────────────────────────────────
  bool _vitaminasTomadas = false;
  bool _hierroTomado = false;

  // ── Signos vitales ────────────────────────────────────────────────────────
  final TextEditingController _presionSisCtrl = TextEditingController();
  final TextEditingController _presionDiaCtrl = TextEditingController();

  // ── Sueño e hidratación ───────────────────────────────────────────────────
  double _horasSueno = 7;
  int _vasosAgua = 0;

  // ── Movimientos fetales ───────────────────────────────────────────────────
  int _movimientosFetales = 0;

  // ── Peso ──────────────────────────────────────────────────────────────────
  final TextEditingController _pesoCtrl = TextEditingController();

  // ── Notas ─────────────────────────────────────────────────────────────────
  final TextEditingController _notasCtrl = TextEditingController();

  // ── Cálculos derivados ────────────────────────────────────────────────────
  int? get _semanaGestacion {
    final raw = widget.embarazoActual['ultima_mestruacion'] as String?;
    if (raw == null) return null;
    try {
      return (_hoy.difference(DateTime.parse(raw)).inDays / 7).floor();
    } catch (_) {
      return null;
    }
  }

  bool get _tieneHipertension =>
      widget.perfilMedico['hipertension'] as bool? ?? false;

  bool get _hayAlerta {
    if (_estadoAnimo <= 2) return true;
    if (_sintomasSeleccionados.any(_sintomasGraves.contains)) return true;
    final sis = int.tryParse(_presionSisCtrl.text.trim()) ?? 0;
    if (sis >= 140) return true;
    final semana = _semanaGestacion ?? 0;
    if (semana >= 28 && _movimientosFetales > 0 && _movimientosFetales < 10) {
      return true;
    }
    return false;
  }

  // ── Guardar ───────────────────────────────────────────────────────────────
  Future<void> _guardar() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final fechaKey = '${_hoy.year}-${_hoy.month}-${_hoy.day}';
    final sis = int.tryParse(_presionSisCtrl.text.trim());
    final dia = int.tryParse(_presionDiaCtrl.text.trim());

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('registros_diarios')
        .doc(fechaKey)
        .set({
      'tipo': 'embarazo',
      'fecha': Timestamp.fromDate(DateTime(_hoy.year, _hoy.month, _hoy.day)),
      'estado_animo': _estadoAnimo,
      'sintomas': _sintomasSeleccionados,
      'vitaminas_prenatales': _vitaminasTomadas,
      'hierro': _hierroTomado,
      if (sis != null) 'presion_sistolica': sis,
      if (dia != null) 'presion_diastolica': dia,
      'horas_sueno': _horasSueno,
      'vasos_agua': _vasosAgua,
      'movimientos_fetales': _movimientosFetales,
      if (_pesoCtrl.text.trim().isNotEmpty) 'peso': _pesoCtrl.text.trim(),
      if (_semanaGestacion != null) 'semana_gestacion': _semanaGestacion,
      'hay_alerta': _hayAlerta,
      'notas': _notasCtrl.text.trim(),
      'updated_at': Timestamp.now(),
    });

    if (!mounted) return;

    if (_hayAlerta) {
      await _enviarAlertaWhatsApp(uid);
      _mostrarDialogoAlerta();
    } else {
      _irAlHistorial();
    }
  }

  /// Envía alerta de WhatsApp directo via UltraMsg al número de confianza.
  Future<void> _enviarAlertaWhatsApp(String uid) async {
    try {
      // Leer número de confianza del perfil
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();
      final celular = userDoc.data()?['celular_confianza'] as String? ?? '';
      final nombre  = userDoc.data()?['fullname'] as String? ?? 'La usuaria';

      if (celular.isEmpty) {
        debugPrint('[Alerta] Sin número de confianza');
        return;
      }

      await AlertaWhatsAppService.enviarAlertaEmbarazo(
        telefono:       celular,
        nombreMadre:    nombre,
        estadoAnimo:    _estadoAnimo,
        sintomasGraves: _sintomasSeleccionados
            .where(_sintomasGraves.contains)
            .toList(),
        presion: '${_presionSisCtrl.text.trim()}/${_presionDiaCtrl.text.trim()}',
        semanaGestacion: _semanaGestacion,
      );
    } catch (e) {
      debugPrint('[Alerta] Error enviando WhatsApp: $e');
    }
  }

  void _mostrarDialogoAlerta() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded,
                color: Colors.orange, size: 28),
            SizedBox(width: 8),
            Expanded(child: Text('Atención importante')),
          ],
        ),
        content: const Text(
          'Detectamos señales que podrían requerir atención médica.\n\n'
          '📱 Se envió un mensaje a tu contacto de confianza.\n\n'
          'Por favor consulta con tu médico o dirígete al centro de salud más cercano.',
        ),
        actions: [
          ElevatedButton.icon(
            icon: const Icon(Icons.bar_chart),
            label: const Text('Ver mi historial'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
              _irAlHistorial();
            },
          ),
        ],
      ),
    );
  }

  void _irAlHistorial() {
    widget.onGuardado?.call();
  }

  @override
  void dispose() {
    _presionSisCtrl.dispose();
    _presionDiaCtrl.dispose();
    _pesoCtrl.dispose();
    _notasCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final semana = _semanaGestacion;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
        title: const Text('Mi Bienestar · Embarazo'),
        actions: [
          IconButton(
            tooltip: 'Ver historial',
            icon: const Icon(Icons.bar_chart),
            onPressed: _irAlHistorial,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 40),
        child: Column(
          children: [
            BannerMadre(
              emoji: '🤱',
              nombre: widget.nombreMadre,
              linea2: semana != null ? 'Semana $semana de gestación' : null,
              linea3: '${_hoy.day}/${_hoy.month}/${_hoy.year}',
            ),

            // ── Estado de ánimo ──────────────────────────────────────────
            SeccionCard(
              icon: Icons.favorite,
              title: '¿Cómo te sientes hoy?',
              child: EmojiSelector(
                selected: _estadoAnimo,
                onChanged: (v) => setState(() => _estadoAnimo = v),
              ),
            ),

            // ── Síntomas ─────────────────────────────────────────────────
            SeccionCard(
              icon: Icons.medical_services,
              title: 'Síntomas de hoy',
              subtitle: 'Los marcados con ⚠️ generan alerta automática',
              child: Wrap(
                spacing: 8,
                runSpacing: 4,
                children: _sintomas.map((s) {
                  final sel = _sintomasSeleccionados.contains(s);
                  final grave = _sintomasGraves.contains(s);
                  return FilterChip(
                    label: Text('${grave ? '⚠️ ' : ''}$s'),
                    selected: sel,
                    selectedColor:
                        grave ? Colors.red.shade100 : Colors.pink.shade100,
                    checkmarkColor: grave ? Colors.red : Colors.pink,
                    onSelected: (v) => setState(() => v
                        ? _sintomasSeleccionados.add(s)
                        : _sintomasSeleccionados.remove(s)),
                  );
                }).toList(),
              ),
            ),

            // ── Presión arterial ─────────────────────────────────────────
            SeccionCard(
              icon: Icons.monitor_heart,
              title: 'Presión arterial',
              subtitle: _tieneHipertension
                  ? '⚠️ Tienes hipertensión registrada — registra diariamente'
                  : 'Registra si tu médico lo indica',
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _presionSisCtrl,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        labelText: 'Sistólica',
                        hintText: '120',
                        suffixText: 'mmHg',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text('/',
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _presionDiaCtrl,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        labelText: 'Diastólica',
                        hintText: '80',
                        suffixText: 'mmHg',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Movimientos fetales (desde semana 20) ────────────────────
            if ((semana ?? 0) >= 20)
              SeccionCard(
                icon: Icons.baby_changing_station,
                title: 'Movimientos fetales hoy',
                subtitle: (semana ?? 0) >= 28
                    ? 'Mínimo recomendado: 10 movimientos por día'
                    : 'Registra las patadas o movimientos que sientes',
                child: Contador(
                  valor: _movimientosFetales,
                  onIncrement: () =>
                      setState(() => _movimientosFetales++),
                  onDecrement: () => setState(() {
                    if (_movimientosFetales > 0) _movimientosFetales--;
                  }),
                  unidad: 'movimientos',
                ),
              ),

            // ── Sueño ────────────────────────────────────────────────────
            SeccionCard(
              icon: Icons.bedtime,
              title: 'Horas de sueño',
              subtitle: 'Recomendado: 8–10 h durante el embarazo',
              child: SliderConEtiqueta(
                valor: _horasSueno,
                min: 0,
                max: 12,
                divisiones: 24,
                etiqueta: '${_horasSueno.toStringAsFixed(1)} h',
                color: Colors.indigo,
                onChanged: (v) => setState(() => _horasSueno = v),
                extremos: const ['0 h', '6 h', '12 h'],
              ),
            ),

            // ── Hidratación ──────────────────────────────────────────────
            SeccionCard(
              icon: Icons.water_drop,
              title: 'Vasos de agua tomados',
              subtitle: 'Recomendado: 8–10 vasos al día',
              child: Contador(
                valor: _vasosAgua,
                onIncrement: () => setState(() => _vasosAgua++),
                onDecrement: () => setState(() {
                  if (_vasosAgua > 0) _vasosAgua--;
                }),
                unidad: 'vasos',
                color: Colors.blue,
              ),
            ),

            // ── Suplementos ──────────────────────────────────────────────
            SeccionCard(
              icon: Icons.medication,
              title: 'Suplementos de hoy',
              child: Column(
                children: [
                  SwitchFila(
                    label: '💊 Vitaminas prenatales',
                    value: _vitaminasTomadas,
                    onChanged: (v) =>
                        setState(() => _vitaminasTomadas = v),
                  ),
                  const SizedBox(height: 4),
                  SwitchFila(
                    label: '🩸 Hierro / Ácido fólico',
                    value: _hierroTomado,
                    onChanged: (v) => setState(() => _hierroTomado = v),
                  ),
                ],
              ),
            ),

            // ── Peso ─────────────────────────────────────────────────────
            SeccionCard(
              icon: Icons.monitor_weight,
              title: 'Peso actual',
              child: TextField(
                controller: _pesoCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: widget.embarazoActual['peso_actual'] != null
                      ? 'Último: ${widget.embarazoActual['peso_actual']} kg'
                      : 'Ejemplo: 68',
                  suffixText: 'kg',
                  border: const OutlineInputBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(12))),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 16, horizontal: 16),
                ),
              ),
            ),

            // ── Notas ────────────────────────────────────────────────────
            SeccionCard(
              icon: Icons.notes,
              title: 'Notas del día',
              child: TextField(
                controller: _notasCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText:
                      '¿Algo que quieras recordar o contarle a tu médico?',
                  border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(12))),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
              ),
            ),

            const SizedBox(height: 28),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _guardar,
                  icon: const Icon(Icons.save_alt),
                  label: const Text('Guardar y ver historial',
                      style: TextStyle(fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}