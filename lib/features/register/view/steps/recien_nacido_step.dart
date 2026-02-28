import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/features/register/models/recien_nacido_model.dart';
import 'package:lactaamor/features/register/viewmodel/register_viewmodel.dart';

class RecienNacidoStep extends ConsumerStatefulWidget {
  const RecienNacidoStep({super.key});

  @override
  ConsumerState<RecienNacidoStep> createState() => RecienNacidoStepState();
}

class RecienNacidoStepState extends ConsumerState<RecienNacidoStep> {
  final _formKey = GlobalKey<FormState>();

  final _edadGestacionalController = TextEditingController();
  final _atendidoPorController = TextEditingController();

  TipoParto? _tipoParto;
  NivelAtencion? _nivelAtencion;
  DateTime? _fechaNacimiento;

  bool _desgarros = false;
  bool _placentaCompleta = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final state = ref.read(registerViewModelProvider);
    final model = state.recienNacidoModel;

    if (model != null) {
      _edadGestacionalController.text = model.edadGestacional.toString();

      _atendidoPorController.text = model.atendidoPor;

      _tipoParto = model.tipoParto;
      _nivelAtencion = model.nivelAtencion;
      _fechaNacimiento = model.fechaNacimientoBebe;

      _desgarros = model.desgarros;
      _placentaCompleta = model.placentaCompleta;
    }
  }

  @override
  void dispose() {
    _edadGestacionalController.dispose();
    _atendidoPorController.dispose();
    super.dispose();
  }

  Future<void> _selectFechaNacimiento() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _fechaNacimiento = picked;
      });
    }
  }

  Future<bool> validateAndSave() async {
    if (!_formKey.currentState!.validate()) return false;

    final model = RecienNacidoModel(
      edadGestacional: int.parse(_edadGestacionalController.text),
      tipoParto: _tipoParto!,
      nivelAtencion: _nivelAtencion!,
      atendidoPor: _atendidoPorController.text,
      fechaNacimientoBebe: _fechaNacimiento!,
      desgarros: _desgarros,
      placentaCompleta: _placentaCompleta,
    );

    ref.read(registerViewModelProvider.notifier).setRecienNacido(model);

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Datos del Parto",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 24),

            /// Edad gestacional
            TextFormField(
              controller: _edadGestacionalController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Edad gestacional (semanas)",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Campo obligatorio";
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            /// Tipo de parto
            DropdownButtonFormField<TipoParto>(
              initialValue: _tipoParto,
              decoration: const InputDecoration(labelText: "Tipo de parto"),
              items: TipoParto.values
                  .map(
                    (tipo) => DropdownMenuItem(
                      value: tipo,
                      child: Text(tipo.name.toUpperCase()),
                    ),
                  )
                  .toList(),
              onChanged: (value) => setState(() => _tipoParto = value),
            ),

            const SizedBox(height: 16),

            /// Nivel atención
            DropdownButtonFormField<NivelAtencion>(
              initialValue: _nivelAtencion,
              decoration: const InputDecoration(labelText: "Nivel de atención"),
              items: NivelAtencion.values
                  .map(
                    (nivel) => DropdownMenuItem(
                      value: nivel,
                      child: Text(nivel.name.toUpperCase()),
                    ),
                  )
                  .toList(),
              onChanged: (value) => setState(() => _nivelAtencion = value),
            ),

            const SizedBox(height: 16),

            /// Atendido por
            TextFormField(
              controller: _atendidoPorController,
              decoration: const InputDecoration(
                labelText: "Atendido por (médico, obstetra, etc.)",
              ),
            ),

            const SizedBox(height: 16),

            /// Fecha nacimiento
            InkWell(
              onTap: _selectFechaNacimiento,
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: "Fecha de nacimiento",
                ),
                child: Text(
                  _fechaNacimiento == null
                      ? "Seleccionar fecha"
                      : "${_fechaNacimiento!.day}/${_fechaNacimiento!.month}/${_fechaNacimiento!.year}",
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// Desgarros
            SwitchListTile(
              value: _desgarros,
              onChanged: (v) => setState(() => _desgarros = v),
              title: const Text("¿Hubo desgarros?"),
            ),

            /// Placenta completa
            SwitchListTile(
              value: _placentaCompleta,
              onChanged: (v) => setState(() => _placentaCompleta = v),
              title: const Text("¿Placenta completa?"),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
