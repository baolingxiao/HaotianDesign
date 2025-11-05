import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class DateHeader extends StatelessWidget {
  final String weekday;
  final String fullDate;
  final VoidCallback? onCalendarClick;
  final VoidCallback? onProfileClick;

  const DateHeader({
    super.key,
    required this.weekday,
    required this.fullDate,
    this.onCalendarClick,
    this.onProfileClick,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              weekday,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: AppTheme.foreground,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              fullDate,
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.mutedForeground,
              ),
            ),
          ],
        ),
        Row(
          children: [
            _IconButton(
              icon: Icons.calendar_today,
              onTap: onCalendarClick,
            ),
            const SizedBox(width: 8),
            _IconButton(
              icon: Icons.person,
              onTap: onProfileClick,
            ),
          ],
        ),
      ],
    );
  }
}

class _IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _IconButton({
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppTheme.card,
            shape: BoxShape.circle,
            border: Border.all(color: AppTheme.border),
          ),
          child: Icon(
            icon,
            size: 20,
            color: AppTheme.foreground,
          ),
        ),
      ),
    );
  }
}


