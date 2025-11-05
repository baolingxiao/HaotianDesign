import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../dashboard_data.dart';
import 'progress_ring.dart';
import 'task_title_item.dart';

class ProgressCardLeft extends StatelessWidget {
  final double dailyProgressPct;
  final int doneCount;
  final int totalCount;
  final List<TodayTask>? tasksToday;
  final bool showList;
  final int maxVisible;
  final ValueChanged<String>? onTaskClick;
  final VoidCallback? onViewAll;
  final VoidCallback? onCreateTask;

  const ProgressCardLeft({
    super.key,
    required this.dailyProgressPct,
    required this.doneCount,
    required this.totalCount,
    this.tasksToday,
    this.showList = true,
    this.maxVisible = 4,
    this.onTaskClick,
    this.onViewAll,
    this.onCreateTask,
  });

  @override
  Widget build(BuildContext context) {
    final visibleTasks = tasksToday?.take(maxVisible).toList() ?? [];
    final isEmpty = tasksToday?.isEmpty ?? true;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '今日目标完成度',
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.foreground,
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: ProgressRing(
              percentage: dailyProgressPct,
              size: 100,
              strokeWidth: 10,
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              '$doneCount/$totalCount 已完成',
              style: const TextStyle(
                fontSize: 12,
                color: AppTheme.mutedForeground,
              ),
            ),
          ),
          if (showList) ...[
            const SizedBox(height: 16),
            if (isEmpty)
              _EmptyState(onCreateTask: onCreateTask)
            else ...[
              ...visibleTasks.map((task) => TaskTitleItem(
                    id: task.id,
                    title: task.title,
                    status: task.status,
                    onClick: onTaskClick,
                  )),
              const SizedBox(height: 12),
              _ViewAllButton(onTap: onViewAll),
            ],
          ],
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final VoidCallback? onCreateTask;

  const _EmptyState({this.onCreateTask});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '今天没有任务',
            style: TextStyle(
              fontSize: 12,
              color: AppTheme.mutedForeground,
            ),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: onCreateTask,
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '去创建',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.primary,
                  ),
                ),
                SizedBox(width: 4),
                Icon(Icons.chevron_right, size: 12, color: AppTheme.primary),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ViewAllButton extends StatelessWidget {
  final VoidCallback? onTap;

  const _ViewAllButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: AppTheme.secondary.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '查看全部 To-do',
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.foreground,
                ),
              ),
              SizedBox(width: 4),
              Icon(Icons.chevron_right, size: 12, color: AppTheme.foreground),
            ],
          ),
        ),
      ),
    );
  }
}

