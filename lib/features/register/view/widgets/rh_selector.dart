import 'package:flutter/material.dart';
import 'package:icon_checkbox/icon_checkbox.dart';
import 'package:lactaamor/core/theme/app_colors.dart';
import 'package:lactaamor/features/register/models/perfil_materno_model.dart';

class RhSelector extends StatefulWidget {
  final RhSangre? value;
  final Function(RhSangre?) onChanged;
  final String? Function(RhSangre?)? validator;

  const RhSelector({
    super.key,
    required this.value,
    required this.onChanged,
    this.validator,
  });

  @override
  State<RhSelector> createState() => _RhSelectorState();
}

class _RhSelectorState extends State<RhSelector> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return FormField<RhSangre>(
      initialValue: widget.value,
      validator: widget.validator,
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Factor RH", style: Theme.of(context).textTheme.labelLarge),

            const SizedBox(height: 8),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF1C2B2E)
                    : AppColors.secondary.withOpacity(0.25),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      IconCheckbox(
                        checkedIcon: Icons.add_circle,
                        uncheckedIcon: Icons.add_circle_outline,
                        value: widget.value == RhSangre.positivo,
                        onChanged: (val) {
                          final newValue = val ? RhSangre.positivo : null;

                          widget.onChanged(newValue);
                          state.didChange(newValue);
                        },
                      ),

                      const SizedBox(width: 6),

                      const Text("RH +"),
                    ],
                  ),

                  const SizedBox(width: 30),

                  /// NEGATIVO
                  Row(
                    children: [
                      IconCheckbox(
                        checkedIcon: Icons.remove_circle,
                        uncheckedIcon: Icons.remove_circle_outline,
                        value: widget.value == RhSangre.negativo,
                        onChanged: (val) {
                          final newValue = val ? RhSangre.negativo : null;

                          widget.onChanged(newValue);
                          state.didChange(newValue);
                        },
                      ),

                      const SizedBox(width: 6),

                      const Text("RH -"),
                    ],
                  ),
                ],
              ),
            ),

            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  state.errorText!,
                  style: const TextStyle(color: AppColors.error, fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }
}
