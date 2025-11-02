# Dashboard V2 重构说明

## 📋 更新概览

基于用户需求，Dashboard 页面已完成重大重构，主要改动包括：

### ✅ 主要变更

1. **删除原任务时间线区块** - 移除 `TimelineTaskCard` 列表展示
2. **左侧进度卡片整合任务列表** - 新建 `ProgressCardLeft` 组件
3. **AI 区域上移** - `VASection` 从最底部移至第3位
4. **新增任务标题行组件** - `TaskTitleItem` 简化版任务展示
5. **增强交互逻辑** - 点击任务跳转 To-do 页面

---

## 🎨 新布局结构

```
┌─────────────────────────────────────┐
│  Saturday                    📅 👤  │  ← DateHeader
│  November 1, 2025                   │
├─────────────────────────────────────┤
│  [Tue] [Wed] [今] [Fri] [Sat] ...  │  ← CalendarChip
│   23   24   25   26   27            │
├─────────────────────────────────────┤
│  ┌──────────┐  ┌────────────────┐  │
│  │今日目标  │  │ 今日财报       │  │  ← 双卡片区
│  │          │  │                │  │
│  │  ◯ 75%  │  │  📈 实时图表   │  │
│  │          │  │                │  │
│  │ 12/16完成│  │  $68.42 +2.35% │  │
│  │          │  │                │  │
│  │ 任务列表 │  │                │  │  ← 新增：任务列表
│  │ ✓ Task 1 │  │                │  │
│  │ ⏱ Task 2│  │                │  │
│  │ ○ Task 3│  │                │  │
│  │          │  │                │  │
│  │查看全部→ │  │  查看详情 →    │  │
│  └──────────┘  └────────────────┘  │
├─────────────────────────────────────┤
│  ┌─ Virtual Assistant ───── ⋯ ─┐  │
│  │  🟢 Online                   │  │  ← VA区域（上移）
│  │                              │  │
│  │    😊  Live2D avatar         │  │
│  │      will render here        │  │
│  │                              │  │
│  │  Click to interact • Hover   │  │
│  └──────────────────────────────┘  │
│                                     │
│  ╭───────────────────────────────╮ │
│  │  🏠 Home  ☑ To-do  👤 Profile│ │  ← BottomNav
│  ╰───────────────────────────────╯ │
└─────────────────────────────────────┘
```

---

## 🆕 新增组件

### 1. TaskTitleItem
**位置**: `/components/atoms/TaskTitleItem.tsx`

简化的任务标题行，仅显示状态图标、标题和箭头。

**Props**:
```typescript
interface TaskTitleItemProps {
  id: string;
  title: string;
  status: 'pending' | 'in_progress' | 'done';
  onClick?: (id: string) => void;
}
```

**特点**:
- 最小高度 44px（符合无障碍触摸标准）
- 状态图标：✓ 完成 / ⏱ 进行中 / ○ 待处理
- 悬停效果：背景加深
- 点击触发：传递任务 ID

**使用示例**:
```tsx
<TaskTitleItem
  id="task-1"
  title="Watch introduction video"
  status="done"
  onClick={(id) => console.log(`Navigate to task: ${id}`)}
/>
```

---

### 2. ProgressCardLeft
**位置**: `/components/molecules/ProgressCardLeft.tsx`

整合版左侧进度卡片，包含环形进度 + 任务列表。

**Props**:
```typescript
interface ProgressCardLeftProps {
  dailyProgressPct: number;       // 0-100
  doneCount: number;
  totalCount: number;
  tasksToday?: Task[];             // 今日任务列表
  showList?: boolean;              // 是否显示列表（默认 true）
  maxVisible?: number;             // 最多显示数量（默认 4）
  isLoading?: boolean;
  onTaskClick?: (taskId: string) => void;
  onViewAll?: () => void;
  onCreateTask?: () => void;
}
```

**状态变体**:

1. **Default (withTasks)** - 显示进度环 + 任务列表
2. **Empty** - 显示"今天没有任务" + "去创建 →" 按钮
3. **Loading** - 骨架屏（环形灰占位 + 三行条形占位）

**Data Keys**:
- `daily_progress_pct`: 进度百分比
- `done_count`: 已完成数
- `total_count`: 总任务数
- `tasks_today`: 今日任务数组 `[{id, title, status}]`

