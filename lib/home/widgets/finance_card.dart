import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../theme/app_theme.dart';
import '../dashboard_data.dart';

class FinanceCard extends StatefulWidget {
  final FinanceData? data;
  final bool isLoading;
  final VoidCallback? onRefresh;
  final VoidCallback? onViewDetails;

  const FinanceCard({
    super.key,
    this.data,
    this.isLoading = false,
    this.onRefresh,
    this.onViewDetails,
  });

  @override
  State<FinanceCard> createState() => _FinanceCardState();
}

class _FinanceCardState extends State<FinanceCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  void _handleRefresh() {
    if (_isRefreshing) return;
    setState(() => _isRefreshing = true);
    _rotationController.repeat();
    widget.onRefresh?.call();
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() => _isRefreshing = false);
        _rotationController.stop();
        _rotationController.reset();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data == null) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.border),
        ),
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    final data = widget.data!;
    final isPositive = data.changePct >= 0;

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(
                child: Text(
                  '今日财报',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.foreground,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.primary.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Real-time',
                      style: TextStyle(
                        fontSize: 10,
                        color: AppTheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  AnimatedBuilder(
                    animation: _rotationController,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _rotationController.value * 2 * math.pi,
                        child: IconButton(
                          icon: const Icon(Icons.refresh, size: 14),
                          onPressed: _handleRefresh,
                          color: AppTheme.mutedForeground,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 80,
            child: CustomPaint(
              painter: _FinanceChartPainter(
                series: data.seriesIntraday,
                isPositive: isPositive,
              ),
            ),
          ),
          const SizedBox(height: 12),
          IntrinsicHeight(
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 2.2,
              children: [
                _MetricItem(
                  label: '价格',
                  value: '\$${data.price.toStringAsFixed(2)}',
                ),
                _MetricItem(
                  label: '涨跌幅',
                  value: '${isPositive ? '+' : ''}${data.changePct.toStringAsFixed(2)}%',
                  valueColor: isPositive ? AppTheme.success : AppTheme.destructive,
                  icon: isPositive ? Icons.trending_up : Icons.trending_down,
                ),
                _MetricItem(
                  label: '成交量',
                  value: '${(data.volume / 1000000).toStringAsFixed(2)}M',
                ),
                _MetricItem(
                  label: '更新时间',
                  value: data.lastUpdate,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onViewDetails,
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
                      '查看详情',
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
          ),
          const SizedBox(height: 8),
          const Center(
            child: Text(
              'Data source: Fidelity API',
              style: TextStyle(
                fontSize: 9,
                color: AppTheme.tertiaryForeground,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FinanceChartPainter extends CustomPainter {
  final List<FinancePoint> series;
  final bool isPositive;

  _FinanceChartPainter({
    required this.series,
    required this.isPositive,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (series.isEmpty) return;

    final values = series.map((p) => p.v).toList();
    final minVal = values.reduce(math.min);
    final maxVal = values.reduce(math.max);
    final range = maxVal - minVal;
    final normalized = range > 0
        ? values.map((v) => (v - minVal) / range).toList()
        : List.filled(values.length, 0.5);

    final path = Path();
    final stepX = size.width / (normalized.length - 1);

    for (int i = 0; i < normalized.length; i++) {
      final x = i * stepX;
      final y = size.height - (normalized[i] * size.height * 0.8 + size.height * 0.1);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    final paint = Paint()
      ..color = isPositive ? AppTheme.success : AppTheme.destructive
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _MetricItem extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final IconData? icon;

  const _MetricItem({
    required this.label,
    required this.value,
    this.valueColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppTheme.background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              color: AppTheme.mutedForeground,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon, size: 12, color: valueColor ?? AppTheme.foreground),
                const SizedBox(width: 4),
              ],
              Flexible(
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: valueColor ?? AppTheme.foreground,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

