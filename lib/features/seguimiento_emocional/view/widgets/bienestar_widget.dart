import 'package:flutter/material.dart';

/// Tarjeta de sección con ícono y título.
/// Compartida por RegistroEmbarazoScreen y RegistroPostpartoScreen.
class SeccionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;

  const SeccionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.pink),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

/// Botón emoji para la selección de estado de ánimo.
/// Se anima suavemente al seleccionarse.
class EmojiButton extends StatelessWidget {
  final int valor;
  final bool isSelected;
  final VoidCallback onTap;

  /// Mapa de valor → emoji
  static const _emojis = {
    5: '😄',
    4: '🙂',
    3: '😐',
    2: '😟',
    1: '😢',
  };

  const EmojiButton({
    super.key,
    required this.valor,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
        child: Text(
          _emojis[valor] ?? '😐',
          style: const TextStyle(fontSize: 28),
        ),
      ),
    );
  }
}