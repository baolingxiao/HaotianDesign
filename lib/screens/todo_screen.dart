import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/task_data.dart';
import '../widgets/calendar_chip.dart';
import '../widgets/task_card.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  int _selectedDateIndex = 3;

  @override
  Widget build(BuildContext context) {
    final selectedDate = TaskDataUtils.dateChips[_selectedDateIndex];
    final dayOfWeek = _getDayOfWeek(selectedDate.day);

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 48, left: 24, right: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dayOfWeek,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.foreground,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            selectedDate.fullDate,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppTheme.mutedForeground,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.calendar_today, size: 20),
                            onPressed: () {},
                            color: AppTheme.tertiaryForeground,
                          ),
                          IconButton(
                            icon: const Icon(Icons.person, size: 20),
                            onPressed: () {},
                            color: AppTheme.tertiaryForeground,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 80,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: TaskDataUtils.dateChips.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final chip = TaskDataUtils.dateChips[index];
                        return CalendarChip(
                          day: chip.day,
                          date: chip.date,
                          isSelected: index == _selectedDateIndex,
                          onClick: () => setState(() => _selectedDateIndex = index),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Stack(
                  children: [
                    Positioned(
                      left: 8,
                      top: 0,
                      bottom: 0,
                      width: 2,
                      child: Container(color: AppTheme.progressTrack),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 24),
                      child: Column(
                        children: TaskDataUtils.taskData.map((task) {
                          return Stack(
                            children: [
                              Positioned(
                                left: -32,
                                top: 24,
                                child: Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: AppTheme.primary,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppTheme.background,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: TaskCard(
                                  time: task.time,
                                  title: task.title,
                                  description: task.description,
                                  status: task.status,
                                  buttonText: task.buttonText,
                                  isPrimary: task.isPrimary,
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 96),
          ],
        ),
      ),
    );
  }

  String _getDayOfWeek(String day) {
    switch (day) {
      case 'Mon':
        return 'Monday';
      case 'Tue':
        return 'Tuesday';
      case 'Wed':
        return 'Wednesday';
      case 'Thu':
        return 'Thursday';
      case 'Fri':
        return 'Friday';
      case 'Sat':
        return 'Saturday';
      case 'Sun':
        return 'Sunday';
      default:
        return day;
    }
  }
}


