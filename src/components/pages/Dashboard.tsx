/**
 * Dashboard - 仪表板主页面（重构版）
 * iPhone 15 Pro (390×844pt) 暗色HUD风格
 * 
 * 结构顺序：
 * 1. 日期头部 & 水平日历
 * 2. 顶部双卡片（左：进度+任务列表；右：财报）
 * 3. AI 角色占位（上移）
 * 4. 浮起底栏导航
 * 
 * 改动：
 * - 删除原任务时间线区块
 * - 左侧进度卡片整合任务标题列表
 * - AI区域上移至第3位
 */

import { useState } from 'react';
import { DateHeader } from '../molecules/DateHeader';
import { CalendarChip } from '../CalendarChip';
import { ProgressCardLeft } from '../molecules/ProgressCardLeft';
import { FinanceCard } from '../molecules/FinanceCard';
import { VASection } from '../molecules/VASection';
import {
  getCurrentDateInfo,
  generateDateChips,
  defaultDailyProgress,
  mockFinanceData,
  defaultVAData,
} from '../DashboardData';

interface DashboardProps {
  onLogout?: () => void;
  username?: string;
  onNavigateToTodo?: () => void;
}

export function Dashboard({ onLogout, username, onNavigateToTodo }: DashboardProps) {
  const [selectedDateId, setSelectedDateId] = useState('date-0'); // 默认选中今天
  const [dateInfo] = useState(getCurrentDateInfo());
  const [dateChips] = useState(generateDateChips());
  const [financeData, setFinanceData] = useState(mockFinanceData);
  const [isFinanceLoading, setIsFinanceLoading] = useState(false);

  // 模拟财报数据刷新
  const handleRefreshFinance = () => {
    setIsFinanceLoading(true);
    setTimeout(() => {
      setFinanceData({
        ...mockFinanceData,
        price: mockFinanceData.price + (Math.random() - 0.5) * 2,
        changePct: mockFinanceData.changePct + (Math.random() - 0.5) * 0.5,
        lastUpdate: new Date().toLocaleTimeString('en-US', {
          hour: '2-digit',
          minute: '2-digit',
        }),
      });
      setIsFinanceLoading(false);
    }, 1000);
  };

  // 处理任务点击 - 跳转到 To-do 页面
  // 注释：携带 filter=date=today & taskId 参数
  const handleTaskClick = (taskId: string) => {
    console.log(`Navigate to To-do with taskId: ${taskId}, filter: date=today`);
    onNavigateToTodo?.();
  };

  // 处理查看全部 To-do
  const handleViewAllTodos = () => {
    console.log('Navigate to To-do with filter: date=today');
    onNavigateToTodo?.();
  };

  // 处理创建任务
  const handleCreateTask = () => {
    console.log('Navigate to To-do (create mode)');
    onNavigateToTodo?.();
  };

  // 处理日期芯片点击
  // 注释：切换后过滤 tasks_today 来源
  const handleDateSelect = (chipId: string) => {
    setSelectedDateId(chipId);
    console.log(`Date selected: ${chipId}, filter tasks_today accordingly`);
  };

  return (
    <div className="min-h-screen bg-background">
      {/* 主内容区域 - 带底部导航间距 */}
      <div className="h-screen overflow-y-auto scrollbar-hide pb-32 px-4 pt-12">
        {/* ① 日期头部 */}
        <DateHeader
          weekday={dateInfo.weekday}
          fullDate={dateInfo.fullDate}
          onCalendarClick={() => console.log('Open calendar')}
          onProfileClick={() => console.log('Open profile')}
        />

        {/* 水平日历 - CalendarChip */}
        <div className="mb-6 overflow-x-auto scrollbar-hide -mx-4 px-4">
          <div className="flex gap-2 pb-2">
            {dateChips.map((chip) => (
              <CalendarChip
                key={chip.id}
                day={chip.day}
                date={chip.date}
                isSelected={chip.id === selectedDateId}
                onClick={() => handleDateSelect(chip.id)}
              />
            ))}
          </div>
        </div>

        {/* ② 顶部双卡片 - 两列等宽，间距 12 */}
        <div className="grid grid-cols-2 gap-3 mb-6">
          {/* A. 左侧进度卡片 - 整合任务列表 */}
          <ProgressCardLeft
            dailyProgressPct={defaultDailyProgress.dailyProgressPct}
            doneCount={defaultDailyProgress.doneCount}
            totalCount={defaultDailyProgress.totalCount}
            tasksToday={defaultDailyProgress.tasksToday}
            showList={true}
            maxVisible={4}
            onTaskClick={handleTaskClick}
            onViewAll={handleViewAllTodos}
            onCreateTask={handleCreateTask}
          />

          {/* B. 右侧财报卡片 */}
          <FinanceCard
            data={financeData}
            isLoading={isFinanceLoading}
            onRefresh={handleRefreshFinance}
            onViewDetails={() => console.log('View finance details')}
          />
        </div>

        {/* ③ Virtual Assistant - 上移至此位置 */}
        <div className="mb-6">
          <VASection
            vaStatus={defaultVAData.vaStatus}
            onSettingsClick={() => console.log('VA settings')}
            onInteract={() => console.log('VA interact')}
          />
        </div>
      </div>
    </div>
  );
}
