/**
 * DashboardData - Dashboard 页面数据管理
 * 统一管理仪表板所有数据，确保页面间数据一致性
 */

// 日期数据
export interface DateChipData {
  id: string;
  day: string;
  date: number;
  fullDate: string;
}

// 今日任务简化版（仅标题）
export interface TodayTask {
  id: string;
  title: string;
  status: 'pending' | 'in_progress' | 'done';
}

// 今日进度数据
export interface DailyProgressData {
  dailyProgressPct: number; // 0-100
  doneCount: number;
  totalCount: number;
  tasksToday?: TodayTask[]; // 今日任务列表
}

// 财报数据
export interface FinanceData {
  price: number;
  changePct: number;
  volume: number;
  lastUpdate: string;
  seriesIntraday: Array<{ t: string; v: number }>;
}

// 任务时间线数据
export interface TimelineTask {
  taskId: string;
  title: string;
  desc: string;
  time: string;
  status: 'done' | 'in_progress' | 'pending';
  isActive?: boolean;
  buttonText?: string;
}

// VA状态数据
export interface VAData {
  vaStatus: 'online' | 'offline';
  placeholderImg?: string;
  placeholderUrl?: string;
}

// 获取当前日期信息
export function getCurrentDateInfo() {
  const today = new Date();
  const weekdays = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
  const months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  return {
    weekday: weekdays[today.getDay()],
    fullDate: `${months[today.getMonth()]} ${today.getDate()}, ${today.getFullYear()}`,
  };
}

// 生成日期芯片数据
export function generateDateChips(): DateChipData[] {
  const today = new Date();
  const weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  const chips: DateChipData[] = [];

  for (let i = -3; i <= 3; i++) {
    const date = new Date(today);
    date.setDate(today.getDate() + i);
    
    chips.push({
      id: `date-${i}`,
      day: weekdays[date.getDay()],
      date: date.getDate(),
      fullDate: date.toLocaleDateString(),
    });
  }

  return chips;
}

// 默认今日任务数据
export const defaultTodayTasks: TodayTask[] = [
  {
    id: 'task-1',
    title: 'Watch introduction video',
    status: 'done',
  },
  {
    id: 'task-2',
    title: 'UI Design Sprint',
    status: 'in_progress',
  },
  {
    id: 'task-3',
    title: 'Complete chapter 1 exercises',
    status: 'pending',
  },
  {
    id: 'task-4',
    title: 'Read documentation',
    status: 'pending',
  },
  {
    id: 'task-5',
    title: 'Team standup meeting',
    status: 'pending',
  },
];

// 默认今日进度数据
export const defaultDailyProgress: DailyProgressData = {
  dailyProgressPct: 75,
  doneCount: 12,
  totalCount: 16,
  tasksToday: defaultTodayTasks,
};

// 模拟财报数据
export const mockFinanceData: FinanceData = {
  price: 68.42,
  changePct: 2.35,
  volume: 3250000,
  lastUpdate: '15:30',
  seriesIntraday: [
    { t: '09:30', v: 66.8 },
    { t: '10:00', v: 67.2 },
    { t: '11:00', v: 66.5 },
    { t: '12:00', v: 67.8 },
    { t: '13:00', v: 68.5 },
    { t: '14:00', v: 67.9 },
    { t: '15:00', v: 68.2 },
    { t: '15:30', v: 68.42 },
  ],
};

// 默认任务时间线数据
export const defaultTimelineTasks: TimelineTask[] = [
  {
    taskId: '1',
    title: 'Watch introduction video',
    desc: 'Complete the onboarding video to understand platform features and capabilities.',
    time: '10:00',
    status: 'done',
    buttonText: 'Check summary',
  },
  {
    taskId: '2',
    title: 'UI Design Sprint',
    desc: 'Create high-fidelity mockups based on approved wireframes and brand guidelines.',
    time: '12:00',
    status: 'in_progress',
    isActive: true,
    buttonText: 'Check process',
  },
  {
    taskId: '3',
    title: 'Complete chapter 1 exercises',
    desc: 'Finish all practice exercises in the first chapter to reinforce learning concepts.',
    time: '14:30',
    status: 'pending',
    buttonText: 'Check summary',
  },
  {
    taskId: '4',
    title: 'Read documentation',
    desc: 'Review technical documentation and API references for the next development phase.',
    time: '16:00',
    status: 'pending',
    buttonText: 'Check summary',
  },
];

// 默认VA数据
export const defaultVAData: VAData = {
  vaStatus: 'online',
  placeholderUrl: '',
};
