import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/features/register/models/senales_peligro_model.dart';
import 'package:lactaamor/features/register/viewmodel/register_viewmodel.dart';

class SenalesPeligroStep extends ConsumerStatefulWidget {
  const SenalesPeligroStep({super.key});

  @override
  ConsumerState<SenalesPeligroStep> createState() => SenalesPeligroStepState();
}

class SenalesPeligroStepState extends ConsumerState<SenalesPeligroStep> {
  bool _vomitoExcesivo = false;
  bool _sangradoVaginal = false;
  bool _fiebre = false;
  bool _hinchazon = false;
  bool _dolorCabeza = false;

  Future<bool> validateAndSave() async {
    final model = SenalesPeligroModel(
      vomitoExcesivo: _vomitoExcesivo,
      sangradoVaginal: _sangradoVaginal,
      fiebre: _fiebre,
      hinchazon: _hinchazon,
      dolorCabeza: _dolorCabeza,
    );

    ref.read(registerViewModelProvider.notifier).setSenalesPeligro(model);

    return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final state = ref.read(registerViewModelProvider);
    final model = state.senalesPeligroModel;

    if (model != null) {
      _vomitoExcesivo = model.vomitoExcesivo;
      _sangradoVaginal = model.sangradoVaginal;
      _fiebre = model.fiebre;
      _hinchazon = model.hinchazon;
      _dolorCabeza = model.dolorCabeza;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Señales de Peligro",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 12),
          Text(
            "Marca si has presentado alguno de estos síntomas:",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),

          SwitchListTile(
            value: _vomitoExcesivo,
            onChanged: (v) => setState(() => _vomitoExcesivo = v),
            title: const Text("Vómito excesivo"),
          ),

          SwitchListTile(
            value: _sangradoVaginal,
            onChanged: (v) => setState(() => _sangradoVaginal = v),
            title: const Text("Sangrado vaginal"),
          ),

          SwitchListTile(
            value: _fiebre,
            onChanged: (v) => setState(() => _fiebre = v),
            title: const Text("Fiebre"),
          ),

          SwitchListTile(
            value: _hinchazon,
            onChanged: (v) => setState(() => _hinchazon = v),
            title: const Text("Hinchazón en manos o rostro"),
          ),

          SwitchListTile(
            value: _dolorCabeza,
            onChanged: (v) => setState(() => _dolorCabeza = v),
            title: const Text("Dolor de cabeza intenso"),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
