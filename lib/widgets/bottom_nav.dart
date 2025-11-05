import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum TabItem { home, todo, profile }

class BottomNav extends StatelessWidget {
  final TabItem activeTab;
  final ValueChanged<TabItem> onTabChange;

  const BottomNav({
    super.key,
    required this.activeTab,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 24,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: AppTheme.card.withOpacity(0.95),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppTheme.border),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _NavButton(
                icon: Icons.home,
                label: 'Home',
                isActive: activeTab == TabItem.home,
                onTap: () => onTabChange(TabItem.home),
              ),
              const SizedBox(width: 6),
              _NavButton(
                icon: Icons.check_box_outlined,
                label: 'To-do',
                isActive: activeTab == TabItem.todo,
                onTap: () => onTabChange(TabItem.todo),
              ),
              const SizedBox(width: 6),
              _NavButton(
                icon: Icons.person,
                label: 'Profile',
                isActive: activeTab == TabItem.profile,
                onTap: () => onTabChange(TabItem.profile),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavButton({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: isActive ? AppTheme.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: isActive
                    ? AppTheme.primaryForeground
                    : AppTheme.mutedForeground,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: isActive
                      ? AppTheme.primaryForeground
                      : AppTheme.mutedForeground,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


