import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/features/register/models/embarazo_actual_model.dart';
import 'package:lactaamor/features/register/view/widgets/embarazo_switch.dart';
import 'package:lactaamor/features/register/view/widgets/fecha_select.dart';
import 'package:lactaamor/features/register/viewmodel/register_viewmodel.dart';
import 'package:lactaamor/shared/widgets/auth_text_field.dart';

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
                  RegisterDateField(
                    label: "Fecha del último periodo",
                    icon: Icons.calendar_month,
                    value: _ultimaMenstruacion,
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                    onChanged: (date) {
                      setState(() {
                        _ultimaMenstruacion = date;
                      });
                    },
                    validator: (_) {
                      if (_ultimaMenstruacion == null) {
                        return "Por favor selecciona una fecha";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  AuthTextField(
                    controller: _pesoActualController,
                    hint: "Peso actual (kg)",
                    icon: Icons.monitor_weight,
                    typeKeyboard: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,2}'),
                      ),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Por favor ingresa tu peso actual";
                      }

                      final peso = double.tryParse(value) ?? 0;

                      if (peso < 30 || peso > 200) {
                        return "Peso fuera de rango";
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  AuthTextField(
                    controller: _alturaController,
                    hint: "Altura (m)",
                    icon: Icons.height,
                    typeKeyboard: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,2}'),
                      ),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Por favor ingresa tu altura actual";
                      }

                      final altura = double.tryParse(value) ?? 0;

                      if (altura < 1.30 || altura > 2.20) {
                        return "Altura fuera de rango";
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  EmbarazoSwitch(
                    label: "¿Tiene control prenatal?",
                    value: _controlPrenatal,
                    onChanged: (v) {
                      setState(() {
                        _controlPrenatal = v;

                        if (!v) {
                          _controlesController.clear();
                        }
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  AnimatedCrossFade(
                    firstChild: const SizedBox.shrink(),
                    secondChild: Column(
                      children: [
                        AuthTextField(
                          controller: _controlesController,
                          hint: "Número de controles prenatales",
                          icon: Icons.medical_services,

                          typeKeyboard: TextInputType.number,

                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],

                          validator: (value) {
                            if (_controlPrenatal) {
                              if (value == null || value.isEmpty) {
                                return "Por favor ingresa el número de controles";
                              }

                              final n = int.tryParse(value) ?? 0;
                              if (n > 30) {
                                return "Número poco probable";
                              }
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    crossFadeState: _controlPrenatal
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 300),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
