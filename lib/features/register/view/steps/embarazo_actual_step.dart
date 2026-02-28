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
  DateTime? _partoProbable;

  final _pesoAntesController = TextEditingController();
  final _pesoActualController = TextEditingController();
  final _alturaController = TextEditingController();

  bool _fuma = false;
  final _cigarrillosController = TextEditingController();

  bool _controlPrenatal = false;
  final _controlesController = TextEditingController();

  bool _dudasGenerales = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final state = ref.read(registerViewModelProvider);

    final model = state.embarazoActualModel;

    if (model != null) {
      _ultimaMenstruacion = model.ultimaMestruacion;
      _partoProbable = model.partoProbable;

      _pesoAntesController.text = model.pesoAntesEmbarazo?.toString() ?? "";

      _pesoActualController.text = model.pesoActual?.toString() ?? "";

      _alturaController.text = model.altura?.toString() ?? "";

      _fuma = model.fuma;

      _cigarrillosController.text =
          model.cuantosCigarrillosAlDia?.toString() ?? "";

      _controlPrenatal = model.controlPrenatal;

      _controlesController.text =
          model.numeroControlesPrenatales?.toString() ?? "";

      _dudasGenerales = model.dudasGenerales;
    }
  }

  @override
  void dispose() {
    _pesoAntesController.dispose();
    _pesoActualController.dispose();
    _alturaController.dispose();
    _cigarrillosController.dispose();
    _controlesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(bool isUltima) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 300)),
    );

    if (picked != null) {
      setState(() {
        if (isUltima) {
          _ultimaMenstruacion = picked;
        } else {
          _partoProbable = picked;
        }
      });
    }
  }

  Future<bool> validateAndSave() async {
    if (!_formKey.currentState!.validate()) return false;

    final model = EmbarazoActualModel(
      ultimaMestruacion: _ultimaMenstruacion,
      partoProbable: _partoProbable,
      pesoAntesEmbarazo: double.tryParse(_pesoAntesController.text),
      pesoActual: double.tryParse(_pesoActualController.text),
      altura: double.tryParse(_alturaController.text),
      fuma: _fuma,
      cuantosCigarrillosAlDia: _fuma
          ? int.tryParse(_cigarrillosController.text)
          : null,
      controlPrenatal: _controlPrenatal,
      numeroControlesPrenatales: _controlPrenatal
          ? int.tryParse(_controlesController.text)
          : null,
      dudasGenerales: _dudasGenerales,
    );

    ref.read(registerViewModelProvider.notifier).setEmbarazoActual(model);

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
              "Embarazo Actual",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 24),

            _buildDateField(
              "Fecha última menstruación",
              _ultimaMenstruacion,
              () => _selectDate(true),
            ),
            _buildDateField(
              "Fecha probable de parto",
              _partoProbable,
              () => _selectDate(false),
            ),

            const SizedBox(height: 16),

            _buildNumberField(
              "Peso antes del embarazo (kg)",
              _pesoAntesController,
            ),
            _buildNumberField("Peso actual (kg)", _pesoActualController),
            _buildNumberField("Altura (m)", _alturaController),

            const SizedBox(height: 16),

            _buildSwitch("¿Fuma?", _fuma, (v) => setState(() => _fuma = v)),

            if (_fuma)
              _buildNumberField(
                "¿Cuántos cigarrillos al día?",
                _cigarrillosController,
              ),

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

            const SizedBox(height: 16),

            _buildSwitch(
              "¿Tiene dudas generales?",
              _dudasGenerales,
              (v) => setState(() => _dudasGenerales = v),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildDateField(String label, DateTime? date, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        child: InputDecorator(
          decoration: InputDecoration(labelText: label),
          child: Text(
            date == null
                ? "Seleccionar fecha"
                : "${date.day}/${date.month}/${date.year}",
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
