import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../theme/app_theme.dart';
import '../../models/dashboard_data.dart';

class FinanceCard extends StatefulWidget {
  final FinanceData? data;
  final bool isLoading;
  final String? error;
  final VoidCallback? onRefresh;
  final VoidCallback? onViewDetails;

  const FinanceCard({
    super.key,
    this.data,
    this.isLoading = false,
    this.error,
    this.onRefresh,
    this.onViewDetails,
  });

  @override
  State<FinanceCard> createState() => _FinanceCardState();
}

class _FinanceCardState extends State<FinanceCard> {
  bool _isRefreshing = false;

  void _handleRefresh() {
    setState(() => _isRefreshing = true);
    widget.onRefresh?.call();
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) setState(() => _isRefreshing = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.error != null) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.border),
        ),
        child: Column(
          children: [
            Text(
              '加载失败',
              style: TextStyle(color: AppTheme.destructive, fontSize: 14),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _handleRefresh,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.secondary,
                foregroundColor: AppTheme.secondaryForeground,
              ),
              child: const Text('重试'),
            ),
          ],
        ),
      );
    }

    if (widget.isLoading || widget.data == null) {
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.border),
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
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withOpacity(0.2),
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
                    IconButton(
                      icon: Transform.rotate(
                        angle: _isRefreshing ? 3.14159 * 2 : 0,
                        child: const Icon(Icons.refresh, size: 14),
                      ),
                      onPressed: _handleRefresh,
                      color: AppTheme.mutedForeground,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 80,
            child: LineChart(
              LineChartData(
                lineBarsData: [
                  LineChartBarData(
                    spots: data.seriesIntraday.asMap().entries.map((e) {
                      return FlSpot(e.key.toDouble(), e.value.v);
                    }).toList(),
                    isCurved: true,
                    color: isPositive ? AppTheme.success : AppTheme.destructive,
                    barWidth: 2,
                    dotData: const FlDotData(show: false),
                  ),
                ],
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                gridData: const FlGridData(show: false),
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
                  color: AppTheme.secondary.withOpacity(0.5),
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
        color: AppTheme.background.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
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
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  color: valueColor ?? AppTheme.foreground,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


