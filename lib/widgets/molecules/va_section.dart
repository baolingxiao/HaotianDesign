import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/dashboard_data.dart';

class VASection extends StatelessWidget {
  final VAStatus vaStatus;
  final String? placeholderImg;
  final VoidCallback? onSettingsClick;
  final VoidCallback? onInteract;

  const VASection({
    super.key,
    this.vaStatus = VAStatus.online,
    this.placeholderImg,
    this.onSettingsClick,
    this.onInteract,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    'Virtual Assistant',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppTheme.foreground,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: vaStatus == VAStatus.online
                              ? AppTheme.success
                              : AppTheme.mutedForeground,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        vaStatus == VAStatus.online ? 'Online' : 'Offline',
                        style: TextStyle(
                          fontSize: 10,
                          color: vaStatus == VAStatus.online
                              ? AppTheme.success
                              : AppTheme.mutedForeground,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.more_vert, size: 16),
                onPressed: onSettingsClick,
                color: AppTheme.mutedForeground,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onInteract,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: AppTheme.secondary.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.border),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.sentiment_satisfied,
                        size: 32,
                        color: AppTheme.primary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Live2D avatar will render here',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.mutedForeground,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'WebView integration coming soon',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.tertiaryForeground,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Center(
            child: Text(
              'Click to interact • Hover for expressions',
              style: TextStyle(
                fontSize: 11,
                color: AppTheme.tertiaryForeground,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


