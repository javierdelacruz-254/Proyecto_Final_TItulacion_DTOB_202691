import 'package:flutter/material.dart';
import 'package:lactaamor/core/theme/app_colors.dart';

class TabEstadisticas extends StatefulWidget {
  final double peso;
  final double altura;
  final int semanas;
  final int dias;

  const TabEstadisticas({
    super.key,
    required this.peso,
    required this.altura,
    required this.semanas,
    required this.dias,
  });

  @override
  State<TabEstadisticas> createState() => _TabEstadisticasState();
}

class _TabEstadisticasState extends State<TabEstadisticas>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget circulo({
    required double size,
    required Color color,
    required Widget child,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          double float = 10 * controller.value;

          return Stack(
            alignment: Alignment.center,
            children: [
              /// CIRCULO GRANDE (SEMANAS)
              Positioned(
                left: 20,
                top: 60 - float,
                child: circulo(
                  size: 140,
                  color: AppColors.primary,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${widget.semanas} semanas",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "${widget.dias} dias",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),

              /// CIRCULO PESO
              Positioned(
                right: 40,
                top: 10 + float,
                child: circulo(
                  size: 100,
                  color: AppColors.secondary,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.monitor_weight, color: Colors.white),
                      Text(
                        "${widget.peso.toStringAsFixed(0)} g",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "Peso",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ),

              /// CIRCULO ALTURA
              Positioned(
                right: 30,
                bottom: 50 + float,
                child: circulo(
                  size: 80,
                  color: Colors.teal.shade300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.height, color: Colors.white),
                      Text(
                        "${widget.altura.toStringAsFixed(1)} cm",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "Altura",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
