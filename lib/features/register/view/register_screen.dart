import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/features/auth/view/login_screen.dart';
import 'package:lactaamor/features/register/view/steps/datos_bebe_step.dart';
import 'package:lactaamor/features/register/view/steps/embarazo_actual_step.dart';
import 'package:lactaamor/features/register/view/steps/perfil_materno_step.dart';
import 'package:lactaamor/features/register/view/steps/perfil_medico_step.dart';
import 'package:lactaamor/features/register/view/steps/registro_basico_step.dart';
import 'package:lactaamor/features/register/view/widgets/progress_indicator.dart';
import 'package:lactaamor/features/register/view/widgets/step_container.dart';
import 'package:lactaamor/features/register/viewmodel/register_state.dart';
import 'package:lactaamor/features/register/viewmodel/register_viewmodel.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  late final PageController _controller;

  final registroKey = GlobalKey<RegistroBasicoStepState>();
  final perfilMaternoKey = GlobalKey<PerfilMaternoStepState>();
  final perfilMedicoKey = GlobalKey<PerfilMedicoStepState>();
  final embarazoActualKey = GlobalKey<EmbarazoActualStepState>();
  final datosBebeKey = GlobalKey<DatosBebeStepState>();

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  List<Widget> _buildSteps(RegisterState state) {
    final viewModel = ref.read(registerViewModelProvider.notifier);

    final rawSteps = <Widget>[
      RegistroBasicoStep(key: registroKey),
      PerfilMaternoStep(key: perfilMaternoKey),
    ];

    if (state.haDadoLuz == false) {
      rawSteps.add(PerfilMedicoStep(key: perfilMedicoKey));
      rawSteps.add(EmbarazoActualStep(key: embarazoActualKey));
    } else if (state.haDadoLuz == true) {
      rawSteps.add(DatosBebeStep(key: datosBebeKey));
    }
    final totalSteps = rawSteps.length;

    return List.generate(rawSteps.length, (index) {
      final isLast = index == totalSteps - 1;
      return StepContainer(
        isLast: isLast,
        onBack: index == 0 ? null : viewModel.previousStep,
        onNext: () {
          if (isLast) {
            viewModel.submit();
          } else {
            viewModel.nextStep();
          }
        },
        child: rawSteps[index],
        onValidate: () async {
          switch (rawSteps[index].runtimeType) {
            case RegistroBasicoStep:
              return await registroKey.currentState!.validateAndSave();

            case PerfilMaternoStep:
              return await perfilMaternoKey.currentState!.validateAndSave();

            case PerfilMedicoStep:
              return await perfilMedicoKey.currentState!.validateAndSave();

            case EmbarazoActualStep:
              return await embarazoActualKey.currentState!.validateAndSave();

            case DatosBebeStep:
              return await datosBebeKey.currentState!.validateAndSave();

            default:
              return true;
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(registerViewModelProvider);

    ref.listen(registerViewModelProvider, (previus, next) {
      if (previus?.currentStep != next.currentStep) {
        _controller.animateToPage(
          next.currentStep,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }

      if (next.isSuccess) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    });

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        title: const Text('Registro Completo'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsetsGeometry.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              child: IndicadorProgreso(
                currentStep: state.currentStep,
                totalSteps: _buildSteps(state).length,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: PageView(
                controller: _controller,
                physics: const NeverScrollableScrollPhysics(),
                children: _buildSteps(state),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
