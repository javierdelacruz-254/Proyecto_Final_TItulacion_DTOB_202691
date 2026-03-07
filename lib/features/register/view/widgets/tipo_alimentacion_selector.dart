import 'package:choice/choice.dart';
import 'package:flutter/material.dart';
import 'package:lactaamor/core/theme/app_colors.dart';
import 'package:lactaamor/features/register/models/datos_bebe_model.dart';

class TipoAlimentacionSelector extends StatefulWidget {
  final TipoAlimentacion? value;
  final Function(TipoAlimentacion?) onChanged;
  final String? Function(TipoAlimentacion?)? validator;

  const TipoAlimentacionSelector({
    super.key,
    required this.value,
    required this.onChanged,
    this.validator,
  });

  @override
  State<TipoAlimentacionSelector> createState() =>
      _TipoAlimentacionSelectorState();
}

class _TipoAlimentacionSelectorState extends State<TipoAlimentacionSelector> {
  TipoAlimentacion? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.value;
  }

  void setSelectedValue(TipoAlimentacion? value) {
    setState(() {
      selectedValue = value;
      widget.onChanged(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return FormField<TipoAlimentacion>(
      validator: widget.validator,
      builder: (FormFieldState<TipoAlimentacion> state) {
        final hasError = state.hasError;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tipo de lactancia",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              constraints: const BoxConstraints(minWidth: 320),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF1C2B2E)
                    : AppColors.secondary.withOpacity(0.25),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(width: 1.4, color: Colors.transparent),
              ),
              child: Choice<TipoAlimentacion>.inline(
                clearable: false,
                value: ChoiceSingle.value(selectedValue),
                onChanged: ChoiceSingle.onChanged((value) {
                  setSelectedValue(value);
                  state.didChange(value);
                }),
                itemCount: TipoAlimentacion.values.length,
                itemBuilder: (stateChoice, i) {
                  final item = TipoAlimentacion.values[i];
                  final selected = stateChoice.selected(item);

                  return ChoiceChip(
                    selected: selected,
                    onSelected: stateChoice.onSelected(item),
                    label: Text(
                      item.name.toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: selected
                            ? Colors.white
                            : (isDark ? Colors.white : AppColors.textPrimary),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    selectedColor: AppColors.primary,
                    backgroundColor: isDark
                        ? const Color(0xFF24373B)
                        : AppColors.primaryLight.withOpacity(.35),
                    side: BorderSide(
                      color: selected ? AppColors.primary : Colors.transparent,
                    ),
                  );
                },
                listBuilder: ChoiceList.createWrapped(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 4),
                ),
              ),
            ),

            if (hasError)
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 4),
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
