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
      _alturaController.text = model.altura.toString();
      _patologiasController.text = model.patologias.toString();

      _lactanciaExclusiva = model.lactanciaExclusiva ?? false;
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
      sexoBebe: _sexoBebe!,
      pesoAlNacer: double.parse(_pesoController.text),
      altura: double.parse(_alturaController.text),
      patologias: _patologiasController.text.isEmpty
          ? null
          : _patologiasController.text,
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
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Datos del Bebé",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 24),
            DropdownButtonFormField<SexoBebe>(
              initialValue: _sexoBebe,
              decoration: const InputDecoration(labelText: "Sexo del bebé"),
              items: SexoBebe.values
                  .map(
                    (sexo) => DropdownMenuItem(
                      value: sexo,
                      child: Text(sexo.name.toUpperCase()),
                    ),
                  )
                  .toList(),
              onChanged: (value) => setState(() => _sexoBebe = value),
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Campo obligatorio";
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            /// Altura
            TextFormField(
              controller: _alturaController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(labelText: "Altura (cm)"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Campo obligatorio";
                }
                return null;
              },
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
                    (tipo) => DropdownMenuItem(
                      value: tipo,
                      child: Text(tipo.name.toUpperCase()),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _tipoAlimentacion = value;
                });
              },
            ),

            const SizedBox(height: 16),

            /// Lactancia exclusiva (solo si pecho)
            if (_tipoAlimentacion == TipoAlimentacion.pecho)
              SwitchListTile(
                value: _lactanciaExclusiva,
                onChanged: (v) => setState(() => _lactanciaExclusiva = v),
                title: const Text("¿Lactancia materna exclusiva?"),
              ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
