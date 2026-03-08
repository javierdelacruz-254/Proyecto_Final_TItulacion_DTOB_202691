import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lactaamor/features/seguimiento_emocional/view/widgets/bienestar_widget.dart';
import 'historial_seguimiento_screen.dart';

/// Formulario de registro diario para madre embarazada.
/// Recibe [embarazoActual] del perfil para mostrar información
/// contextual (semana de gestación, etc.).
class RegistroEmbarazoScreen extends StatefulWidget {
  final String nombreMadre;
  final Map<String, dynamic> embarazoActual;

  const RegistroEmbarazoScreen({
    super.key,
    required this.nombreMadre,
    required this.embarazoActual,
  });

  @override
  State<RegistroEmbarazoScreen> createState() =>
      _RegistroEmbarazoScreenState();
}

class _RegistroEmbarazoScreenState extends State<RegistroEmbarazoScreen> {
  final DateTime _hoy = DateTime.now();

  int _estadoAnimo = 3;
  bool _vitaminasTomadas = false;
  final List<String> _sintomasSeleccionados = [];
  final TextEditingController _pesoCtrl = TextEditingController();

  static const List<String> _sintomas = [
    'Náuseas',
    'Dolor de espalda',
    'Fatiga',
    'Acidez',
    'Hinchazón',
    'Calambres',
  ];

  /// Calcula la semana de gestación a partir de la última menstruación.
  int? get _semanaGestacion {
    final raw = widget.embarazoActual['ultima_mestruacion'] as String?;
    if (raw == null) return null;
    try {
      final fum = DateTime.parse(raw);
      final dias = _hoy.difference(fum).inDays;
      return (dias / 7).floor();
    } catch (_) {
      return null;
    }
  }

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
      'tipo': 'embarazo',
      'fecha': Timestamp.fromDate(DateTime(_hoy.year, _hoy.month, _hoy.day)),
      'estado_animo': _estadoAnimo,
      'sintomas': _sintomasSeleccionados,
      'vitaminas': _vitaminasTomadas,
      'peso': _pesoCtrl.text.trim(),
      'updated_at': Timestamp.now(),
    });

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Registro guardado correctamente 💙')),
    );
  }

  @override
  void dispose() {
    _pesoCtrl.dispose();
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
            // ── Banner de bienvenida ───────────────────────────────────
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
                  const Text('🤱', style: TextStyle(fontSize: 36)),
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
                      if (semana != null)
                        Text(
                          'Semana $semana de gestación',
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 13),
                        ),
                      Text(
                        '${_hoy.day}/${_hoy.month}/${_hoy.year}',
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

            // ── Síntomas ───────────────────────────────────────────────
            SeccionCard(
              icon: Icons.medical_services,
              title: 'Síntomas de hoy',
              child: Wrap(
                spacing: 8,
                runSpacing: 4,
                children: _sintomas.map((s) {
                  final sel = _sintomasSeleccionados.contains(s);
                  return FilterChip(
                    label: Text(s),
                    selected: sel,
                    selectedColor: Colors.pink.shade100,
                    onSelected: (v) => setState(() =>
                        v ? _sintomasSeleccionados.add(s)
                          : _sintomasSeleccionados.remove(s)),
                  );
                }).toList(),
              ),
            ),

            // ── Vitaminas ──────────────────────────────────────────────
            SeccionCard(
              icon: Icons.medication,
              title: 'Vitaminas prenatales',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('¿Las tomaste hoy?'),
                  Switch(
                    value: _vitaminasTomadas,
                    activeColor: Colors.pink,
                    onChanged: (v) =>
                        setState(() => _vitaminasTomadas = v),
                  ),
                ],
              ),
            ),

            // ── Peso actual ────────────────────────────────────────────
            SeccionCard(
              icon: Icons.monitor_weight,
              title: 'Peso actual',
              child: TextField(
                controller: _pesoCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: widget.embarazoActual['peso_actual'] != null
                      ? 'Último: ${widget.embarazoActual['peso_actual']} kg'
                      : 'Ejemplo: 65 kg',
                  suffixText: 'kg',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 16, horizontal: 16),
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