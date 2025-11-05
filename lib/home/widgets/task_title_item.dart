import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../dashboard_data.dart';

class TaskTitleItem extends StatelessWidget {
  final String id;
  final String title;
  final TaskStatus status;
  final ValueChanged<String>? onClick;

  const TaskTitleItem({
    super.key,
    required this.id,
    required this.title,
    required this.status,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    IconData iconData;
    Color iconColor;

    switch (status) {
      case TaskStatus.done:
        iconData = Icons.check_circle;
        iconColor = AppTheme.success;
        break;
      case TaskStatus.inProgress:
        iconData = Icons.radio_button_checked;
        iconColor = AppTheme.primary;
        break;
      case TaskStatus.pending:
        iconData = Icons.radio_button_unchecked;
        iconColor = AppTheme.tertiaryForeground;
        break;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onClick?.call(id),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: Row(
            children: [
              Icon(iconData, size: 20, color: iconColor),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: status == TaskStatus.done
                        ? AppTheme.mutedForeground
                        : AppTheme.foreground,
                    decoration: status == TaskStatus.done
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

