import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class ModeToggle extends StatelessWidget {
  final List<String> options;
  final String selected;
  final ValueChanged<String> onSelect;

  const ModeToggle({
    super.key,
    required this.options,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: options.map((option) {
        final isSelected = selected == option;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ElevatedButton(
              onPressed: () => onSelect(option),
              style: ElevatedButton.styleFrom(
                backgroundColor: isSelected ? AppTheme.primary : Colors.transparent,
                foregroundColor: isSelected ? AppTheme.primaryForeground : AppTheme.mutedForeground,
                elevation: 0,
                side: BorderSide(
                  color: isSelected ? AppTheme.primary : AppTheme.border,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
              child: Text(option),
            ),
          ),
        );
      }).toList(),
    );
  }
}


