import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/dashboard_data.dart';

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
    Widget icon;
    Color iconColor;

    IconData iconData;
    switch (status) {
      case TaskStatus.done:
        iconData = Icons.check_circle;
        iconColor = AppTheme.success;
        break;
      case TaskStatus.inProgress:
        iconData = Icons.schedule;
        iconColor = AppTheme.primary;
        break;
      case TaskStatus.pending:
        iconData = Icons.radio_button_unchecked;
        iconColor = AppTheme.mutedForeground;
        break;
    }
    icon = Icon(iconData, size: 16);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onClick?.call(id),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: AppTheme.background.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(iconData, size: 16, color: iconColor),
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
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: 16,
                color: AppTheme.tertiaryForeground,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

