import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'dashboard_data.dart';
import 'widgets/date_header.dart';
import 'widgets/calendar_chip.dart';
import 'widgets/progress_card_left.dart';
import 'widgets/finance_card.dart';
import 'widgets/va_section.dart';

class DashboardScreen extends StatefulWidget {
  final VoidCallback? onLogout;
  final String? username;
  final VoidCallback? onNavigateToTodo;

  const DashboardScreen({
    super.key,
    this.onLogout,
    this.username,
    this.onNavigateToTodo,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Map<String, dynamic> _dateInfo;
  late List<DateChipData> _dateChips;
  String _selectedDateId = 'date-0';
  FinanceData _financeData = DashboardDataUtils.mockFinanceData;
  bool _isRefreshingFinance = false;

  @override
  void initState() {
    super.initState();
    debugPrint('DashboardScreen initState -> starting');
    try {
      _dateInfo = DashboardDataUtils.getCurrentDateInfo();
      _dateChips = DashboardDataUtils.generateDateChips();
      debugPrint('DashboardScreen initState -> dateInfo=$_dateInfo, chips=${_dateChips.length}');
      // 预设今天为选中
      final todayIndex = _dateChips.indexWhere((chip) => chip.id == 'date-0');
      if (todayIndex >= 0) {
        _selectedDateId = _dateChips[todayIndex].id;
      }
      debugPrint('DashboardScreen initState -> selectedDateId=$_selectedDateId');
    } catch (e, stack) {
      debugPrint('DashboardScreen initState ERROR: $e');
      debugPrint('Stack: $stack');
    }
  }

  void _handleDateSelect(String chipId) {
    setState(() => _selectedDateId = chipId);
  }

  void _handleRefreshFinance() {
    if (_isRefreshingFinance) return;
    setState(() => _isRefreshingFinance = true);
    Future.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      setState(() {
        final base = DashboardDataUtils.mockFinanceData;
        final delta = (DateTime.now().millisecondsSinceEpoch % 100 - 50) * 0.05;
        _financeData = FinanceData(
          price: base.price + delta,
          changePct: base.changePct + delta / 10,
          volume: base.volume,
          lastUpdate: DateTime.now().toString().substring(11, 16),
          seriesIntraday: base.seriesIntraday.map((p) {
            return FinancePoint(
              t: p.t,
              v: p.v + (delta * 0.1),
            );
          }).toList(),
        );
        _isRefreshingFinance = false;
      });
    });
  }

  void _handleTaskClick(String taskId) {
    widget.onNavigateToTodo?.call();
  }

  void _handleViewAllTodos() {
    widget.onNavigateToTodo?.call();
  }

  void _handleCreateTask() {
    widget.onNavigateToTodo?.call();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('DashboardScreen build -> rendering dashboard, dateChips=${_dateChips.length}, financeData=${_financeData.price}');
    debugPrint('DashboardScreen build -> background=${AppTheme.background}, foreground=${AppTheme.foreground}');
    try {
      return Scaffold(
        backgroundColor: AppTheme.background,
        body: SafeArea(
          bottom: false, // Let BottomNav handle bottom spacing
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 24,
              bottom: 100, // Add bottom padding to avoid BottomNav overlap
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'TEST 1: RED TEXT',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'TEST 2: BLUE TEXT - ${_dateInfo['weekday']}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'TEST 3: GREEN TEXT - Before DateHeader',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 8),
                // Only add DateHeader, wrapped in try-catch
                Builder(
                  builder: (context) {
                    try {
                      return DateHeader(
                        weekday: _dateInfo['weekday'],
                        fullDate: _dateInfo['fullDate'],
                        onCalendarClick: () {},
                        onProfileClick: widget.onLogout,
                      );
                    } catch (e) {
                      debugPrint('DateHeader ERROR: $e');
                      return Container(
                        padding: const EdgeInsets.all(16),
                        color: Colors.red.withOpacity(0.3),
                        child: Text('DateHeader Error: $e'),
                      );
                    }
                  },
                ),
                const SizedBox(height: 24),
                const Text(
                  'TEST 4: ORANGE TEXT - After DateHeader',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'TEST 5: TEAL TEXT - Before CalendarChips',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 8),
                Builder(
                  builder: (context) {
                    try {
                      return SizedBox(
                        height: 80,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: _dateChips.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 8),
                          itemBuilder: (context, index) {
                            final chip = _dateChips[index];
                            return CalendarChip(
                              day: chip.day,
                              date: chip.date,
                              isSelected: chip.id == _selectedDateId,
                              onClick: () => _handleDateSelect(chip.id),
                            );
                          },
                        ),
                      );
                    } catch (e) {
                      debugPrint('CalendarChips ERROR: $e');
                      return Container(
                        padding: const EdgeInsets.all(16),
                        color: Colors.red.withOpacity(0.3),
                        child: Text('CalendarChips Error: $e'),
                      );
                    }
                  },
                ),
                const SizedBox(height: 24),
                const Text(
                  'TEST 6: TEAL TEXT - After CalendarChips',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'TEST 7: PINK TEXT - Before Simple Card Test',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.pink,
                  ),
                ),
                const SizedBox(height: 8),
                // Test simple card first
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.card,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppTheme.border),
                  ),
                  child: const Text(
                    'Simple Card Test - Should see this',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppTheme.foreground,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'TEST 8: PINK TEXT - After Simple Card',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.pink,
                  ),
                ),
              ],
          ),
        ),
      ),
    );
    } catch (e, stack) {
      debugPrint('DashboardScreen build ERROR: $e');
      debugPrint('Stack: $stack');
      return Scaffold(
        backgroundColor: AppTheme.background,
        body: Center(
          child: Text(
            'Error: $e',
            style: const TextStyle(color: Colors.red),
          ),
        ),
      );
    }
  }
}

