import 'package:flutter/material.dart';
import 'package:lactaamor/core/theme/app_colors.dart';
import 'package:lactaamor/shared/widgets/auth_text_field.dart';
import 'package:table_calendar/table_calendar.dart';

class RegisterDateField extends StatefulWidget {
  final String label;
  final IconData icon;
  final DateTime? value;
  final DateTime firstDate;
  final DateTime lastDate;
  final Function(DateTime) onChanged;
  final String? Function(String?)? validator;

  const RegisterDateField({
    super.key,
    required this.label,
    required this.icon,
    required this.value,
    required this.firstDate,
    required this.lastDate,
    required this.onChanged,
    this.validator,
  });

  @override
  State<RegisterDateField> createState() => _RegisterDateFieldState();
}

class _RegisterDateFieldState extends State<RegisterDateField> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    _updateText();
  }

  @override
  void didUpdateWidget(RegisterDateField oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateText();
  }

  void _updateText() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.text = widget.value == null
          ? ""
          : "${widget.value!.day.toString().padLeft(2, '0')}/"
                "${widget.value!.month.toString().padLeft(2, '0')}/"
                "${widget.value!.year}";
    });
  }

  void _openCalendar() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: isDark ? const Color(0xFF1C2B2E) : AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        DateTime focusedDay = widget.value ?? DateTime.now();

        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.fromLTRB(
                20,
                20,
                20,
                MediaQuery.of(context).padding.bottom + 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.label,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),

                    const SizedBox(height: 16),

                    TableCalendar(
                      locale: 'es_PE',
                      firstDay: widget.firstDate,
                      lastDay: widget.lastDate,
                      focusedDay: focusedDay,

                      selectedDayPredicate: (day) {
                        return isSameDay(widget.value, day);
                      },

                      onDaySelected: (selectedDay, focusedDayParam) {
                        widget.onChanged(selectedDay);
                        Navigator.pop(context);
                      },

                      calendarStyle: CalendarStyle(
                        todayDecoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          shape: BoxShape.circle,
                        ),

                        selectedDecoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),

                        selectedTextStyle: TextStyle(
                          color: AppColors.textPrimary,
                        ),

                        todayTextStyle: TextStyle(color: AppColors.textPrimary),

                        defaultTextStyle: TextStyle(
                          color: isDark ? Colors.white : AppColors.textPrimary,
                        ),

                        disabledTextStyle: TextStyle(
                          color: Colors.grey.withOpacity(0.3),
                        ),
                      ),

                      daysOfWeekStyle: DaysOfWeekStyle(
                        weekdayStyle: TextStyle(
                          color: isDark
                              ? Colors.white70
                              : AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),

                        weekendStyle: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,

                        titleTextStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : AppColors.textPrimary,
                        ),

                        leftChevronIcon: Icon(
                          Icons.chevron_left,
                          color: AppColors.primary,
                        ),

                        rightChevronIcon: Icon(
                          Icons.chevron_right,
                          color: AppColors.primary,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openCalendar,
      child: AbsorbPointer(
        child: AuthTextField(
          controller: controller,
          hint: widget.label,
          icon: widget.icon,
          validator: widget.validator,
        ),
      ),
    );
  }
}
