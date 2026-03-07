import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/features/register/models/datos_bebe_model.dart';
import 'package:lactaamor/features/register/view/widgets/embarazo_switch.dart';
import 'package:lactaamor/features/register/view/widgets/fecha_select.dart';
import 'package:lactaamor/features/register/view/widgets/register_dropdown.dart';
import 'package:lactaamor/features/register/view/widgets/sexo_bebe_selector.dart';
import 'package:lactaamor/features/register/view/widgets/tipo_alimentacion_selector.dart';
import 'package:lactaamor/features/register/viewmodel/register_viewmodel.dart';
import 'package:lactaamor/shared/widgets/auth_text_field.dart';

class DatosBebeStep extends ConsumerStatefulWidget {
  const DatosBebeStep({super.key});

  @override
  ConsumerState<DatosBebeStep> createState() => DatosBebeStepState();
}

class DatosBebeStepState extends ConsumerState<DatosBebeStep> {
  final _formKey = GlobalKey<FormState>();

  SexoBebe? _sexoBebe;
  TipoAlimentacion? _tipoAlimentacion;

  final _pesoController = TextEditingController();
  final _alturaController = TextEditingController();
  final _patologiasController = TextEditingController();

  bool _lactanciaExclusiva = false;
  bool _fuePrematuro = false;
  TipoParto? _tipoParto;
  DateTime? _fechaNacimiento;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final state = ref.read(registerViewModelProvider);

    final model = state.datosBebeModel;

    if (model != null) {
      _sexoBebe = model.sexoBebe;
      _tipoAlimentacion = model.tipoAlimentacion;
      _pesoController.text = model.pesoAlNacer.toString();
      _alturaController.text = model.alturaAlNacer.toString();
      _patologiasController.text = model.patologias ?? '';
      _lactanciaExclusiva = model.lactanciaExclusiva ?? false;
      _fuePrematuro = model.fuePrematuro;
      _tipoParto = model.tipoParto;
      _fechaNacimiento = model.fechaNacimientoBebe;
    }
  }

  @override
  void dispose() {
    _pesoController.dispose();
    _alturaController.dispose();
    _patologiasController.dispose();
    super.dispose();
  }

  Future<bool> validateAndSave() async {
    if (!_formKey.currentState!.validate()) return false;

    final model = DatosBebeModel(
      fuePrematuro: _fuePrematuro,
      tipoParto: _tipoParto ?? TipoParto.natural,
      fechaNacimientoBebe: _fechaNacimiento ?? DateTime.now(),
      sexoBebe: _sexoBebe!,
      pesoAlNacer: double.parse(_pesoController.text),
      alturaAlNacer: double.parse(_alturaController.text),
      patologias: _patologiasController.text.isEmpty
          ? null
          : _patologiasController.text.trim(),
      tipoAlimentacion: _tipoAlimentacion!,
      lactanciaExclusiva: _tipoAlimentacion == TipoAlimentacion.pecho
          ? _lactanciaExclusiva
          : null,
    );

    ref.read(registerViewModelProvider.notifier).setDatosBebe(model);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Datos del Bebé", style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          const Divider(thickness: 2, height: 1),
          const SizedBox(height: 24),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  EmbarazoSwitch(
                    label: "¿Fue prematuro?",
                    value: _fuePrematuro,
                    onChanged: (v) => setState(() => _fuePrematuro = v),
                  ),
                  const SizedBox(height: 16),
                  CustomDropdown<TipoParto>(
                    value: _tipoParto,
                    icon: Icons.baby_changing_station,
                    hint: "Tipo de parto",
                    items: TipoParto.values,
                    itemLabel: (e) => e.name.toUpperCase(),
                    onChanged: (value) => setState(() => _tipoParto = value),
                    validator: (value) => value == null
                        ? "Por favor selecciona el tipo de parto que tuvo"
                        : null,
                  ),

                  const SizedBox(height: 16),

                  RegisterDateField(
                    label: "Fecha de nacimiento",
                    icon: Icons.calendar_today,
                    value: _fechaNacimiento,
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                    onChanged: (date) {
                      setState(() {
                        _fechaNacimiento = date;
                      });
                    },
                    validator: (_) {
                      if (_fechaNacimiento == null) {
                        return "Por favor selecciona una fecha";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  SexoBebeSelector(
                    value: _sexoBebe,
                    onChanged: (v) => setState(() => _sexoBebe = v),
                    validator: (val) => val == null
                        ? "Por favor selecciona el sexo de tu bebé"
                        : null,
                  ),
                  const SizedBox(height: 16),

                  /// Peso
                  AuthTextField(
                    controller: _pesoController,
                    hint: "Peso al nacer (kg)",
                    icon: Icons.monitor_weight,
                    typeKeyboard: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d*\.?\d{0,2}'),
                      ), // hasta 2 decimales
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Por favor ingresa el peso de tu bebé al nacer";
                      }
                      final peso = double.tryParse(value) ?? 0;
                      if (peso <= 0) return "El peso debe ser mayor que 0";
                      if (peso > 10) return "El peso máximo es 10 kg";
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  /// Altura
                  AuthTextField(
                    controller: _alturaController,
                    hint: "Altura al nacer (cm)",
                    icon: Icons.height,
                    typeKeyboard: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d*\.?\d{0,1}'),
                      ), // 1 decimal máximo
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Por favor ingresa la altura de tu bebé al nacer";
                      }
                      final altura = double.tryParse(value) ?? 0;
                      if (altura <= 0) return "La altura debe ser mayor que 0";
                      if (altura > 60) return "La altura máxima es 60 cm";
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  AuthTextField(
                    controller: _patologiasController,
                    hint: "Patologías al nacer (opcional)",
                    icon: Icons.medical_services,
                    typeKeyboard: TextInputType.multiline,
                    inputFormatters: [],
                    validator: null,
                    maxLines: 3,
                  ),

                  const SizedBox(height: 16),
                  TipoAlimentacionSelector(
                    value: _tipoAlimentacion,
                    onChanged: (value) =>
                        setState(() => _tipoAlimentacion = value),
                    validator: (value) => value == null
                        ? "Por favor selecciona el tipo de lactancia"
                        : null,
                  ),

                  const SizedBox(height: 16),

                  AnimatedCrossFade(
                    firstChild: const SizedBox.shrink(),
                    secondChild: Column(
                      children: [
                        EmbarazoSwitch(
                          key: const ValueKey("lactancia_exclusiva_switch"),
                          label: "¿Lactancia materna exclusiva?",
                          value: _lactanciaExclusiva,
                          onChanged: (v) =>
                              setState(() => _lactanciaExclusiva = v),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                    crossFadeState: _tipoAlimentacion == TipoAlimentacion.pecho
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 300),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
