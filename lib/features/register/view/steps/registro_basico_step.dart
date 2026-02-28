import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/features/register/models/registro_basico_model.dart';
import 'package:lactaamor/features/register/viewmodel/register_viewmodel.dart';

class RegistroBasicoStep extends ConsumerStatefulWidget {
  const RegistroBasicoStep({super.key});

  @override
  ConsumerState<RegistroBasicoStep> createState() => RegistroBasicoStepState();
}

class RegistroBasicoStepState extends ConsumerState<RegistroBasicoStep> {
  final _formKey = GlobalKey<FormState>();

  final _fullnameController = TextEditingController();
  final _dniController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _celularController = TextEditingController();
  final _edadController = TextEditingController();
  final _departamentoController = TextEditingController();
  final _provinciaController = TextEditingController();
  final _distritoController = TextEditingController();
  final _institucionController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final state = ref.read(registerViewModelProvider);

    final model = state.registroBasicoModel;

    if (model != null) {
      _fullnameController.text = model.fullname;
      _dniController.text = model.dni;
      _emailController.text = model.email ?? '';
      _celularController.text = model.celular ?? '';
      _edadController.text = model.edad.toString();
      _departamentoController.text = model.departamento;
      _provinciaController.text = model.provincia;
      _distritoController.text = model.distrito;
      _institucionController.text = model.institucion;
    }
  }

  @override
  void dispose() {
    _fullnameController.dispose();
    _dniController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _celularController.dispose();
    _edadController.dispose();
    _departamentoController.dispose();
    _provinciaController.dispose();
    _distritoController.dispose();
    _institucionController.dispose();
    super.dispose();
  }

  Future<bool> validateAndSave() async {
    if (!_formKey.currentState!.validate()) return false;

    final model = RegistroBasicoModel(
      fullname: _fullnameController.text.trim(),
      dni: _dniController.text.trim(),
      email: _emailController.text.trim(),
      celular: _celularController.text.trim(),
      edad: int.parse(_edadController.text.trim()),
      departamento: _departamentoController.text.trim(),
      provincia: _provinciaController.text.trim(),
      distrito: _distritoController.text.trim(),
      institucion: _institucionController.text.trim(),
      photoUrl: "",
    );

    ref.read(registerViewModelProvider.notifier).setRegistroBasico(model);
    ref
        .read(registerViewModelProvider.notifier)
        .setPassword(_passwordController.text.trim());

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
              "Información Básica",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 24),

            _buildTextField("Nombre completo", _fullnameController),
            _buildTextField("DNI", _dniController),
            _buildTextField("Email", _emailController),
            _buildTextField("Contraseña", _passwordController),
            _buildTextField("Celular", _celularController),
            _buildTextField(
              "Edad",
              _edadController,
              keyboardType: TextInputType.number,
            ),
            _buildTextField("Departamento", _departamentoController),
            _buildTextField("Provincia", _provinciaController),
            _buildTextField("Distrito", _distritoController),
            _buildTextField("Institución", _institucionController),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: (value) =>
            value == null || value.isEmpty ? "Campo obligatorio" : null,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}
