import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/loading_overlay.dart';
import '../screens/login_screen.dart';
import '../home/index.dart';
import '../screens/todo_screen.dart';
import '../screens/profile_screen.dart';
import '../theme/app_theme.dart';

enum AppScreenState { login, home, todo, profile }

class AppScreen extends StatefulWidget {
  const AppScreen({super.key});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  static const bool requireLogin = false;

  AppScreenState _currentScreen =
      requireLogin ? AppScreenState.login : AppScreenState.home;
  TabItem _activeTab = TabItem.home;
  String _username = '';
  bool _isTransitioning = false;
  bool _isInitializing = true;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      setState(() => _isInitializing = false);
    });
  }

  void _handleLoginSuccess(String username) {
    setState(() {
      _username = username;
      _isTransitioning = true;
    });
    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      setState(() {
        _currentScreen = AppScreenState.home;
        _activeTab = TabItem.home;
        _isTransitioning = false;
      });
    });
  }

  void _handleLogout() {
    setState(() {
      _isTransitioning = true;
    });
    Future.delayed(const Duration(milliseconds: 400), () {
      if (!mounted) return;
      setState(() {
        _currentScreen =
            requireLogin ? AppScreenState.login : AppScreenState.home;
        _username = '';
        _isTransitioning = false;
        _activeTab = TabItem.home;
      });
    });
  }

  void _handleTabChange(TabItem tab) {
    setState(() {
      _activeTab = tab;
      _currentScreen = _tabToScreen(tab);
    });
  }

  AppScreenState _tabToScreen(TabItem tab) {
    switch (tab) {
      case TabItem.home:
        return AppScreenState.home;
      case TabItem.todo:
        return AppScreenState.todo;
      case TabItem.profile:
        return AppScreenState.profile;
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('AppScreen build -> screen=$_currentScreen, init=$_isInitializing, transitioning=$_isTransitioning');
    
    if (_currentScreen == AppScreenState.login && requireLogin) {
      return LoadingOverlay(
        isLoading: _isInitializing,
        message: _isInitializing ? '正在初始化…' : null,
        child: const Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Text('Debug: LoginScreen branch loaded'),
          ),
        ),
      );
    }

    final isOverlayVisible = _isInitializing || _isTransitioning;

    // Restore Stack with BottomNav - BottomNav already has Positioned internally
    final scaffoldBody = Stack(
      fit: StackFit.expand,
      children: [
        _buildScreen(),
        if (_currentScreen != AppScreenState.login)
          BottomNav(
            activeTab: _activeTab,
            onTabChange: _handleTabChange,
          ),
      ],
    );

    if (!requireLogin) {
      return Scaffold(
        backgroundColor: AppTheme.background,
        body: scaffoldBody,
      );
    }

    return LoadingOverlay(
      isLoading: isOverlayVisible,
      message: isOverlayVisible ? '正在加载…' : null,
      child: Scaffold(
        backgroundColor: AppTheme.background,
        body: scaffoldBody,
      ),
    );
  }

  Widget _buildScreen() {
    switch (_currentScreen) {
      case AppScreenState.login:
        return LoginScreen(
          onLoginSuccess: _handleLoginSuccess,
          isTransitioning: _isTransitioning,
        );
      case AppScreenState.home:
        return DashboardScreen(
          onLogout: _handleLogout,
          username: _username,
          onNavigateToTodo: () => _handleTabChange(TabItem.todo),
        );
      case AppScreenState.todo:
        return const TodoScreen();
      case AppScreenState.profile:
        return ProfileScreen(
          username: _username,
          onLogout: _handleLogout,
        );
    }
  }
}
