import 'package:flutter/material.dart';
import 'package:lactaamor/core/theme/app_colors.dart';

class EmbarazoSwitch extends StatefulWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const EmbarazoSwitch({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  State<EmbarazoSwitch> createState() => _EmbarazoSwitchState();
}

class _EmbarazoSwitchState extends State<EmbarazoSwitch>
    with SingleTickerProviderStateMixin {
  late bool isChecked;

  final Duration _duration = const Duration(milliseconds: 350);

  late AnimationController _controller;
  late Animation<Alignment> _animation;

  @override
  void initState() {
    super.initState();

    isChecked = widget.value;

    _controller = AnimationController(
      vsync: this,
      duration: _duration,
      value: isChecked ? 1 : 0,
    );

    _animation =
        AlignmentTween(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOutBack,
            reverseCurve: Curves.easeInBack,
          ),
        );
  }

  void toggle() {
    setState(() {
      isChecked = !isChecked;

      if (isChecked) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });

    widget.onChanged(isChecked);
  }

  @override
  void didUpdateWidget(covariant EmbarazoSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.value != isChecked) {
      isChecked = widget.value;
      if (isChecked) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final activeColor = AppColors.primary;
    final inactiveColor = AppColors.primary.withOpacity(0.3);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(widget.label, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 10),
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return GestureDetector(
              onTap: toggle,
              child: Container(
                width: 120,
                height: 50,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: isChecked ? activeColor : inactiveColor,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: (isChecked ? activeColor : inactiveColor)
                          .withOpacity(.35),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        isChecked ? "Sí" : "No",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Align(
                      alignment: _animation.value,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
