import 'package:choice/choice.dart';
import 'package:flutter/material.dart';
import 'package:lactaamor/core/theme/app_colors.dart';

class TipoSangreSelector extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const TipoSangreSelector({
    super.key,
    required this.controller,
    this.validator,
  });

  @override
  State<TipoSangreSelector> createState() => _TipoSangreSelectorState();
}

class _TipoSangreSelectorState extends State<TipoSangreSelector> {
  final List<String> bloodTypes = ["A", "B", "AB", "O"];

  String? seletedValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.controller.text.isNotEmpty) {
      seletedValue = widget.controller.text;
    }
  }

  void setSelectedValue(String? value) {
    setState(() {
      seletedValue = value;
      widget.controller.text = value ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return FormField<String>(
      validator: widget.validator,
      builder: (FormFieldState<String> state) {
        final hasError = state.hasError;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Grupo Sanguíneo",
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
              child: Choice<String>.inline(
                clearable: false,
                value: ChoiceSingle.value(seletedValue),
                onChanged: ChoiceSingle.onChanged((value) {
                  setSelectedValue(value);
                  state.didChange(value);
                }),
                itemCount: bloodTypes.length,
                itemBuilder: (stateChoice, i) {
                  final item = bloodTypes[i];
                  final selected = stateChoice.selected(item);

                  return ChoiceChip(
                    selected: selected,
                    onSelected: stateChoice.onSelected(item),
                    label: Text(
                      item,
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
