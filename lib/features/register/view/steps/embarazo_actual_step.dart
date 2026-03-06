import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/features/register/models/embarazo_actual_model.dart';
import 'package:lactaamor/features/register/viewmodel/register_viewmodel.dart';

class EmbarazoActualStep extends ConsumerStatefulWidget {
  const EmbarazoActualStep({super.key});

  @override
  ConsumerState<EmbarazoActualStep> createState() => EmbarazoActualStepState();
}

class EmbarazoActualStepState extends ConsumerState<EmbarazoActualStep> {
  final _formKey = GlobalKey<FormState>();

  DateTime? _ultimaMenstruacion;

  final _pesoActualController = TextEditingController();
  final _alturaController = TextEditingController();

  bool _controlPrenatal = false;
  final _controlesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final state = ref.read(registerViewModelProvider);

    final model = state.embarazoActualModel;

    if (model != null) {
      _ultimaMenstruacion = model.ultimaMestruacion;

      _pesoActualController.text = model.pesoActual?.toString() ?? "";

      _alturaController.text = model.altura?.toString() ?? "";
      _controlPrenatal = model.controlPrenatal;

      _controlesController.text =
          model.numeroControlesPrenatales?.toString() ?? "";
    }
  }

  @override
  void dispose() {
    _pesoActualController.dispose();
    _alturaController.dispose();
    _controlesController.dispose();
    super.dispose();
  }

  Future<bool> validateAndSave() async {
    if (!_formKey.currentState!.validate()) return false;

    final model = EmbarazoActualModel(
      ultimaMestruacion: _ultimaMenstruacion ?? DateTime.now(),

      pesoActual: double.tryParse(_pesoActualController.text),
      altura: double.tryParse(_alturaController.text),

      controlPrenatal: _controlPrenatal,
      numeroControlesPrenatales: _controlPrenatal
          ? int.tryParse(_controlesController.text)
          : null,
    );

    ref.read(registerViewModelProvider.notifier).setEmbarazoActual(model);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Embarazo Actual",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          const Divider(thickness: 2, height: 1),
          const SizedBox(height: 24),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Fecha de ultima menstruacion",
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now().add(
                              const Duration(days: 300),
                            ),
                          );
                          if (date != null) {
                            setState(() => _ultimaMenstruacion = date);
                          }
                        },
                      ),
                    ),
                    controller: TextEditingController(
                      text: _ultimaMenstruacion == null
                          ? ''
                          : "${_ultimaMenstruacion!.day}/${_ultimaMenstruacion!.month}/${_ultimaMenstruacion!.year}",
                    ),
                    validator: (value) {
                      if (_ultimaMenstruacion == null)
                        return "Campo Obligatorio";
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  _buildNumberField("Peso actual (kg)", _pesoActualController),
                  _buildNumberField("Altura (m)", _alturaController),

                  const SizedBox(height: 16),

                  _buildSwitch(
                    "¿Tiene control prenatal?",
                    _controlPrenatal,
                    (v) => setState(() => _controlPrenatal = v),
                  ),

                  if (_controlPrenatal)
                    _buildNumberField(
                      "Número de controles prenatales",
                      _controlesController,
                    ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(labelText: label),
      ),
    );
  }

  Widget _buildSwitch(String title, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      value: value,
      onChanged: onChanged,
      title: Text(title),
    );
  }
}
