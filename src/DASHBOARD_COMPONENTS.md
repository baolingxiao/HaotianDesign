# Dashboard 组件文档

本文档说明 Dashboard 页面的所有组件及其使用方法。

## 🎨 设计规范

### 配色系统
- **背景色**: `#0B1020` (深海军蓝)
- **卡片色**: `#0E1422` (次深色)
- **主色**: `#F2C166` (金色)
- **次要色**: `#1A2332`
- **文字色**: `#E5E7EB` (浅灰)
- **边框**: `rgba(255, 255, 255, 0.12)`

### 圆角规范
- **外框**: 24px
- **卡片**: 16px
- **按钮/芯片**: 12-16px

### 阴影规范
- **轻阴影**: `shadow-sm`
- **中阴影**: `shadow-lg`
- **重阴影**: `shadow-2xl`

---

## 📦 组件清单

### 原子组件 (Atoms)

#### ProgressRing - 环形进度条
**位置**: `/components/atoms/ProgressRing.tsx`

**用途**: 显示百分比进度的环形图表

**Props**:
```typescript
interface ProgressRingProps {
  percentage: number; // 0-100
  size?: number; // 默认 120
  strokeWidth?: number; // 默认 12
  className?: string;
}
```

**使用示例**:
```tsx
<ProgressRing percentage={75} size={120} strokeWidth={12} />
```

**Data Keys**:
- `percentage`: 进度百分比 (0-100)

---

### 分子组件 (Molecules)

#### DateHeader - 日期头部
**位置**: `/components/molecules/DateHeader.tsx`

**用途**: 显示当前日期和快捷按钮

**Props**:
```typescript
interface DateHeaderProps {
  weekday: string;
  fullDate: string;
  onCalendarClick?: () => void;
  onProfileClick?: () => void;
}
```

**使用示例**:
```tsx
<DateHeader
  weekday="Saturday"
  fullDate="November 1, 2025"
  onCalendarClick={() => console.log('Open calendar')}
  onProfileClick={() => console.log('Open profile')}
/>
```

---

#### DailyProgressCard - 今日目标完成度卡片
**位置**: `/components/molecules/DailyProgressCard.tsx`

**用途**: 显示今日任务完成进度

**Props**:
```typescript
interface DailyProgressCardProps {
  dailyProgressPct: number;
  doneCount: number;
  totalCount: number;
  onViewProgress?: () => void;
}
```

**使用示例**:
```tsx
<DailyProgressCard
  dailyProgressPct={75}
  doneCount={12}
  totalCount={16}
  onViewProgress={() => console.log('View progress')}
/>
```

**Data Keys**:
- `daily_progress_pct`: 今日进度百分比 (0-100)
- `done_count`: 已完成任务数
- `total_count`: 总任务数

**状态**:
- Default: 正常显示
- Loading: 可扩展骨架屏
- Empty: 可扩展空状态

---

#### FinanceCard - 今日财报卡片
**位置**: `/components/molecules/FinanceCard.tsx`

**用途**: 显示实时财报数据和图表

**Props**:
```typescript
interface FinanceCardProps {
  data?: FinanceData;
  isLoading?: boolean;
  error?: string;
  onRefresh?: () => void;
  onViewDetails?: () => void;
}

interface FinanceData {
  price: number;
  changePct: number;
  volume: number;
  lastUpdate: string;
  seriesIntraday: Array<{ t: string; v: number }>;
}
```

**使用示例**:
```tsx
<FinanceCard
  data={{
    price: 68.42,
    changePct: 2.35,
    volume: 3250000,
    lastUpdate: '15:30',
    seriesIntraday: [
      { t: '09:30', v: 66.8 },
      { t: '10:00', v: 67.2 },
      // ...
    ],
  }}
  onRefresh={() => console.log('Refresh')}
  onViewDetails={() => console.log('Details')}
/>
```

**Data Keys**:
- `price`: 当前价格
- `change_pct`: 涨跌百分比 (±)
- `volume`: 成交量
- `last_update`: 最后更新时间 (datetime)
- `series_intraday`: 日内折线数据 [{t, v}]

**状态**:
- Default: 正常显示数据和图表
- Loading: 显示骨架屏
- Error: 显示错误信息和重试按钮

---

#### TimelineTaskCard - 任务时间线卡片
**位置**: `/components/molecules/TimelineTaskCard.tsx`

**用途**: 在时间线中显示任务详情

**Props**:
```typescript
interface TimelineTaskCardProps {
  taskId: string;
  title: string;
  desc: string;
  time: string;
  status: 'done' | 'in_progress' | 'pending';
  isActive?: boolean;
  buttonText?: string;
  onButtonClick?: () => void;
}
```

**使用示例**:
```tsx
<TimelineTaskCard
  taskId="2"
  title="UI Design Sprint"
  desc="Create high-fidelity mockups based on approved wireframes."
  time="12:00"
  status="in_progress"
  isActive={true}
  buttonText="Check process"
  onButtonClick={() => console.log('Task 2')}
/>
```

