import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/features/register/models/perfil_obstetrico_model.dart';
import 'package:lactaamor/features/register/viewmodel/register_viewmodel.dart';

class PerfilObstetricoStep extends ConsumerStatefulWidget {
  const PerfilObstetricoStep({super.key});

  @override
  ConsumerState<PerfilObstetricoStep> createState() =>
      PerfilObstetricoStepState();
}

class PerfilObstetricoStepState extends ConsumerState<PerfilObstetricoStep> {
  final _formKey = GlobalKey<FormState>();

  bool _primerEmbarazo = true;
  bool? _haDadoLuz;

  final _totalEmbarazosController = TextEditingController();
  final _abortosController = TextEditingController();
  final _partosController = TextEditingController();
  final _cesareasController = TextEditingController();

  DateTime? _ultimoEmbarazo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final state = ref.read(registerViewModelProvider);
    final model = state.perfilObstetricoModel;
    if (model != null) {
      _primerEmbarazo = model.primerEmbarazo;
      _haDadoLuz = model.haDadoLuz;

      _totalEmbarazosController.text = model.totalEmbarazos?.toString() ?? "";
      _abortosController.text = model.abortos?.toString() ?? "";
      _partosController.text = model.partosNaturales?.toString() ?? "";
      _cesareasController.text = model.cesarias?.toString() ?? "";

      _ultimoEmbarazo = model.ultimoEmbarazoAnterior;
    }
  }

  @override
  void dispose() {
    _totalEmbarazosController.dispose();
    _abortosController.dispose();
    _partosController.dispose();
    _cesareasController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() => _ultimoEmbarazo = picked);
    }
  }

  Future<bool> validateAndSave() async {
    if (!_formKey.currentState!.validate()) return false;

    if (_haDadoLuz == null) {
      setState(() {});
      return false;
    }

    final model = PerfilObstetricoModel(
      primerEmbarazo: _primerEmbarazo,
      totalEmbarazos: _primerEmbarazo
          ? null
          : int.tryParse(_totalEmbarazosController.text),
      abortos: _primerEmbarazo ? null : int.tryParse(_abortosController.text),
      partosNaturales: _primerEmbarazo
          ? null
          : int.tryParse(_partosController.text),
      cesarias: _primerEmbarazo ? null : int.tryParse(_cesareasController.text),
      ultimoEmbarazoAnterior: _primerEmbarazo ? null : _ultimoEmbarazo,
      haDadoLuz: _haDadoLuz!,
    );

    final notifier = ref.read(registerViewModelProvider.notifier);

    notifier.setHaDadoLuz(_haDadoLuz!);
    notifier.setPerfilObstetrico(model);

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
              "Perfil Obstétrico",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 24),

            _buildPrimerEmbarazoSwitch(),
            const SizedBox(height: 16),

            if (!_primerEmbarazo) ...[
              _buildNumberField(
                "Total de embarazos",
                _totalEmbarazosController,
              ),
              _buildNumberField("Abortos", _abortosController),
              _buildNumberField("Partos naturales", _partosController),
              _buildNumberField("Cesáreas", _cesareasController),
              _buildDateField(),
            ],

            const SizedBox(height: 16),

            _buildHaDadoLuzRadio(),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildPrimerEmbarazoSwitch() {
    return SwitchListTile(
      value: _primerEmbarazo,
      onChanged: (value) {
        setState(() {
          _primerEmbarazo = value;
        });
      },
      title: const Text("¿Es su primer embarazo?"),
    );
  }

  Widget _buildHaDadoLuzRadio() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("¿Ha dado a luz?"),
        Row(
          children: [
            Expanded(
              child: RadioListTile<bool>(
                value: true,
                groupValue: _haDadoLuz,
                onChanged: (value) => setState(() => _haDadoLuz = value),
                title: const Text("Sí"),
              ),
            ),
            Expanded(
              child: RadioListTile<bool>(
                value: false,
                groupValue: _haDadoLuz,
                onChanged: (value) => setState(() => _haDadoLuz = value),
                title: const Text("No"),
              ),
            ),
          ],
        ),
        if (_haDadoLuz == null)
          const Text(
            "Seleccione una opción",
            style: TextStyle(color: Colors.red),
          ),
      ],
    );
  }

  Widget _buildDateField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: _selectDate,
        child: InputDecorator(
          decoration: const InputDecoration(
            labelText: "Último embarazo anterior",
          ),
          child: Text(
            _ultimoEmbarazo == null
                ? "Seleccionar fecha"
                : "${_ultimoEmbarazo!.day}/${_ultimoEmbarazo!.month}/${_ultimoEmbarazo!.year}",
          ),
        ),
      ),
    );
  }

  Widget _buildNumberField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (!_primerEmbarazo && (value == null || value.isEmpty)) {
            return "Campo obligatorio";
          }
          return null;
        },
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}
