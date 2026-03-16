import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lactaamor/features/seguimiento_emocional/view/alerta_whatsapp_service.dart';
import 'package:lactaamor/features/seguimiento_emocional/view/widgets/bienestar_widget.dart';

class RegistroPostpartoScreen extends StatefulWidget {
  final String nombreMadre;
  final Map<String, dynamic> datosBebe;
  final VoidCallback? onGuardado;

  const RegistroPostpartoScreen({
    super.key,
    required this.nombreMadre,
    required this.datosBebe,
    this.onGuardado,
  });

  @override
  State<RegistroPostpartoScreen> createState() =>
      _RegistroPostpartoScreenState();
}

class _RegistroPostpartoScreenState extends State<RegistroPostpartoScreen> {
  final DateTime _hoy = DateTime.now();

  // ────────────────── DATOS DE LA MADRE ───────────────────────────────────

  int _estadoAnimo = 3;
  int _nivelEstres = 2;
  double _horasSuenoMadre = 6;
  final List<String> _sintomasSeleccionados = [];

  final TextEditingController _presionSisCtrl = TextEditingController();
  final TextEditingController _presionDiaCtrl = TextEditingController();
  final TextEditingController _notasCtrl = TextEditingController();

  static const List<String> _sintomasMadre = [
    'Dolor en puntos de sutura',
    'Sangrado abundante',
    'Fiebre',
    'Tristeza persistente',
    'Ansiedad / pánico',
    'Fatiga extrema',
    'Dolor de cabeza intenso',
    'Problemas con lactancia',
    'Dolor al orinar',
    'Enrojecimiento / inflamación',
  ];

  static const Set<String> _sintomasGraves = {
    'Sangrado abundante',
    'Fiebre',
    'Tristeza persistente',
    'Ansiedad / pánico',
    'Dolor de cabeza intenso',
    'Dolor al orinar',
  };

  // ────────────────── LACTANCIA ────────────────────────────────────────────

  int _tomasLactancia = 0;

  // ────────────────── DATOS DEL BEBÉ ──────────────────────────────────────

  final TextEditingController _pesoBebCtrl = TextEditingController();
  final TextEditingController _temperaturaBebCtrl = TextEditingController();
  int _panalesMojados = 0;
  int _deposiciones = 0;
  double _horasSuenoBebe = 14;

  // Color deposición — mapa de color a descripción
  String _colorDeposicion = 'Amarillo mostaza'; // valor por defecto normal
  static const List<String> _coloresDeposicion = [
    'Amarillo mostaza', // normal lactancia
    'Verde oliva', // normal
    'Café/marrón', // normal
    'Negro/verde oscuro', // meconio (primeros días)
    'Blanco/grisáceo', // alerta
    'Rojo / con sangre', // alerta
  ];
  static const Set<String> _coloresAlerta = {
    'Blanco/grisáceo',
    'Rojo / con sangre',
  };

  // ── Alertas ──────────────────────────────────────────────────────────────

  bool get _hayAlertaMadre {
    if (_estadoAnimo <= 2) return true;
    if (_sintomasSeleccionados.any(_sintomasGraves.contains)) return true;
    final sis = int.tryParse(_presionSisCtrl.text.trim()) ?? 0;
    if (sis >= 140) return true;
    return false;
  }

  bool get _hayAlertaBebe {
    final temp = double.tryParse(_temperaturaBebCtrl.text.trim()) ?? 0;
    if (temp > 38.0 || temp < 36.0 && temp > 0) return true;
    if (_coloresAlerta.contains(_colorDeposicion)) return true;
    return false;
  }

  bool get _hayAlerta => _hayAlertaMadre || _hayAlertaBebe;

  // ── Datos del bebé calculados ────────────────────────────────────────────

  String get _edadBebe {
    final raw = widget.datosBebe['fecha_nacimiento_bebe'];
    DateTime? nac;
    if (raw is Timestamp) {
      nac = raw.toDate();
    } else if (raw is String) {
      try {
        nac = DateTime.parse(raw);
      } catch (_) {}
    }
    if (nac == null) return '';
    final dias = _hoy.difference(nac).inDays;
    if (dias < 7) return '$dias días';
    if (dias < 56) return '${(dias / 7).floor()} semanas';
    return '${(dias / 30.44).floor()} meses';
  }

