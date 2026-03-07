import 'package:flutter/material.dart';
import 'package:icon_checkbox/icon_checkbox.dart';
import 'package:lactaamor/core/theme/app_colors.dart';
import 'package:lactaamor/features/register/models/datos_bebe_model.dart';

class SexoBebeSelector extends StatefulWidget {
  final SexoBebe? value;
  final Function(SexoBebe?) onChanged;
  final String? Function(SexoBebe?)? validator;

  const SexoBebeSelector({
    super.key,
    required this.value,
    required this.onChanged,
    this.validator,
  });

  @override
  State<SexoBebeSelector> createState() => _SexoBebeSelectorState();
}

class _SexoBebeSelectorState extends State<SexoBebeSelector> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return FormField<SexoBebe>(
      initialValue: widget.value,
      validator: widget.validator,
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sexo del bebé",
              style: Theme.of(context).textTheme.labelLarge,
            ),

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
                        checkedIcon: Icons.male,
                        uncheckedIcon: Icons.male_outlined,
                        value: widget.value == SexoBebe.masculino,
                        onChanged: (val) {
                          final newValue = val ? SexoBebe.masculino : null;

                          widget.onChanged(newValue);
                          state.didChange(newValue);
                        },
                      ),

                      const SizedBox(width: 6),

                      const Text("Masculino"),
                    ],
                  ),

                  const SizedBox(width: 30),

                  Row(
                    children: [
                      IconCheckbox(
                        checkedIcon: Icons.female,
                        uncheckedIcon: Icons.female_outlined,
                        checkColor: Colors.pinkAccent,
                        value: widget.value == SexoBebe.femenino,
                        onChanged: (val) {
                          final newValue = val ? SexoBebe.femenino : null;

                          widget.onChanged(newValue);
                          state.didChange(newValue);
                        },
                      ),

                      const SizedBox(width: 6),

                      const Text("Femenino"),
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