**Data Keys**:
- `task_id`: 任务ID
- `title`: 任务标题
- `desc`: 任务描述 (1-2行)
- `time`: 任务时间
- `status`: 任务状态 ('done' | 'in_progress' | 'pending')

**状态**:
- Done: 完成状态 (绿色图标)
- In Progress: 进行中 (金色图标)
- Pending: 待开始 (灰色图标)
- Active: 高亮状态 (主色实底白字)

---

#### VASection - Virtual Assistant 虚拟助手区域
**位置**: `/components/molecules/VASection.tsx`

**用途**: Live2D 虚拟助手占位区域

**Props**:
```typescript
interface VASectionProps {
  vaStatus?: 'online' | 'offline';
  placeholderImg?: string;
  onSettingsClick?: () => void;
  onInteract?: () => void;
}
```

**使用示例**:
```tsx
<VASection
  vaStatus="online"
  onSettingsClick={() => console.log('Settings')}
  onInteract={() => console.log('Interact')}
/>
```

**Data Keys**:
- `va_status`: 虚拟助手状态 ('online' | 'offline')
- `placeholder_img`: 占位图URL (可选)
- `placeholder_url`: WebView URL (预留)

**状态**:
- Online: 显示绿色在线点，可交互
- Offline: 显示灰色离线点
- Loading: 可扩展加载状态

---

#### CalendarChip - 日历芯片
**位置**: `/components/CalendarChip.tsx`

**用途**: 水平日历日期选择器

**Props**:
```typescript
interface CalendarChipProps {
  day: string;
  date: number;
  isSelected: boolean;
  onClick: () => void;
}
```

**使用示例**:
```tsx
<CalendarChip
  day="Sat"
  date={1}
  isSelected={true}
  onClick={() => console.log('Date selected')}
/>
```

---

## 📊 数据管理

### DashboardData.tsx
**位置**: `/components/DashboardData.tsx`

统一管理仪表板所有数据，确保页面间数据一致性。

**导出的数据类型**:
- `DateChipData`: 日期芯片数据
- `DailyProgressData`: 今日进度数据
- `FinanceData`: 财报数据
- `TimelineTask`: 任务时间线数据
- `VAData`: VA状态数据

**工具函数**:
- `getCurrentDateInfo()`: 获取当前日期信息
- `generateDateChips()`: 生成日期芯片数据

**默认数据**:
- `defaultDailyProgress`: 默认今日进度
- `mockFinanceData`: 模拟财报数据
- `defaultTimelineTasks`: 默认任务列表
- `defaultVAData`: 默认VA状态

---

## 🎯 页面结构

### Dashboard.tsx
**位置**: `/components/pages/Dashboard.tsx`

**结构顺序**:
1. 日期头部 & 水平日历
2. 顶部双卡片 (今日目标进度 + 今日财报)
3. 任务时间线列表
4. AI 角色占位
5. 浮起底栏导航

**布局规范**:
- 全局内边距: `px-4`
- 卡片间距: `gap-3` (12px) 或 `gap-6` (24px)
- 双列栅格: `grid-cols-2 gap-3`
- 底部导航间距: `pb-28`

---

## 🔧 API 对接指南

### 1. 今日进度数据
```typescript
// GET /api/dashboard/daily-progress
{
  daily_progress_pct: number, // 0-100
  done_count: number,
  total_count: number
}
```

### 2. 财报数据
```typescript
// GET /api/dashboard/finance
{
  price: number,
  change_pct: number, // ±
  volume: number,
  last_update: string, // "HH:MM"
  series_intraday: Array<{
    t: string, // "HH:MM"
    v: number  // price value
  }>
}
```

### 3. 任务时间线数据
```typescript
// GET /api/dashboard/tasks
Array<{
  task_id: string,
  title: string,
  desc: string,
  time: string, // "HH:MM"
  status: "done" | "in_progress" | "pending"
}>
```

### 4. VA 状态数据
```typescript
// GET /api/dashboard/va-status
{
  va_status: "online" | "offline",
  placeholder_img?: string,
  placeholder_url?: string
}
```

---

## 🎨 查看组件库

访问 `/components/pages/ComponentLibrary.tsx` 查看所有组件的不同状态展示。

可以在 App.tsx 中添加路由来访问组件库页面：

```tsx
import { ComponentLibrary } from './components/pages/ComponentLibrary';

// 在路由中添加
{currentScreen === 'component-library' && <ComponentLibrary />}
```

---

## 📱 响应式适配

当前设计针对 **iPhone 15 Pro (390×844pt)** 优化。

如需适配其他尺寸，建议：
- 使用相对单位 (`rem`, `%`)
- 使用 Tailwind 响应式前缀 (`sm:`, `md:`, `lg:`)
- 保持宽高比和间距比例

---

## 🚀 后续扩展建议

1. **数据持久化**: 使用 Supabase 存储用户数据
2. **实时更新**: WebSocket 连接实现财报数据实时刷新
3. **动画增强**: 使用 Motion 添加页面转场和组件动画
4. **Live2D 集成**: WebView 嵌入 Live2D 模型
5. **国际化**: 添加多语言支持 (i18n)

---

**最后更新**: November 1, 2025
