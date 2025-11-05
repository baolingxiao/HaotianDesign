import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/app_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '日历与任务列表页面',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: const AppScreen(),
      builder: (context, child) {
        if (child == null) {
          return const Scaffold(
            body: Center(
              child: Text(
                'App Loading Error',
                style: TextStyle(fontSize: 24, color: Colors.red),
              ),
            ),
          );
        }
        return child;
      },
    );
  }
}
