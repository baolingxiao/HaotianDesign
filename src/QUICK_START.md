# Dashboard 快速开始指南

## 🚀 快速预览

运行应用后，Dashboard页面将显示：

1. **日期头部** - 显示当前星期和日期
2. **水平日历** - 可选择的日期芯片 (默认选中今天)
3. **今日目标进度卡** - 环形进度显示任务完成度
4. **今日财报卡** - 实时股票数据和折线图
5. **任务时间线** - 带状态的任务列表
6. **Virtual Assistant** - Live2D预留占位
7. **底部导航** - 浮起胶囊式导航栏

---

## 📝 修改示例

### 1. 修改今日进度数据

编辑 `/components/DashboardData.tsx`:

```typescript
export const defaultDailyProgress: DailyProgressData = {
  dailyProgressPct: 85,  // 改为 85%
  doneCount: 17,         // 17 个已完成
  totalCount: 20,        // 总共 20 个
};
```

### 2. 添加新的时间线任务

编辑 `/components/DashboardData.tsx`:

```typescript
export const defaultTimelineTasks: TimelineTask[] = [
  // ... 现有任务
  {
    taskId: '5',
    title: '你的新任务',
    desc: '任务描述内容',
    time: '18:00',
    status: 'pending',
    buttonText: 'Check summary',
  },
];
```

### 3. 修改配色方案

编辑 `/styles/globals.css`:

```css
:root {
  --primary: #F2C166;        /* 主色 - 金色 */
  --background: #0B1020;     /* 背景色 */
  --card: #0E1422;           /* 卡片色 */
  --success: #8FE3A1;        /* 成功色 - 绿色 */
  /* 修改这些值来改变配色 */
}
```

### 4. 自定义财报数据源

编辑 `/components/pages/Dashboard.tsx`:

```typescript
// 替换模拟数据为真实API调用
const handleRefreshFinance = async () => {
  setIsFinanceLoading(true);
  try {
    const response = await fetch('YOUR_API_ENDPOINT');
    const data = await response.json();
    setFinanceData(data);
  } catch (error) {
    console.error('Failed to fetch finance data:', error);
  } finally {
    setIsFinanceLoading(false);
  }
};
```

---

## 🎨 组件状态切换

### FinanceCard 状态示例

```tsx
// 正常状态
<FinanceCard data={financeData} />

// 加载状态
<FinanceCard isLoading={true} />

// 错误状态
<FinanceCard error="加载失败" onRefresh={handleRetry} />
```

### TimelineTaskCard 状态示例

```tsx
// 已完成
<TimelineTaskCard status="done" ... />

// 进行中 (高亮)
<TimelineTaskCard status="in_progress" isActive={true} ... />

// 待开始
<TimelineTaskCard status="pending" ... />
```

---

## 🔌 连接真实数据

### Step 1: 创建 API Hook

创建 `/hooks/useDashboardData.ts`:

```typescript
import { useState, useEffect } from 'react';
import { FinanceData, TimelineTask } from '../components/DashboardData';

export function useDashboardData() {
  const [financeData, setFinanceData] = useState<FinanceData | null>(null);
  const [tasks, setTasks] = useState<TimelineTask[]>([]);
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    async function fetchData() {
      try {
        // 获取财报数据
        const financeRes = await fetch('/api/finance');
        const finance = await financeRes.json();
        setFinanceData(finance);

        // 获取任务数据
        const tasksRes = await fetch('/api/tasks');
        const tasksList = await tasksRes.json();
        setTasks(tasksList);
      } catch (error) {
        console.error('Failed to fetch data:', error);
      } finally {
        setIsLoading(false);
      }
    }

    fetchData();
  }, []);

  return { financeData, tasks, isLoading };
}
```

### Step 2: 在 Dashboard 中使用

编辑 `/components/pages/Dashboard.tsx`:

```typescript
import { useDashboardData } from '../../hooks/useDashboardData';

export function Dashboard({ onLogout, username }: DashboardProps) {
  const { financeData, tasks, isLoading } = useDashboardData();

  // 使用真实数据
  return (
    // ...
    <FinanceCard 
      data={financeData} 
      isLoading={isLoading}
      onRefresh={refetchData}
    />
    // ...
  );
}
```

---

## 🎯 常见定制需求

### 改变卡片圆角

所有卡片使用 `rounded-2xl` (16px)，如需修改：

