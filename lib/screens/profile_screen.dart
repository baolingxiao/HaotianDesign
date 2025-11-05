import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/user_data.dart';

class ProfileScreen extends StatelessWidget {
  final String username;
  final VoidCallback? onLogout;

  const ProfileScreen({
    super.key,
    required this.username,
    this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final user = UserProfile.defaultUser;
    final statsData = [
      {'label': 'Level', 'value': user.level.toString(), 'icon': Icons.stars},
      {'label': 'XP', 'value': user.xp.toString(), 'icon': Icons.stars},
      {
        'label': 'Tasks Done',
        'value': '${user.tasksCompleted}/${user.totalTasks}',
        'icon': Icons.stars
      },
    ];

    final accountInfo = [
      {'label': '用户名', 'value': username, 'icon': Icons.person},
      {'label': '邮箱', 'value': user.email, 'icon': Icons.mail},
      {'label': '加入日期', 'value': user.joinDate, 'icon': Icons.calendar_today},
    ];

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 48, left: 24, right: 24, bottom: 128),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '我的档案',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.foreground,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                '管理你的个人信息',
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.mutedForeground,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppTheme.card,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.border),
                ),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 96,
                          height: 96,
                          decoration: BoxDecoration(
                            color: AppTheme.primary.withOpacity(0.2),
                            shape: BoxShape.circle,
                            border: Border.all(color: AppTheme.primary, width: 2),
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 48,
                            color: AppTheme.primary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          username,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.foreground,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          user.membershipLevel,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppTheme.mutedForeground,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: statsData.map((stat) {
                        return Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppTheme.background,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppTheme.border),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  stat['icon'] as IconData,
                                  size: 20,
                                  color: AppTheme.primary,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  stat['value'] as String,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: AppTheme.foreground,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  stat['label'] as String,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppTheme.tertiaryForeground,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                    ...accountInfo.asMap().entries.map((entry) {
                      final index = entry.key;
                      final info = entry.value;
                      return Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                info['icon'] as IconData,
                                size: 20,
                                color: AppTheme.tertiaryForeground,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      info['label'] as String,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: AppTheme.tertiaryForeground,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      info['value'] as String,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: AppTheme.foreground,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          if (index < accountInfo.length - 1) ...[
                            const SizedBox(height: 16),
                            Container(
                              height: 1,
                              color: AppTheme.divider.withOpacity(0.2),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ],
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.card,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppTheme.border),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.settings, size: 20, color: AppTheme.tertiaryForeground),
                        const SizedBox(width: 12),
                        const Text(
                          '设置',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppTheme.foreground,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onLogout,
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.card,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppTheme.border),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.logout, size: 20, color: AppTheme.destructive),
                        const SizedBox(width: 12),
                        const Text(
                          '退出登录',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppTheme.destructive,
                          ),
                        ),
                      ],
                    ),
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


