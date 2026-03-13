import 'package:flutter/material.dart';

/// Tarjeta de sección con ícono y título.
/// Compartida por RegistroEmbarazoScreen y RegistroPostpartoScreen.
class SeccionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget child;

  const SeccionCard({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(subtitle!, style: const TextStyle(fontSize: 11)),
          ],
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

/// Botón emoji para la selección de estado de ánimo.
/// Se anima suavemente al seleccionarse.
class EmojiSelector extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onChanged;

  const EmojiSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  static const _emojis = {5: '😄', 4: '🙂', 3: '😐', 2: '😟', 1: '😢'};
  static const _labels = {
    5: 'Muy bien',
    4: 'Bien',
    3: 'Regular',
    2: 'Triste',
    1: 'Muy mal',
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [5, 4, 3, 2, 1].map((v) {
            final isSelected = selected == v;
            return GestureDetector(
              onTap: () => onChanged(v),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.pink.shade100 : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: isSelected
                      ? Border.all(color: Colors.pink, width: 1.5)
                      : null,
                ),
                child: Text(_emojis[v]!, style: const TextStyle(fontSize: 28)),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 6),
        Text(
          _labels[selected] ?? '',
          style: TextStyle(
            color: Colors.pink.shade400,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  BannerMadre — encabezado degradado con info contextual
// ─────────────────────────────────────────────────────────────────────────────
class BannerMadre extends StatelessWidget {
  final String emoji;
  final String nombre;
  final String? linea2;
  final String? linea3;

  const BannerMadre({
    super.key,
    required this.emoji,
    required this.nombre,
    this.linea2,
    this.linea3,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Text(emoji, style: const TextStyle(fontSize: 36)),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hola, $nombre 💕',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (linea2 != null)
                Text(
                  linea2!,
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
              if (linea3 != null)
                Text(
                  linea3!,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Contador — botones +/− para valores enteros
// ─────────────────────────────────────────────────────────────────────────────
class Contador extends StatelessWidget {
  final int valor;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final String unidad;
  final Color color;

  const Contador({
    super.key,
    required this.valor,
    required this.onIncrement,
    required this.onDecrement,
    required this.unidad,
    this.color = Colors.pink,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onDecrement,
          icon: Icon(Icons.remove_circle_outline, color: color, size: 36),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Text(
                '$valor',
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                unidad,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: onIncrement,
          icon: Icon(Icons.add_circle_outline, color: color, size: 36),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  SliderConEtiqueta
// ─────────────────────────────────────────────────────────────────────────────
class SliderConEtiqueta extends StatelessWidget {
  final double valor;
  final double min;
  final double max;
  final int divisiones;
  final String etiqueta;
  final Color color;
  final ValueChanged<double> onChanged;
  final List<String>? extremos; // ['0 h', '6 h', '12 h']

  const SliderConEtiqueta({
    super.key,
    required this.valor,
    required this.min,
    required this.max,
    required this.divisiones,
    required this.etiqueta,
    required this.color,
    required this.onChanged,
    this.extremos,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          etiqueta,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Slider(
          value: valor,
          min: min,
          max: max,
          divisions: divisiones,
          activeColor: color,
          label: etiqueta,
          onChanged: onChanged,
        ),
        if (extremos != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: extremos!
                .map(
                  (e) => Text(
                    e,
                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  SwitchFila
// ─────────────────────────────────────────────────────────────────────────────
class SwitchFila extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SwitchFila({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text(label, style: const TextStyle(fontSize: 14))),
        Switch(
          value: value,
          activeThumbColor: Colors.pink,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
