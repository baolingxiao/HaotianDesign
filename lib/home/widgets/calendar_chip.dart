import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class CalendarChip extends StatelessWidget {
  final String day;
  final int date;
  final bool isSelected;
  final VoidCallback? onClick;

  const CalendarChip({
    super.key,
    required this.day,
    required this.date,
    this.isSelected = false,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onClick,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 56,
          height: 72,
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.primary : AppTheme.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? AppTheme.primary : AppTheme.border,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                day,
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected
                      ? AppTheme.primaryForeground
                      : AppTheme.mutedForeground,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                date.toString(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: isSelected
                      ? AppTheme.primaryForeground
                      : AppTheme.foreground,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

