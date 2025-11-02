# iOS To-Do 应用 - 深色 HUD 风格

一个完整的iOS风格移动端应用，采用深色HUD设计语言，包含登录、仪表板、待办事项和个人档案四个主要页面。

## 🎨 设计系统

### 颜色变量
- **背景深色** `bg`: #0B1020
- **卡片背景** `card`: #0E1422
- **边框** `border`: rgba(255,255,255,0.12)
- **主文字** `textPrimary`: #E5E7EB
- **次要文字** `textSecondary`: #A8B0BF
- **标签/说明** `textMuted`: #7C8596
- **强调金色** `accentGold`: #F2C166
- **成功绿色** `success`: #8FE3A1
- **进度轨道** `progressTrack`: rgba(255,255,255,0.15)
- **分隔灰** `divider`: #6B7280

### 字体规范
- **标题 H1**: 28/34, 字重 700
- **标题 H2**: 20/28, 字重 600
- **正文**: 16/24, 字重 400
- **标签**: 12/16, 字重 400

### 圆角与描边
- 卡片圆角: 16px
- 内部元素圆角: 8px
- 卡片描边: 1px border

### 阴影
- 卡片阴影: Y=8, Blur=24, 透明黑 20%

## 📱 页面结构

### 1. 登录页（LoginScreen）
- 居中卡片布局
- 登录/注册模式切换
- 用户名和密码输入框
- 聚焦态交互效果
- 错误提示显示
- 加载状态动画

**组件:**
- `InputField` - 带图标的输入框
- `ModeToggle` - 模式切换按钮
- `PrimaryButton` - 主操作按钮

### 2. 仪表板（Dashboard）**【全新升级】**
- 日期头部与水平日历
- 今日目标完成度卡片（环形进度）
- 今日财报实时卡片（折线图）
- 任务时间线列表
- Virtual Assistant 虚拟助手区域
- 浮起胶囊式底部导航

**新增组件:**
- `DateHeader` - 日期头部
- `ProgressRing` - 环形进度条
- `DailyProgressCard` - 今日进度卡片
- `FinanceCard` - 财报实时卡片（含图表）
- `TimelineTaskCard` - 时间线任务卡片
- `VASection` - 虚拟助手区域

**功能特性:**
- 📅 可选择日期的水平日历
- 📊 环形进度展示今日完成度
- 💹 实时财报数据与折线图（支持刷新）
- ⏱️ 时间线式任务列表（完成/进行中/待开始）
- 🤖 Live2D 虚拟助手预留接口
- 📱 iPhone 15 Pro (390×844) 完美适配

**数据管理:**
- 统一数据源: `DashboardData.tsx`
- 模拟数据完整可用
- 支持 API 对接

### 3. 待办事项页（TodoScreen）
- 日期头部与日历选择器
- 时间线式任务卡片列表
- 任务状态显示（完成/进行中/待处理）

**组件:**
- `CalendarChip` - 日期选择器
- `TaskCard` - 任务卡片
- `IconButton` - 图标按钮

### 4. 个人档案页（ProfileScreen）
- 用户头像与信息
- 统计数据网格（Level, XP, Tasks）
- 账户信息列表
- 设置与退出按钮

## 🔄 导航系统

### 底部导航栏（BottomNav）
- Home - 仪表板
- To-do - 待办事项
- Profile - 个人档案

### 页面转场
- 登录成功 → 仪表板（300ms 渐隐渐现）
- 点击 Logout → 登录页（300ms 渐隐渐现）
- 底部导航切换（即时）

## 🛠️ 技术栈

- **React** - UI框架
- **TypeScript** - 类型安全
- **Tailwind CSS** - 样式系统
- **Lucide React** - 图标库

## 📂 项目结构

```
/components
  /atoms
    - InputField.tsx         # 输入框
    - PrimaryButton.tsx      # 主按钮
    - ModeToggle.tsx         # 模式切换
    - ProgressBar.tsx        # 进度条
    - ProgressRing.tsx       # 🆕 环形进度条
  /molecules
    - ProgressHeader.tsx     # 进度头部
    - MainTaskCard.tsx       # 主任务卡片
    - AchievementsCard.tsx   # 成就卡片
    - SubTasksCard.tsx       # 子任务卡片
    - DateHeader.tsx         # 🆕 日期头部
    - DailyProgressCard.tsx  # 🆕 今日进度卡片
    - FinanceCard.tsx        # 🆕 财报卡片
    - TimelineTaskCard.tsx   # 🆕 时间线任务卡
    - VASection.tsx          # 🆕 虚拟助手区域
  /pages
    - LoginScreen.tsx        # 登录页
    - Dashboard.tsx          # 🆕 仪表板（全新升级）
    - TodoScreen.tsx         # 待办页
    - ProfileScreen.tsx      # 个人页
    - ComponentLibrary.tsx   # 🆕 组件库展示
  /dashboard
    - index.ts               # 🆕 统一导出
  - BottomNav.tsx           # 底部导航（已增强）
  - CalendarChip.tsx        # 日历芯片（已增强）
  - TaskCard.tsx            # 任务卡片
  - IconButton.tsx          # 图标按钮
  - UserData.tsx            # 用户数据
  - TaskData.tsx            # 任务数据
  - DashboardData.tsx       # 🆕 仪表板数据管理
/styles
  - globals.css             # 全局样式（已更新）
App.tsx                     # 主应用
/docs
  - DASHBOARD_COMPONENTS.md # 🆕 详细组件文档
  - QUICK_START.md          # 🆕 快速开始指南
  - VISUAL_GUIDE.md         # 🆕 视觉设计指南
  - IMPLEMENTATION_CHECKLIST.md # 🆕 实现清单
```

## 🎯 特性

- ✅ 深色HUD风格设计
- ✅ 完整的页面流程
- ✅ 响应式布局
- ✅ 交互动效
- ✅ 状态管理
- ✅ 表单验证
- ✅ 加载状态
- ✅ 原子化组件设计

## 🚀 使用说明

1. 在登录页输入用户名和密码（至少3字符和6字符）
2. 点击登录按钮进入仪表板
3. 使用底部导航在不同页面间切换
4. 在个人档案页可以退出登录

## 📊 数据模型

### UserProfile
```typescript
{
  username: string;
  email: string;
  joinDate: string;
  level: number;
  xp: number;
  maxXp: number;
  tasksCompleted: number;
  totalTasks: number;
  membershipLevel: string;
}
```

### Task
```typescript
{
  id: number;
  time: string;
  title: string;
  description: string;
  status: 'completed' | 'in-progress' | 'pending';
  buttonText: string;
  isPrimary?: boolean;
}
```

### SubTask
```typescript
{
  id: number;
  title: string;
  completed: boolean;
}
```