  String get _iconoBebe =>
      widget.datosBebe['sexo_bebe'] == 'masculino' ? '👦' : '👧';

  bool get _esLactanciaMaterna {
    final tipo = widget.datosBebe['tipo_alimentacion'] as String? ?? 'pecho';
    return tipo == 'pecho' || tipo == 'mixto';
  }

  // ── Guardar ──────────────────────────────────────────────────────────────

  Future<void> _guardar() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final fechaKey = '${_hoy.year}-${_hoy.month}-${_hoy.day}';
    final sis = int.tryParse(_presionSisCtrl.text.trim());
    final dia = int.tryParse(_presionDiaCtrl.text.trim());
    final temp = double.tryParse(_temperaturaBebCtrl.text.trim());

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('registros_diarios')
        .doc(fechaKey)
        .set({
          'tipo': 'postparto',
          'fecha': Timestamp.fromDate(
            DateTime(_hoy.year, _hoy.month, _hoy.day),
          ),
          // Madre - emocional
          'estado_animo': _estadoAnimo,
          'nivel_estres': _nivelEstres,
          // Madre - físico
          'horas_sueno_madre': _horasSuenoMadre,
          'sintomas': _sintomasSeleccionados,
          'presion_sistolica': ?sis,
          'presion_diastolica': ?dia,
          // Lactancia
          if (_esLactanciaMaterna) 'tomas_lactancia': _tomasLactancia,
          // Bebé
          if (_pesoBebCtrl.text.trim().isNotEmpty)
            'peso_bebe': _pesoBebCtrl.text.trim(),
          'temperatura_bebe': ?temp,
          'panales_mojados': _panalesMojados,
          'deposiciones': _deposiciones,
          'color_deposicion': _colorDeposicion,
          'horas_sueno_bebe': _horasSuenoBebe,
          // Alertas
          'hay_alerta': _hayAlerta,
          'hay_alerta_madre': _hayAlertaMadre,
          'hay_alerta_bebe': _hayAlertaBebe,
          // Notas
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

  Future<void> _enviarAlertaWhatsApp(String uid) async {
    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();
      final celular = userDoc.data()?['celular_confianza'] as String? ?? '';
      final nombre = userDoc.data()?['fullname'] as String? ?? 'La usuaria';

      if (celular.isEmpty) {
        debugPrint('[Alerta] Sin número de confianza');
        return;
      }

      await AlertaWhatsAppService.enviarAlertaPostparto(
        telefono: celular,
        nombreMadre: nombre,
        estadoAnimo: _estadoAnimo,
        sintomasGraves: _sintomasSeleccionados
            .where(_sintomasGraves.contains)
            .toList(),
        hayAlertaMadre: _hayAlertaMadre,
        hayAlertaBebe: _hayAlertaBebe,
        temperaturaBebe: _temperaturaBebCtrl.text.trim(),
        colorDeposicion: _colorDeposicion,
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(Icons.warning_amber_rounded, size: 28),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                _hayAlertaMadre && _hayAlertaBebe
                    ? 'Alertas para ti y el bebé'
                    : _hayAlertaMadre
                    ? 'Alerta sobre tu salud'
                    : 'Alerta sobre el bebé',
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_hayAlertaMadre)
              const Text(
                '🩺 Detectamos señales en tu salud que podrían requerir atención médica.',
              ),
            if (_hayAlertaBebe) ...[
              const SizedBox(height: 8),
              const Text(
                '👶 Hay indicadores del bebé que deberías revisar con tu pediatra.',
              ),
            ],
            const SizedBox(height: 12),
            const Text('📱 Se envió un mensaje a tu contacto de confianza.'),
          ],
        ),
        actions: [
          ElevatedButton.icon(
            icon: const Icon(Icons.bar_chart),
            label: const Text('Ver mi historial'),

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
    _pesoBebCtrl.dispose();
    _temperaturaBebCtrl.dispose();
    _notasCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Bienestar · Postparto'),
        actions: [
          IconButton(
            tooltip: 'Ver historial',
            icon: const Icon(Icons.bar_chart),
            onPressed: _irAlHistorial,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom + 100,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BannerMadre(
              emoji: '💕',
              nombre: widget.nombreMadre,
              linea2: _edadBebe.isNotEmpty
                  ? '$_iconoBebe Tu bebé tiene $_edadBebe'
                  : null,
              linea3: '${_hoy.day}/${_hoy.month}/${_hoy.year}',
            ),

            //  SECCIÓN MADRE
            _SectionHeader(label: '🩺 Tu bienestar'),

            // Estado de ánimo
            SeccionCard(
              icon: Icons.favorite,
              title: '¿Cómo te sientes hoy?',
              child: EmojiSelector(
                selected: _estadoAnimo,
                onChanged: (v) => setState(() => _estadoAnimo = v),
              ),
            ),

            // Estrés
            SeccionCard(
              icon: Icons.bolt,
              title: 'Nivel de estrés',
              child: _SliderEstres(
                valor: _nivelEstres,
                onChanged: (v) => setState(() => _nivelEstres = v),
              ),
            ),

            // Sueño madre
            SeccionCard(
              icon: Icons.bedtime,
              title: 'Tus horas de sueño',
              subtitle: 'El sueño fragmentado es normal en postparto',
              child: SliderConEtiqueta(
                valor: _horasSuenoMadre,
                min: 0,
                max: 12,
                divisiones: 24,
                etiqueta: '${_horasSuenoMadre.toStringAsFixed(1)} h',
                color: Colors.indigo,
                onChanged: (v) => setState(() => _horasSuenoMadre = v),
                extremos: const ['0 h', '6 h', '12 h'],
              ),
            ),

            // Presión arterial
            SeccionCard(
              icon: Icons.monitor_heart,
              title: 'Presión arterial',
              subtitle: 'Importante en las primeras 6 semanas postparto',
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
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      '/',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Síntomas madre
            SeccionCard(
              icon: Icons.medical_services,
              title: 'Síntomas de hoy',
              subtitle: 'Los marcados con ⚠️ generan alerta automática',
              child: Wrap(
                spacing: 8,
                runSpacing: 4,
                children: _sintomasMadre.map((s) {
                  final sel = _sintomasSeleccionados.contains(s);
                  final grave = _sintomasGraves.contains(s);
                  return FilterChip(
                    label: Text('${grave ? '⚠️ ' : ''}$s'),
                    selected: sel,
                    selectedColor: grave
                        ? Colors.red.shade100
                        : Colors.pink.shade100,
                    checkmarkColor: grave ? Colors.red : Colors.pink,
                    onSelected: (v) => setState(
                      () => v
                          ? _sintomasSeleccionados.add(s)
                          : _sintomasSeleccionados.remove(s),
                    ),
                  );
                }).toList(),
              ),
            ),

            //  SECCIÓN LACTANCIA
            if (_esLactanciaMaterna) ...[
              _SectionHeader(label: '🤱 Lactancia'),
              SeccionCard(
                icon: Icons.child_care,
                title: 'Tomas de hoy',
                subtitle: 'Recomendado: 8–12 tomas en recién nacido',
                child: Contador(
                  valor: _tomasLactancia,
                  onIncrement: () => setState(() => _tomasLactancia++),
                  onDecrement: () => setState(() {
                    if (_tomasLactancia > 0) _tomasLactancia--;
                  }),
                  unidad: 'tomas',
                ),
              ),
            ],

            //  SECCIÓN BEBÉ
            _SectionHeader(label: '$_iconoBebe Seguimiento del bebé'),

            // Peso bebé
            SeccionCard(
              icon: Icons.monitor_weight,
              title: 'Peso del bebé',
              subtitle: widget.datosBebe['peso_al_nacer'] != null
                  ? 'Al nacer: ${widget.datosBebe['peso_al_nacer']} kg'
                  : null,
              child: TextField(
                controller: _pesoBebCtrl,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  hintText: 'Ejemplo: 4.2',
                  suffixText: 'kg',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                ),
              ),
            ),

            // Temperatura bebé
            SeccionCard(
              icon: Icons.thermostat,
              title: 'Temperatura del bebé',
              subtitle: '⚠️ Alerta si < 36°C o > 38°C',
              child: TextField(
                controller: _temperaturaBebCtrl,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  hintText: '36.5',
                  suffixText: '°C',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                ),
              ),
            ),

            // Sueño bebé
            SeccionCard(
              icon: Icons.crib,
              title: 'Horas de sueño del bebé',
              subtitle: 'Normal en recién nacidos: 14–17 h',
              child: SliderConEtiqueta(
                valor: _horasSuenoBebe,
                min: 0,
                max: 20,
                divisiones: 40,
                etiqueta: '${_horasSuenoBebe.toStringAsFixed(1)} h',
                color: Colors.deepPurple,
                onChanged: (v) => setState(() => _horasSuenoBebe = v),
                extremos: const ['0 h', '10 h', '20 h'],
              ),
            ),

            // Pañales y deposiciones
            SeccionCard(
              icon: Icons.baby_changing_station,
              title: 'Pañales y deposiciones',
              subtitle: 'Normal: 6–8 pañales mojados y 3–4 deposiciones/día',
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          'Pañales\nmojados',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        Contador(
                          valor: _panalesMojados,
                          onIncrement: () => setState(() => _panalesMojados++),
                          onDecrement: () => setState(() {
                            if (_panalesMojados > 0) _panalesMojados--;
                          }),
                          unidad: '',
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                  const VerticalDivider(width: 1),
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          'Deposi-\nciones',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        Contador(
                          valor: _deposiciones,
                          onIncrement: () => setState(() => _deposiciones++),
                          onDecrement: () => setState(() {
                            if (_deposiciones > 0) _deposiciones--;
                          }),
                          unidad: '',
                          color: Colors.brown,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Color de deposición
            SeccionCard(
              icon: Icons.color_lens,
              title: 'Color de deposición',
              subtitle:
                  'Blanco/grisáceo o con sangre requieren atención médica',
              child: DropdownButtonFormField<String>(
                initialValue: _colorDeposicion,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
                items: _coloresDeposicion.map((c) {
                  final esAlerta = _coloresAlerta.contains(c);
                  return DropdownMenuItem(
                    value: c,
                    child: Text('${esAlerta ? '⚠️ ' : '✅ '}$c'),
                  );
                }).toList(),
                onChanged: (v) =>
                    setState(() => _colorDeposicion = v ?? _colorDeposicion),
              ),
            ),

            // Notas
            SeccionCard(
              icon: Icons.notes,
              title: 'Notas del día',
              child: TextField(
                controller: _notasCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: '¿Algo que quieras anotar sobre ti o el bebé?',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
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
                  label: const Text(
                    'Guardar y ver historial',
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
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

//  Widgets locales

class _SectionHeader extends StatelessWidget {
  final String label;
  const _SectionHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 16, 4),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color(0xFFE91E63),
        ),
      ),
    );
  }
}

class _SliderEstres extends StatelessWidget {
  final int valor;
  final ValueChanged<int> onChanged;

  const _SliderEstres({required this.valor, required this.onChanged});

  static const _labels = {1: 'Bajo 🟢', 2: 'Medio 🟡', 3: 'Alto 🔴'};
  static const _colores = {
    1: Color(0xFF4CAF50),
    2: Color(0xFFFF9800),
    3: Color(0xFFF44336),
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          _labels[valor]!,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: _colores[valor],
          ),
        ),
        Slider(
          value: valor.toDouble(),
          min: 1,
          max: 3,
          divisions: 2,
          activeColor: _colores[valor],
          onChanged: (v) => onChanged(v.round()),
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Bajo',
              style: TextStyle(fontSize: 11, color: Color(0xFF4CAF50)),
            ),
            Text(
              'Medio',
              style: TextStyle(fontSize: 11, color: Color(0xFFFF9800)),
            ),
            Text(
              'Alto',
              style: TextStyle(fontSize: 11, color: Color(0xFFF44336)),
            ),
          ],
        ),
      ],
    );
  }
}
