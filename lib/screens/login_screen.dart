import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/atoms/input_field.dart';
import '../widgets/atoms/primary_button.dart';
import '../widgets/atoms/mode_toggle.dart';
import '../widgets/loading_overlay.dart';

class LoginScreen extends StatefulWidget {
  final Function(String) onLoginSuccess;
  final bool isTransitioning;

  const LoginScreen({
    super.key,
    required this.onLoginSuccess,
    this.isTransitioning = false,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _mode = '登录';
  String _username = '';
  String _password = '';
  bool _isLoading = false;
  String? _error;

  void _handleSubmit() {
    if (_username.isEmpty || _password.isEmpty) {
      setState(() => _error = '请输入用户名和密码');
      return;
    }

    if (_username.length < 3) {
      setState(() => _error = '用户名至少需要3个字符');
      return;
    }

    if (_password.length < 6) {
      setState(() => _error = '密码至少需要6个字符');
      return;
    }

    setState(() {
      _error = null;
      _isLoading = true;
    });

    Future.delayed(const Duration(milliseconds: 1200), () {
      if (!mounted) return;
      setState(() => _isLoading = false);
      widget.onLoginSuccess(_username);
    });
  }

  void _handleModeToggle(String mode) {
    setState(() {
      _mode = mode;
      _error = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isOverlayVisible = _isLoading || widget.isTransitioning;

    return LoadingOverlay(
      isLoading: isOverlayVisible,
      message: isOverlayVisible ? '正在验证身份…' : null,
      child: Scaffold(
        backgroundColor: AppTheme.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                        Text(
                          '欢迎回来',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.foreground,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          '请登录以继续',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppTheme.mutedForeground,
                          ),
                        ),
                      ],
                    ),
                    ModeToggle(
                      options: const ['登录', '注册'],
                      selected: _mode,
                      onSelect: _handleModeToggle,
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                InputField(
                  icon: const Icon(Icons.person_outline),
                  type: 'text',
                  placeholder: '输入用户名',
                  value: _username,
                  onChange: (value) => setState(() => _username = value),
                ),
                const SizedBox(height: 16),
                InputField(
                  icon: const Icon(Icons.lock_outline),
                  type: 'password',
                  placeholder: '输入密码',
                  value: _password,
                  onChange: (value) => setState(() => _password = value),
                ),
                if (_error != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    _error!,
                    style: const TextStyle(color: AppTheme.destructive),
                  ),
                ],
                const SizedBox(height: 32),
                PrimaryButton(
                  text: _mode == '登录' ? '立即登录' : '创建账号',
                  isLoading: _isLoading,
                  onClick: _handleSubmit,
                  loadingText: '正在处理…',
                ),
                const Spacer(),
                const Text(
                  '登录即表示你同意我们的隐私政策与服务条款',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.mutedForeground,
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