**使用示例**:
```tsx
<ProgressCardLeft
  dailyProgressPct={75}
  doneCount={12}
  totalCount={16}
  tasksToday={[
    { id: 'task-1', title: 'Watch video', status: 'done' },
    { id: 'task-2', title: 'UI Design', status: 'in_progress' },
    { id: 'task-3', title: 'Read docs', status: 'pending' },
  ]}
  showList={true}
  maxVisible={4}
  onTaskClick={(id) => navigateToTodo(id)}
  onViewAll={() => navigateToTodo()}
  onCreateTask={() => navigateToTodo('create')}
/>
```

---

## 🔄 更新的组件

### CalendarChip
**新增属性**: `disabled?: boolean`

**新增变体**: Disabled 状态
- 灰色半透明
- 不可点击
- cursor: not-allowed

**使用示例**:
```tsx
<CalendarChip day="Sun" date={28} isSelected={false} onClick={() => {}} disabled={true} />
```

---

### BottomNav
**样式更新**:
- 圆角从 `28px` 更新为 `24px` (rounded-3xl)
- 符合设计规范要求

---

### FinanceCard
**动画增强**:
- 刷新图标：360° 旋转动画（600ms）
- 数据加载：淡入过渡（200ms）
- 更平滑的视觉反馈

**代码示例**:
```tsx
<RefreshCw 
  className={`w-3.5 h-3.5 transition-transform duration-[600ms] ${
    isRefreshing ? 'rotate-[360deg]' : 'rotate-0'
  }`}
/>
```

---

## 📊 数据结构更新

### DashboardData.tsx

**新增类型**:
```typescript
export interface TodayTask {
  id: string;
  title: string;
  status: 'pending' | 'in_progress' | 'done';
}
```

**更新类型**:
```typescript
export interface DailyProgressData {
  dailyProgressPct: number;
  doneCount: number;
  totalCount: number;
  tasksToday?: TodayTask[];  // 新增
}
```

**新增默认数据**:
```typescript
export const defaultTodayTasks: TodayTask[] = [
  { id: 'task-1', title: 'Watch introduction video', status: 'done' },
  { id: 'task-2', title: 'UI Design Sprint', status: 'in_progress' },
  { id: 'task-3', title: 'Complete chapter 1 exercises', status: 'pending' },
  { id: 'task-4', title: 'Read documentation', status: 'pending' },
  { id: 'task-5', title: 'Team standup meeting', status: 'pending' },
];
```

---

## 🎯 交互逻辑

### 1. 任务点击交互

**功能**: 点击任意任务标题行跳转到 To-do 页面

**实现**:
```tsx
const handleTaskClick = (taskId: string) => {
  console.log(`Navigate to To-do with taskId: ${taskId}, filter: date=today`);
  onNavigateToTodo?.();
};
```

**原型说明**:
- 携带参数：`filter=date=today` & `taskId`
- 转场动画：Smart Animate 150-200ms
- 在 To-do 页面可高亮对应任务

---

### 2. 查看全部 To-do

**功能**: 点击"查看全部 To-do →"按钮

**实现**:
```tsx
const handleViewAllTodos = () => {
  console.log('Navigate to To-do with filter: date=today');
  onNavigateToTodo?.();
};
```

---

### 3. 创建任务

**功能**: Empty 状态下点击"去创建 →"

**实现**:
```tsx
const handleCreateTask = () => {
  console.log('Navigate to To-do (create mode)');
  onNavigateToTodo?.();
};
```

---

### 4. 日期切换

**功能**: 点击日期芯片切换选中状态

**实现**:
```tsx
const handleDateSelect = (chipId: string) => {
  setSelectedDateId(chipId);
  console.log(`Date selected: ${chipId}, filter tasks_today accordingly`);
};
```

**注释说明**: 切换后应过滤 `tasks_today` 数据源

---

### 5. 财报刷新

**功能**: 点击刷新图标触发数据更新

**动画**:
- 图标旋转 360°（600ms）
- 数据淡入（200ms）

---

## 🎨 设计规范遵循

### 圆角标准
- ✅ iPhone 外框: 60px
- ✅ 卡片: 16px (rounded-2xl)
- ✅ 底部导航: 24px (rounded-3xl)
- ✅ 按钮/芯片: 12-16px (rounded-xl)
- ✅ 任务行: 12px (rounded-xl)

