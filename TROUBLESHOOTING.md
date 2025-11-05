# iOS 构建问题排查

## PhaseScriptExecution 错误解决方案

### 1. 清理和重新构建
```bash
flutter clean
flutter pub get
cd ios
export LANG=en_US.UTF-8
pod install
cd ..
flutter run
```

### 2. 在 Xcode 中修复
1. 打开 `ios/Runner.xcworkspace`
2. 选择 Runner 项目 → Runner target
3. 在 **Signing & Capabilities** 中：
   - 勾选 "Automatically manage signing"
   - 选择你的 **Development Team**（需要登录 Apple ID）
   - 确保 Bundle Identifier 是唯一的（如：com.yourname.haotiandesign）

### 3. 设置正确的架构
在 Xcode 中：
- 选择 Runner → Build Settings
- 搜索 "Architectures"
- 确保包含 "arm64" 和 "x86_64"（模拟器）

### 4. 检查构建脚本
确保 Flutter 路径正确：
- Xcode → Runner → Build Phases
- 找到 "Run Script" 阶段
- 确认脚本路径指向正确的 Flutter 安装位置

### 5. 权限问题
如果脚本没有执行权限：
```bash
chmod +x ios/Flutter/flutter_export_environment.sh
```

### 6. 使用模拟器（推荐用于测试）
```bash
flutter run
```
这会自动选择 iOS 模拟器，不需要代码签名。

## 常见错误

### "Command PhaseScriptExecution failed"
- **原因**：Flutter 构建脚本执行失败
- **解决**：运行 `flutter clean` 和 `flutter pub get`

### "No code signing"
- **原因**：未设置 Development Team
- **解决**：在 Xcode 中设置 Signing & Capabilities

### "Pod install failed"
- **原因**：编码或路径问题
- **解决**：设置 `export LANG=en_US.UTF-8` 后重试

