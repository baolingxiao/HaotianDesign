class UserProfile {
  final String username;
  final String email;
  final String joinDate;
  final int level;
  final int xp;
  final int maxXp;
  final int tasksCompleted;
  final int totalTasks;
  final String membershipLevel;

  UserProfile({
    required this.username,
    required this.email,
    required this.joinDate,
    required this.level,
    required this.xp,
    required this.maxXp,
    required this.tasksCompleted,
    required this.totalTasks,
    required this.membershipLevel,
  });

  static UserProfile get defaultUser => UserProfile(
        username: 'john_doe',
        email: 'john@example.com',
        joinDate: '2024年1月',
        level: 4,
        xp: 2450,
        maxXp: 3000,
        tasksCompleted: 8,
        totalTasks: 12,
        membershipLevel: '高级会员',
      );
}


