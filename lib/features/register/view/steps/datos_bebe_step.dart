import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/features/register/models/datos_bebe_model.dart';
import 'package:lactaamor/features/register/viewmodel/register_viewmodel.dart';

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
                  SwitchListTile(
                    title: const Text("¿Fue prematuro?"),
                    value: _fuePrematuro,
                    onChanged: (v) => setState(() => _fuePrematuro = v),
                  ),

                  /// Tipo de parto
                  DropdownButtonFormField<TipoParto>(
                    initialValue: _tipoParto,
                    decoration: const InputDecoration(
                      labelText: "Tipo de parto",
                    ),
                    items: TipoParto.values
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.name.toUpperCase()),
                          ),
                        )
                        .toList(),
                    onChanged: (v) => setState(() => _tipoParto = v),
                  ),

                  const SizedBox(height: 16),

                  /// Fecha de nacimiento
                  TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Fecha de nacimiento",
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: _fechaNacimiento ?? DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now(),
                          );
                          if (date != null) {
                            setState(() => _fechaNacimiento = date);
                          }
                        },
                      ),
                    ),
                    controller: TextEditingController(
                      text: _fechaNacimiento == null
                          ? ''
                          : "${_fechaNacimiento!.day}/${_fechaNacimiento!.month}/${_fechaNacimiento!.year}",
                    ),
                    validator: (value) {
                      if (_fechaNacimiento == null) return "Campo obligatorio";
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  /// Sexo del bebé
                  DropdownButtonFormField<SexoBebe>(
                    initialValue: _sexoBebe,
                    decoration: const InputDecoration(
                      labelText: "Sexo del bebé",
                    ),
                    items: SexoBebe.values
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.name.toUpperCase()),
                          ),
                        )
                        .toList(),
                    onChanged: (v) => setState(() => _sexoBebe = v),
                  ),

                  const SizedBox(height: 16),

                  /// Peso
                  TextFormField(
                    controller: _pesoController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(
                      labelText: "Peso al nacer (kg)",
                    ),
                    validator: (value) => (value == null || value.isEmpty)
                        ? "Campo obligatorio"
                        : null,
                  ),

                  const SizedBox(height: 16),

                  /// Altura
                  TextFormField(
                    controller: _alturaController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(
                      labelText: "Altura al nacer (cm)",
                    ),
                    validator: (value) => (value == null || value.isEmpty)
                        ? "Campo obligatorio"
                        : null,
                  ),

                  const SizedBox(height: 16),

                  /// Patologías
                  TextFormField(
                    controller: _patologiasController,
                    decoration: const InputDecoration(
                      labelText: "Patologías (opcional)",
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// Tipo alimentación
                  DropdownButtonFormField<TipoAlimentacion>(
                    initialValue: _tipoAlimentacion,
                    decoration: const InputDecoration(
                      labelText: "Tipo de alimentación",
                    ),
                    items: TipoAlimentacion.values
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.name.toUpperCase()),
                          ),
                        )
                        .toList(),
                    onChanged: (v) => setState(() => _tipoAlimentacion = v),
                  ),

                  const SizedBox(height: 16),

                  /// Lactancia exclusiva (solo si pecho)
                  if (_tipoAlimentacion == TipoAlimentacion.pecho)
                    SwitchListTile(
                      title: const Text("¿Lactancia materna exclusiva?"),
                      value: _lactanciaExclusiva,
                      onChanged: (v) => setState(() => _lactanciaExclusiva = v),
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
}
