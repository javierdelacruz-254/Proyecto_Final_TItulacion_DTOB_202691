import 'package:flutter/material.dart';
import 'package:lactaamor/core/theme/app_colors.dart';

class CalendarioToday extends StatelessWidget {
  const CalendarioToday({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final hoy = DateTime.now();

    final diasSemana = ["Lun", "Mar", "Mie", "Jue", "Vie", "Sab", "Dom"];
    final meses = [
      "Enero",
      "Febrero",
      "Marzo",
      "Abril",
      "Mayo",
      "Junio",
      "Julio",
      "Agosto",
      "Septiembre",
      "Octubre",
      "Noviembre",
      "Diciembre",
    ];

    final semana = List.generate(7, (i) {
      return hoy.subtract(Duration(days: 3 - i));
    });

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),

      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.calendar_month, size: 18),

              const SizedBox(width: 6),

              Text(
                "${meses[hoy.month - 1]} ${hoy.year}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          /// DIAS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: semana.map((dia) {
              final esHoy = dia.day == hoy.day;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut,

                padding: const EdgeInsets.symmetric(vertical: 6),

                child: Column(
                  children: [
                    /// DIA DE SEMANA
                    Text(
                      diasSemana[dia.weekday - 1],
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: esHoy ? AppColors.primary : Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 6),

                    /// DIA NUMERO
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      width: esHoy ? 42 : 36,
                      height: esHoy ? 42 : 36,

                      alignment: Alignment.center,

                      decoration: BoxDecoration(
                        color: esHoy ? AppColors.primary : Colors.transparent,
                        shape: BoxShape.circle,

                        boxShadow: esHoy
                            ? [
                                BoxShadow(
                                  color: AppColors.primary.withOpacity(0.35),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ]
                            : [],
                      ),

                      child: Text(
                        "${dia.day}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: esHoy ? 16 : 14,
                          color: esHoy
                              ? Colors.white
                              : isDark
                              ? Colors.white
                              : Colors.black87,
                        ),
                      ),
                    ),

                    const SizedBox(height: 4),

                    /// TEXTO HOY
                    if (esHoy)
                      const Text(
                        "Hoy",
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    else
                      const SizedBox(height: 10),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
