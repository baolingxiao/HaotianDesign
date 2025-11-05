# Home Module Integration Guide

## Overview
This document describes how to integrate and run the Home module (Dashboard) in your Flutter iOS app.

## File Structure
```
lib/home/
├── index.dart                    # Export barrel
├── dashboard_screen.dart          # Main Dashboard widget
├── dashboard_data.dart            # Data classes + mock + helpers
└── widgets/
    ├── date_header.dart
    ├── calendar_chip.dart
    ├── progress_ring.dart
    ├── task_title_item.dart
    ├── progress_card_left.dart
    ├── finance_card.dart
    └── va_section.dart
```

## Integration Steps

### 1. Import the Module
In your `lib/app.dart` or `lib/main.dart`, import the home module:

```dart
import 'home/index.dart';
```

### 2. Set DashboardScreen as Home
Update your `MaterialApp` to use `DashboardScreen` as the home:

```dart
import 'package:flutter/material.dart';
import 'home/index.dart';
import 'theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Dashboard',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: const DashboardScreen(),
    );
  }
}
```

### 3. Run on iOS

#### Option A: Flutter CLI
```bash
cd /Users/dai/Desktop/HaotianDesign
flutter run -d ios
```

#### Option B: Xcode
1. Open `ios/Runner.xcworkspace` in Xcode
2. Select your target device (e.g., iPhone 15 Pro)
3. Press `Cmd+R` to build and run

## Public API

The module exports the following via `home/index.dart`:

- `DashboardScreen` - Main dashboard widget
- `CalendarChip` - Date selection chip widget
- `ProgressRing` - Circular progress indicator
- `DashboardDataUtils` - Mock data providers:
  - `defaultDailyProgress` - Daily progress data
  - `mockFinanceData` - Finance data
  - `defaultVAData` - VA section data

## Features

- **Date Header**: Shows current weekday and full date with calendar/profile icons
- **Calendar Chips**: Horizontal scrollable date chips (14 days, today preselected)
- **Progress Card**: Circular progress ring showing daily task completion
- **Finance Card**: Real-time finance data with mini line chart and refresh
- **VA Section**: Virtual assistant panel with status indicator

## Customization

The module uses `AppTheme` for all styling. Ensure your `lib/theme/app_theme.dart` defines:
- `background`, `foreground`, `card`, `primary`, `success`, `destructive`, etc.

All animations are 300ms smooth transitions. Cards use 16px border radius and subtle shadows.

## Dependencies

- No third-party packages required
- Uses Flutter built-in `CustomPainter` for charts and progress rings
- Material 3 enabled (`useMaterial3: true`)
- iOS system San Francisco font (default)

## Notes

- The module is iOS-ready and compiles without additional Pod dependencies
- All components are stateless where possible for optimal performance
- Mock data is provided via `DashboardDataUtils` for testing

