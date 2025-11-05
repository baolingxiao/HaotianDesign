import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class InputField extends StatefulWidget {
  final Widget icon;
  final String type;
  final String placeholder;
  final String value;
  final ValueChanged<String>? onChange;

  const InputField({
    super.key,
    required this.icon,
    required this.type,
    required this.placeholder,
    required this.value,
    this.onChange,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool _isFocused = false;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(InputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _controller.text = widget.value;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = _isFocused ? AppTheme.primary : AppTheme.border;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: AppTheme.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: _isFocused ? 2 : 1),
        boxShadow: [
          if (_isFocused)
            BoxShadow(
              color: AppTheme.primary.withValues(alpha: 0.25),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          IconTheme(
            data: IconThemeData(
              color: _isFocused ? AppTheme.primary : AppTheme.tertiaryForeground,
              size: 20,
            ),
            child: widget.icon,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _controller,
              obscureText: widget.type == 'password',
              decoration: InputDecoration(
                hintText: widget.placeholder,
                hintStyle: const TextStyle(color: AppTheme.mutedForeground),
                border: InputBorder.none,
              ),
              style: const TextStyle(color: AppTheme.foreground, fontSize: 15),
              onChanged: widget.onChange,
              onTap: () => setState(() => _isFocused = true),
              onEditingComplete: () => setState(() => _isFocused = false),
              onSubmitted: (_) => setState(() => _isFocused = false),
            ),
          ),
        ],
      ),
    );
  }
}
