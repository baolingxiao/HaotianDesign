#!/bin/bash
set -e

log_step() {
  echo "\n🔧 $1"
}

log_step "清理 Flutter 构建缓存..."
flutter clean
echo "✅ Flutter clean 完成"

log_step "重新获取 Flutter 依赖..."
flutter pub get
echo "✅ 依赖已获取"

log_step "清理 iOS 构建产物..."
rm -rf ios/Pods
rm -rf ios/Podfile.lock
rm -rf ios/.symlinks
rm -rf ios/Flutter/Flutter.framework
rm -rf ios/Flutter/Flutter.podspec
rm -rf ~/Library/Developer/Xcode/DerivedData
echo "✅ iOS 构建产物已清理"

log_step "重新安装 CocoaPods 依赖..."
cd ios
pod deintegrate || true
pod install
cd ..
echo "✅ Pod install 完成"

log_step "检查 Flutter 项目配置..."
flutter doctor -v | head -20

log_step "✅ 修复完成！"
echo ""
echo "现在请尝试："
echo "1. 在 Xcode 中：Product > Clean Build Folder (Shift+Cmd+K)"
echo "2. 关闭 Xcode"
echo "3. 运行: flutter run -d ios"
echo "或者"
echo "4. 重新打开 Xcode 并运行项目"

