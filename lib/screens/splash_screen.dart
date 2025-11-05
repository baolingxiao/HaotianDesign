import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/atoms/progress_ring.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onComplete;

  const SplashScreen({
    super.key,
    required this.onComplete,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  double _progress = 0.0;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    // 立即开始动画
    _simulateLoading();
  }

  void _simulateLoading() {
    // 使用动画控制器驱动进度
    _controller.addListener(() {
      if (mounted) {
        setState(() {
          _progress = _controller.value * 100;
        });
      }
    });

    // 立即开始动画
    _controller.forward().then((_) {
      // 加载完成，延迟一点再跳转
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          widget.onComplete();
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppTheme.background,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppTheme.background,
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
            // 应用图标或Logo
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppTheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: AppTheme.primary,
                  width: 2,
                ),
              ),
              child: const Icon(
                Icons.calendar_today,
                size: 60,
                color: AppTheme.primary,
              ),
            ),
            const SizedBox(height: 40),
            
            // 应用名称
            const Text(
              '日历与任务列表',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppTheme.foreground,
              ),
            ),
            const SizedBox(height: 60),

            // 进度环
            ProgressRing(
              percentage: _progress,
              size: 140,
              strokeWidth: 12,
            ),
            const SizedBox(height: 40),

            // 加载文字
            Text(
              _getLoadingText(_progress),
              style: const TextStyle(
                fontSize: 16,
                color: AppTheme.mutedForeground,
              ),
            ),
            const SizedBox(height: 20),

            // 进度百分比文本（额外显示）
            Text(
              '${_progress.round()}%',
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.tertiaryForeground,
              ),
            ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getLoadingText(double progress) {
    if (progress < 30) {
      return '正在初始化...';
    } else if (progress < 60) {
      return '正在加载数据...';
    } else if (progress < 90) {
      return '正在准备界面...';
    } else {
      return '即将完成...';
    }
  }
}