```tsx
// 在组件中找到 className 并修改
className="... rounded-3xl ..."  // 24px
className="... rounded-xl ..."   // 12px
```

### 调整双卡片布局

当前为等宽 2 列，如需改为 1:2 比例：

```tsx
// 在 Dashboard.tsx 中
<div className="grid grid-cols-3 gap-3 mb-6">  {/* 改为 3 列 */}
  <div className="col-span-1">  {/* 进度卡占 1 列 */}
    <DailyProgressCard ... />
  </div>
  <div className="col-span-2">  {/* 财报卡占 2 列 */}
    <FinanceCard ... />
  </div>
</div>
```

### 隐藏 Virtual Assistant

在 `Dashboard.tsx` 中注释掉相应部分：

```tsx
{/* ④ AI 角色占位 */}
{/* 
<div className="mb-6">
  <VASection ... />
</div>
*/}
```

---

## 📊 数据格式参考

### 财报数据格式

```json
{
  "price": 68.42,
  "changePct": 2.35,
  "volume": 3250000,
  "lastUpdate": "15:30",
  "seriesIntraday": [
    { "t": "09:30", "v": 66.8 },
    { "t": "10:00", "v": 67.2 },
    { "t": "15:30", "v": 68.42 }
  ]
}
```

### 任务数据格式

```json
[
  {
    "taskId": "1",
    "title": "任务标题",
    "desc": "任务描述，建议 1-2 行",
    "time": "10:00",
    "status": "done",
    "buttonText": "Check summary"
  }
]
```

### 进度数据格式

```json
{
  "dailyProgressPct": 75,
  "doneCount": 12,
  "totalCount": 16
}
```

---

## 🐛 常见问题

### Q: 财报卡显示 Loading 状态？
A: 检查 `isLoading` 状态和数据获取逻辑。确保异步操作完成后设置 `isLoading=false`。

### Q: 任务时间线竖线显示不正常？
A: 确保最后一个任务传入 `isLast={true}` 属性。

### Q: 日历芯片选中状态不更新？
A: 检查 `selectedDateId` state 和 `onClick` 事件是否正确绑定。

### Q: 底部导航被内容遮挡？
A: 确保主内容区域有足够的 `pb-32` (padding-bottom) 空间。

---

## 🎓 进阶技巧

### 1. 添加动画效果

使用 Motion (Framer Motion) 添加页面进入动画：

```tsx
import { motion } from 'motion/react';

<motion.div
  initial={{ opacity: 0, y: 20 }}
  animate={{ opacity: 1, y: 0 }}
  transition={{ duration: 0.3 }}
>
  <DailyProgressCard ... />
</motion.div>
```

### 2. 添加下拉刷新

```tsx
const [refreshing, setRefreshing] = useState(false);

const handleRefresh = async () => {
  setRefreshing(true);
  await fetchLatestData();
  setRefreshing(false);
};

// 在主容器上添加触摸事件
<div onTouchStart={handlePullDown}>
  ...
</div>
```

### 3. 添加通知提醒

```tsx
import { toast } from 'sonner@2.0.3';

// 任务完成时
toast.success('任务已完成！', {
  description: '你太棒了，继续加油！',
});
```

---

## 📦 组件导入速查

```typescript
// 原子组件
import { ProgressRing } from './components/atoms/ProgressRing';

// 分子组件
import { DateHeader } from './components/molecules/DateHeader';
import { DailyProgressCard } from './components/molecules/DailyProgressCard';
import { FinanceCard } from './components/molecules/FinanceCard';
import { TimelineTaskCard } from './components/molecules/TimelineTaskCard';
import { VASection } from './components/molecules/VASection';

// 其他组件
import { CalendarChip } from './components/CalendarChip';
import { BottomNav } from './components/BottomNav';

// 数据管理
import {
  getCurrentDateInfo,
  generateDateChips,
  defaultDailyProgress,
  mockFinanceData,
  defaultTimelineTasks,
  defaultVAData,
} from './components/DashboardData';
```

---

## 🎉 下一步

- [ ] 连接真实API数据源
- [ ] 添加用户交互动画
- [ ] 实现任务拖拽排序
- [ ] 集成 Live2D 虚拟助手
- [ ] 添加深色/浅色主题切换
- [ ] 实现离线数据缓存

**需要帮助？** 查看 `/DASHBOARD_COMPONENTS.md` 获取详细文档。

**最后更新**: November 1, 2025
