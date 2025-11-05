import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/dashboard_data.dart';

class TaskCard extends StatelessWidget {
  final String time;
  final String title;
  final String description;
  final TaskStatus status;
  final String buttonText;
  final bool isPrimary;

  const TaskCard({
    super.key,
    required this.time,
    required this.title,
    required this.description,
    required this.status,
    required this.buttonText,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    IconData statusIcon;
    Color statusColor;

    switch (status) {
      case TaskStatus.done:
        statusIcon = Icons.check_circle;
        statusColor = AppTheme.success;
        break;
      case TaskStatus.inProgress:
        statusIcon = Icons.autorenew;
        statusColor = AppTheme.primary;
        break;
      case TaskStatus.pending:
        statusIcon = Icons.schedule;
        statusColor = AppTheme.divider;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isPrimary ? AppTheme.primary : AppTheme.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isPrimary ? AppTheme.primary : AppTheme.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                time,
                style: TextStyle(
                  fontSize: 14,
                  color: isPrimary
                      ? AppTheme.primaryForeground.withOpacity(0.7)
                      : AppTheme.tertiaryForeground,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: isPrimary ? AppTheme.primaryForeground : AppTheme.foreground,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: isPrimary
                  ? AppTheme.primaryForeground.withOpacity(0.8)
                  : AppTheme.mutedForeground,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(statusIcon, size: 20, color: statusColor),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isPrimary
                          ? AppTheme.primaryForeground.withOpacity(0.2)
                          : AppTheme.background.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                      border: isPrimary
                          ? null
                          : Border.all(color: AppTheme.border),
                    ),
                    child: Row(
                      children: [
                        Text(
                          buttonText,
                          style: TextStyle(
                            fontSize: 14,
                            color: isPrimary
                                ? AppTheme.primaryForeground
                                : AppTheme.foreground,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward,
                          size: 16,
                          color: isPrimary
                              ? AppTheme.primaryForeground
                              : AppTheme.foreground,
                        ),
                      ],
                    ),
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


