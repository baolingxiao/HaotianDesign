# 修复 "Framework 'Pods_Runner' not found" 错误

## 问题原因
这个错误通常是因为 CocoaPods 的框架没有正确链接到 Xcode 项目。

## 解决步骤

### 1. 在 Xcode 中修复（推荐）

1. **关闭 Xcode**（如果正在运行）

2. **重新安装 Pods**：
```bash
cd ios
rm -rf Pods Podfile.lock .symlinks
export LANG=en_US.UTF-8
pod install
cd ..
```

3. **打开 Xcode 工作空间**（**重要**：必须打开 .xcworkspace，不是 .xcodeproj）：
```bash
open ios/Runner.xcworkspace
```

4. **在 Xcode 中检查 Build Settings**：
   - 选择 **Runner** 项目（左侧导航栏顶部）
   - 选择 **Runner** target
   - 打开 **Build Settings** 标签
   - 搜索 "Framework Search Paths"
   - 确保包含：
     ```
     $(inherited)
     "${PODS_ROOT}/../Flutter/Flutter.framework"
     "${PODS_CONFIGURATION_BUILD_DIR}"
     ```

5. **检查 Other Linker Flags**：
   - 在 Build Settings 中搜索 "Other Linker Flags"
   - 确保包含：`$(inherited) -framework "Pods_Runner"`

6. **清理并重新构建**：
   - Product → Clean Build Folder (Shift+Cmd+K)
   - Product → Build (Cmd+B)

### 2. 使用命令行构建

```bash
cd /Users/dai/Desktop/HaotianDesign
flutter clean
flutter pub get
cd ios
export LANG=en_US.UTF-8
pod install
cd ..
flutter run
```

### 3. 如果仍然失败

检查 Pods 是否正确生成：

```bash
cd ios
ls -la Pods/Target\ Support\ Files/Pods-Runner/
```

应该看到：
- Pods-Runner.debug.xcconfig
- Pods-Runner.release.xcconfig
- Pods-Runner.profile.xcconfig

确保 xcconfig 文件已包含在 Debug.xcconfig 和 Release.xcconfig 中。

## 常见问题

**Q: 打开 .xcodeproj 而不是 .xcworkspace**
A: 必须使用 `.xcworkspace`，因为 CocoaPods 需要工作空间格式。

**Q: 框架搜索路径不正确**
A: 确保 Framework Search Paths 包含 `$(inherited)` 和 Pods 路径。

**Q: 链接器标志缺失**
A: 在 Other Linker Flags 中添加 `$(inherited)`。

