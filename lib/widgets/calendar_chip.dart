import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CalendarChip extends StatelessWidget {
  final String day;
  final int date;
  final bool isSelected;
  final VoidCallback? onClick;
  final bool disabled;

  const CalendarChip({
    super.key,
    required this.day,
    required this.date,
    this.isSelected = false,
    this.onClick,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: disabled ? null : onClick,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          constraints: const BoxConstraints(minWidth: 60),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: disabled
                ? AppTheme.card.withOpacity(0.5)
                : isSelected
                    ? AppTheme.primary
                    : AppTheme.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: disabled
                  ? AppTheme.border.withOpacity(0.5)
                  : isSelected
                      ? AppTheme.primary
                      : AppTheme.border,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                day,
                style: TextStyle(
                  fontSize: 12,
                  color: disabled
                      ? AppTheme.mutedForeground.withOpacity(0.5)
                      : isSelected
                          ? AppTheme.primaryForeground.withOpacity(0.9)
                          : AppTheme.tertiaryForeground,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                date.toString(),
                style: TextStyle(
                  fontSize: 18,
                  color: disabled
                      ? AppTheme.mutedForeground.withOpacity(0.5)
                      : isSelected
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


