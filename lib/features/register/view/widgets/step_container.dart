import 'package:flutter/material.dart';

class StepContainer extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: child,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              if (onBack != null)
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: OutlinedButton(
                      onPressed: onBack,
                      child: Text("Atras"),
                    ),
                  ),
                ),
              if (onBack != null) const SizedBox(width: 16),
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (onValidate != null) {
                        final isValid = await onValidate!();
                        if (!isValid) return;
                      }

                      onNext?.call();
                    },
                    child: Text(isLast ? "Finalizar" : "Siguiente"),
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
