import 'dashboard_data.dart';

class Task {
  final String id;
  final String time;
  final String title;
  final String description;
  final TaskStatus status;
  final String buttonText;
  final bool isPrimary;

  Task({
    required this.id,
    required this.time,
    required this.title,
    required this.description,
    required this.status,
    required this.buttonText,
    this.isPrimary = false,
  });
}

class DateChip {
  final String id;
  final String day;
  final int date;
  final String fullDate;

  DateChip({
    required this.id,
    required this.day,
    required this.date,
    required this.fullDate,
  });
}

class TaskDataUtils {
  static List<Task> get taskData => [
        Task(
          id: '1',
          time: '10.00am',
          title: 'Wireframing',
          description: 'Make sure ideation from sketch and wireframes are ready for design phase.',
          status: TaskStatus.done,
          buttonText: 'Check summary',
          isPrimary: false,
        ),
        Task(
          id: '2',
          time: '12.00pm',
          title: 'UI Design',
          description: 'Create high-fidelity mockups based on approved wireframes and brand guidelines.',
          status: TaskStatus.inProgress,
          buttonText: 'Check process',
          isPrimary: true,
        ),
        Task(
          id: '3',
          time: '2.30pm',
          title: 'Usability Testing',
          description: 'Conduct user testing sessions to validate design decisions and gather feedback.',
          status: TaskStatus.pending,
          buttonText: 'Check summary',
          isPrimary: false,
        ),
        Task(
          id: '4',
          time: '4.00pm',
          title: 'Design Review',
          description: 'Present final designs to stakeholders and incorporate feedback.',
          status: TaskStatus.pending,
          buttonText: 'Check summary',
          isPrimary: false,
        ),
      ];

  static List<DateChip> get dateChips => [
        DateChip(id: '1', day: 'Tue', date: 23, fullDate: 'July 23, 2024'),
        DateChip(id: '2', day: 'Wed', date: 24, fullDate: 'July 24, 2024'),
        DateChip(id: '3', day: 'Thu', date: 25, fullDate: 'July 25, 2024'),
        DateChip(id: '4', day: 'Fri', date: 26, fullDate: 'July 26, 2024'),
        DateChip(id: '5', day: 'Sat', date: 27, fullDate: 'July 27, 2024'),
        DateChip(id: '6', day: 'Sun', date: 28, fullDate: 'July 28, 2024'),
        DateChip(id: '7', day: 'Mon', date: 29, fullDate: 'July 29, 2024'),
      ];
}

