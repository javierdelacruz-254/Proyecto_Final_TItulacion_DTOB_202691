import 'package:flutter/material.dart';
import 'package:lactaamor/features/register/models/datos_bebe_model.dart';

class SexoBebeSelector extends StatelessWidget {
  final SexoBebe? value;
  final ValueChanged<SexoBebe> onChanged;

  const SexoBebeSelector({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildOption(
          context,
          icon: Icons.male,
          selected: value == SexoBebe.masculino,
          onTap: () => onChanged(SexoBebe.masculino),
        ),
        const SizedBox(width: 16),
        _buildOption(
          context,
          icon: Icons.female,
          selected: value == SexoBebe.femenino,
          onTap: () => onChanged(SexoBebe.femenino),
        ),
      ],
    );
  }

  Widget _buildOption(
    BuildContext context, {
    required IconData icon,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: selected ? Theme.of(context).primaryColor : Colors.grey[200],
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(16),
        child: Icon(
          icon,
          color: selected ? Colors.white : Colors.grey[600],
          size: 32,
        ),
      ),
    );
  }
}
