/**
 * Dashboard Components Index
 * 统一导出所有 Dashboard 相关组件
 */

// 原子组件
export { ProgressRing } from '../atoms/ProgressRing';
export { TaskTitleItem } from '../atoms/TaskTitleItem';

// 分子组件
export { DateHeader } from '../molecules/DateHeader';
export { DailyProgressCard } from '../molecules/DailyProgressCard';
export { ProgressCardLeft } from '../molecules/ProgressCardLeft';
export { FinanceCard } from '../molecules/FinanceCard';
export { TimelineTaskCard } from '../molecules/TimelineTaskCard';
export { VASection } from '../molecules/VASection';

// 共享组件
export { CalendarChip } from '../CalendarChip';
export { BottomNav } from '../BottomNav';

// 页面组件
export { Dashboard } from '../pages/Dashboard';

// 数据管理
export {
  getCurrentDateInfo,
  generateDateChips,
  defaultDailyProgress,
  mockFinanceData,
  defaultTimelineTasks,
  defaultVAData,
} from '../DashboardData';

export type {
  DateChipData,
  DailyProgressData,
  TodayTask,
  FinanceData,
  TimelineTask,
  VAData,
} from '../DashboardData';