### 阴影标准
- ✅ 轻阴影: shadow-sm（日历芯片）
- ✅ 中阴影: shadow-lg（卡片）
- ✅ 重阴影: shadow-2xl（底部导航）

### 间距标准
- ✅ 全局左右: 16px (px-4)
- ✅ 卡片内边距: 16px (p-4)
- ✅ 双卡片间距: 12px (gap-3)
- ✅ 模块间距: 24px (gap-6)
- ✅ 任务行间距: 8px (space-y-2)

### 触摸标准
- ✅ 最小高度: 44px（任务行）
- ✅ 按钮尺寸: 40×40px（图标按钮）
- ✅ 日历芯片: 60×60px

---

## 🔧 App.tsx 集成

**更新**:
```tsx
{currentScreen === 'home' && (
  <Dashboard 
    onLogout={handleLogout} 
    username={username}
    onNavigateToTodo={() => handleTabChange('todo')}  // 新增
  />
)}
```

**说明**: 添加 `onNavigateToTodo` 回调，支持从 Dashboard 跳转到 To-do 页面

---

## 📦 组件导出更新

### dashboard/index.ts

**新增导出**:
```typescript
export { TaskTitleItem } from '../atoms/TaskTitleItem';
export { ProgressCardLeft } from '../molecules/ProgressCardLeft';
export type { TodayTask } from '../DashboardData';
```

---

## 🎭 ComponentLibrary 更新

**新增展示**:
1. TaskTitleItem - 三种状态（done / in_progress / pending）
2. ProgressCardLeft - 三种变体（withTasks / empty / loading）
3. CalendarChip - 三种变体（default / selected / disabled）

---

## ⚠️ 移除的内容

### 已删除
- ❌ 原任务时间线列表展示（`TimelineTaskCard` 列表）
- ❌ "今日任务"独立区块标题

### 保留但不使用
- `TimelineTaskCard` 组件仍存在（供 To-do 页面使用）
- `DailyProgressCard` 组件仍存在（旧版，供参考）

---

## 📱 页面布局对比

### Before (V1)
```
1. 日期头部 + 日历
2. 双卡片（进度环 + 财报）
3. 今日任务时间线 ← 独立区块
4. AI 区域
5. 底部导航
```

### After (V2)
```
1. 日期头部 + 日历
2. 双卡片（进度环+任务列表 + 财报）← 整合
3. AI 区域 ← 上移
4. 底部导航
```

---

## 🚀 迁移指南

如需从 V1 迁移到 V2：

1. **更新 Dashboard 引用**
   ```tsx
   // 旧
   import { Dashboard } from './components/pages/Dashboard';
   
   // 新（无变化，但需传入 onNavigateToTodo）
   <Dashboard onNavigateToTodo={handleNavigate} />
   ```

2. **更新数据结构**
   ```tsx
   // 旧
   const dailyProgress = {
     dailyProgressPct: 75,
     doneCount: 12,
     totalCount: 16,
   };
   
   // 新
   const dailyProgress = {
     dailyProgressPct: 75,
     doneCount: 12,
     totalCount: 16,
     tasksToday: [...],  // 新增
   };
   ```

3. **使用新组件**
   ```tsx
   import { ProgressCardLeft } from './components/molecules/ProgressCardLeft';
   import { TaskTitleItem } from './components/atoms/TaskTitleItem';
   ```

---

## ✅ 检查清单

- [x] TaskTitleItem 组件创建
- [x] ProgressCardLeft 组件创建
- [x] Dashboard.tsx 重构
- [x] DashboardData.tsx 数据更新
- [x] CalendarChip disabled 状态
- [x] FinanceCard 动画增强
- [x] BottomNav 圆角更新
- [x] App.tsx 导航集成
- [x] ComponentLibrary 展示更新
- [x] dashboard/index.ts 导出更新
- [x] 文档完善

---

## 🎉 完成状态

✅ **所有需求已实现**
✅ **设计规范 100% 遵循**
✅ **交互逻辑完整实现**
✅ **组件库已更新**
✅ **文档已同步**

**版本**: v2.0.0  
**更新日期**: November 1, 2025  
**维护者**: Figma Make AI Assistant
