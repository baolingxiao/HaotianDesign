class DateChipData {
  final String id;
  final String day;
  final int date;
  final String fullDate;

  DateChipData({
    required this.id,
    required this.day,
    required this.date,
    required this.fullDate,
  });
}

class TodayTask {
  final String id;
  final String title;
  final TaskStatus status;

  TodayTask({
    required this.id,
    required this.title,
    required this.status,
  });
}

enum TaskStatus {
  pending,
  inProgress,
  done,
}

class DailyProgressData {
  final double dailyProgressPct; // 0-100
  final int doneCount;
  final int totalCount;
  final List<TodayTask>? tasksToday;

  DailyProgressData({
    required this.dailyProgressPct,
    required this.doneCount,
    required this.totalCount,
    this.tasksToday,
  });
}

class FinanceData {
  final double price;
  final double changePct;
  final int volume;
  final String lastUpdate;
  final List<FinancePoint> seriesIntraday;

  FinanceData({
    required this.price,
    required this.changePct,
    required this.volume,
    required this.lastUpdate,
    required this.seriesIntraday,
  });
}

class FinancePoint {
  final String t; // time
  final double v; // value

  FinancePoint({required this.t, required this.v});
}

class TimelineTask {
  final String taskId;
  final String title;
  final String desc;
  final String time;
  final TaskStatus status;
  final bool isActive;
  final String? buttonText;

  TimelineTask({
    required this.taskId,
    required this.title,
    required this.desc,
    required this.time,
    required this.status,
    this.isActive = false,
    this.buttonText,
  });
}

class VAData {
  final VAStatus vaStatus;
  final String? placeholderImg;
  final String? placeholderUrl;

  VAData({
    required this.vaStatus,
    this.placeholderImg,
    this.placeholderUrl,
  });
}

enum VAStatus {
  online,
  offline,
}

// 工具函数
class DashboardDataUtils {
  static Map<String, dynamic> getCurrentDateInfo() {
    final today = DateTime.now();
    final weekdays = [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday'
    ];
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return {
      'weekday': weekdays[today.weekday % 7],
      'fullDate': '${months[today.month - 1]} ${today.day}, ${today.year}',
    };
  }

  static List<DateChipData> generateDateChips() {
    final today = DateTime.now();
    final weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    final chips = <DateChipData>[];

    for (int i = -3; i <= 3; i++) {
      final date = today.add(Duration(days: i));
      chips.add(DateChipData(
        id: 'date-$i',
        day: weekdays[date.weekday % 7],
        date: date.day,
        fullDate: date.toIso8601String().split('T')[0],
      ));
    }

    return chips;
  }

  static List<TodayTask> get defaultTodayTasks => [
        TodayTask(
          id: 'task-1',
          title: 'Watch introduction video',
          status: TaskStatus.done,
        ),
        TodayTask(
          id: 'task-2',
          title: 'UI Design Sprint',
          status: TaskStatus.inProgress,
        ),
        TodayTask(
          id: 'task-3',
          title: 'Complete chapter 1 exercises',
          status: TaskStatus.pending,
        ),
        TodayTask(
          id: 'task-4',
          title: 'Read documentation',
          status: TaskStatus.pending,
        ),
        TodayTask(
          id: 'task-5',
          title: 'Team standup meeting',
          status: TaskStatus.pending,
        ),
      ];

  static DailyProgressData get defaultDailyProgress => DailyProgressData(
        dailyProgressPct: 75,
        doneCount: 12,
        totalCount: 16,
        tasksToday: defaultTodayTasks,
      );

  static FinanceData get mockFinanceData => FinanceData(
        price: 68.42,
        changePct: 2.35,
        volume: 3250000,
        lastUpdate: '15:30',
        seriesIntraday: [
          FinancePoint(t: '09:30', v: 66.8),
          FinancePoint(t: '10:00', v: 67.2),
          FinancePoint(t: '11:00', v: 66.5),
          FinancePoint(t: '12:00', v: 67.8),
          FinancePoint(t: '13:00', v: 68.5),
          FinancePoint(t: '14:00', v: 67.9),
          FinancePoint(t: '15:00', v: 68.2),
          FinancePoint(t: '15:30', v: 68.42),
        ],
      );

  static List<TimelineTask> get defaultTimelineTasks => [
        TimelineTask(
          taskId: '1',
          title: 'Watch introduction video',
          desc: 'Complete the onboarding video to understand platform features and capabilities.',
          time: '10:00',
          status: TaskStatus.done,
          buttonText: 'Check summary',
        ),
        TimelineTask(
          taskId: '2',
          title: 'UI Design Sprint',
          desc: 'Create high-fidelity mockups based on approved wireframes and brand guidelines.',
          time: '12:00',
          status: TaskStatus.inProgress,
          isActive: true,
          buttonText: 'Check process',
        ),
        TimelineTask(
          taskId: '3',
          title: 'Complete chapter 1 exercises',
          desc: 'Finish all practice exercises in the first chapter to reinforce learning concepts.',
          time: '14:30',
          status: TaskStatus.pending,
          buttonText: 'Check summary',
        ),
        TimelineTask(
          taskId: '4',
          title: 'Read documentation',
          desc: 'Review technical documentation and API references for the next development phase.',
          time: '16:00',
          status: TaskStatus.pending,
          buttonText: 'Check summary',
        ),
      ];

  static VAData get defaultVAData => VAData(
        vaStatus: VAStatus.online,
      );
}


