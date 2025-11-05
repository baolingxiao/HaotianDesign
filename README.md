# 日历与任务列表页面 - iOS版本

这是一个专门为iOS平台设计的Flutter应用项目，仅在iOS模拟器和真机上运行。

## 运行说明

### 前置要求
- Flutter SDK (>=3.0.0)
- Xcode (用于iOS开发)
- iOS模拟器或真机

### 安装依赖

```bash
flutter pub get
```

### 运行项目

```bash
# iOS模拟器（推荐）
flutter run -d "iPhone 17 Pro"

# 或者直接运行，会自动选择iOS模拟器
flutter run

# 在Xcode中打开
open ios/Runner.xcworkspace
```

## 项目结构

```
lib/
├── main.dart              # 应用入口
├── app.dart               # 主应用配置
├── theme/
│   └── app_theme.dart     # 主题和颜色配置
├── models/                # 数据模型
├── screens/               # 页面组件
├── widgets/               # UI组件
│   ├── atoms/             # 原子组件
│   ├── molecules/         # 分子组件
│   └── ...                # 其他组件
```

## 功能特性

- ✅ 登录/注册页面
- ✅ 仪表板页面
- ✅ 待办事项页面
- ✅ 个人档案页面
- ✅ 底部导航栏
- ✅ 深色HUD风格设计
- ✅ 响应式布局
- ✅ 交互动效
