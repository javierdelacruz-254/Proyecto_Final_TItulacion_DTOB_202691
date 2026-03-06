import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lactaamor/core/theme/app_colors.dart';
import 'package:lactaamor/features/register/viewmodel/register_viewmodel.dart';
import 'package:lactaamor/shared/widgets/auth_button.dart';

class StepContainer extends ConsumerWidget {
  final Widget child;
  final VoidCallback? onNext;
  final VoidCallback? onBack;
  final Future<bool> Function()? onValidate;
  final bool isLast;

  const StepContainer({
    super.key,
    required this.child,
    this.onNext,
    this.onBack,
    this.onValidate,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 0, bottom: 16),
      child: Column(
        children: [
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              switchInCurve: Curves.easeInOut,
              switchOutCurve: Curves.easeInOut,
              child: child,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              if (onBack != null)
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: OutlinedButton(
                      onPressed: onBack,
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: BorderSide(
                          color: AppColors.primary.withOpacity(0.7),
                          width: 1.5,
                        ),
                        backgroundColor:
                            Theme.of(context).brightness == Brightness.dark
                            ? Colors.white12
                            : Colors.white,
                      ),
                      child: Text("Atras"),
                    ),
                  ),
                ),
              if (onBack != null) const SizedBox(width: 16),
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: isLast
                      ? AuthButton(
                          text: "Finalizar",
                          isLoading: ref
                              .watch(registerViewModelProvider)
                              .isLoading,
                          onPressed: () async {
                            if (onValidate != null) {
                              final isValid = await onValidate!();
                              if (!isValid) return;
                            }

                            onNext?.call();
                          },
                        )
                      : ElevatedButton(
                          onPressed: () async {
                            if (onValidate != null) {
                              final isValid = await onValidate!();
                              if (!isValid) return;
                            }

                            onNext?.call();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            elevation: 3,
                            shadowColor: AppColors.primary.withOpacity(0.4),
                          ),
                          child: Text(
                            "Siguiente",
                            style: TextStyle(
                              color:
                                  Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? AppColors.textPrimary
                                  : Colors.white,
                            ),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
