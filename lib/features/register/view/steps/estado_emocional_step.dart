import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/features/register/models/estado_emocional_model.dart';
import 'package:lactaamor/features/register/viewmodel/register_viewmodel.dart';

class EstadoEmocionalStep extends ConsumerStatefulWidget {
  const EstadoEmocionalStep({super.key});

  @override
  ConsumerState<EstadoEmocionalStep> createState() =>
      EstadoEmocionalStepState();
}

class EstadoEmocionalStepState extends ConsumerState<EstadoEmocionalStep> {
  EstadoEmocional? _estadoActual;
  double _escala = 5;
  bool _violenciaDomestica = false;
  bool _accesoAgua = true;

  final _nivelSocioController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final state = ref.read(registerViewModelProvider);
    final model = state.estadoEmocionalModel;

    if (model != null) {
      _estadoActual = model.estadoEmocionalActual;
      _escala = model.estadoEmocionalEscala.toDouble();
      _violenciaDomestica = model.violenciaDomestica;
      _accesoAgua = model.accesoAgua;

      _nivelSocioController.text = model.nivelSocioEconomico ?? "";
    }
  }

  @override
  void dispose() {
    _nivelSocioController.dispose();
    super.dispose();
  }

  Future<bool> validateAndSave() async {
    final model = EstadoEmocionalModel(
      estadoEmocionalActual: _estadoActual!,
      estadoEmocionalEscala: _escala.toInt(),
      violenciaDomestica: _violenciaDomestica,
      accesoAgua: _accesoAgua,
      nivelSocioEconomico: _nivelSocioController.text.isEmpty
          ? null
          : _nivelSocioController.text,
    );

    ref.read(registerViewModelProvider.notifier).setEstadoEmocional(model);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Estado Emocional",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 24),

          /// Estado emocional enum
          DropdownButtonFormField<EstadoEmocional>(
            initialValue: _estadoActual,
            decoration: const InputDecoration(
              labelText: "¿Cómo te sientes actualmente?",
            ),
            items: EstadoEmocional.values
                .map(
                  (estado) => DropdownMenuItem(
                    value: estado,
                    child: Text(estado.name.toUpperCase()),
                  ),
                )
                .toList(),
            onChanged: (value) => setState(() => _estadoActual = value),
          ),

          const SizedBox(height: 24),

          /// Escala emocional
          Text(
            "En una escala del 1 al 10 ¿cómo te sientes?",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Slider(
            value: _escala,
            min: 1,
            max: 10,
            divisions: 9,
            label: _escala.toInt().toString(),
            onChanged: (value) {
              setState(() {
                _escala = value;
              });
            },
          ),

          const SizedBox(height: 16),

          /// Violencia doméstica
          SwitchListTile(
            value: _violenciaDomestica,
            onChanged: (v) => setState(() => _violenciaDomestica = v),
            title: const Text("¿Sufre violencia doméstica?"),
          ),

          /// Acceso agua
          SwitchListTile(
            value: _accesoAgua,
            onChanged: (v) => setState(() => _accesoAgua = v),
            title: const Text("¿Tiene acceso a agua potable?"),
          ),

          const SizedBox(height: 16),

          /// Nivel socioeconómico
          TextField(
            controller: _nivelSocioController,
            decoration: const InputDecoration(
              labelText: "Nivel socioeconómico (opcional)",
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
