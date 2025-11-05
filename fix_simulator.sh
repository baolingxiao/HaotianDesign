#!/bin/bash
set -e

log_step() {
  echo "\n$1"
}

log_step "🚫 关闭所有模拟器..."
xcrun simctl shutdown all || true
echo "✅ 模拟器已关闭"

log_step "🗑️ 删除 Xcode DerivedData..."
rm -rf ~/Library/Developer/Xcode/DerivedData
echo "✅ DerivedData 已删除"

log_step "🧹 正在清理 Flutter 缓存..."
flutter clean
echo "✅ Flutter clean 完成"

log_step "📦 重新获取 Flutter 依赖..."
flutter pub get
echo "✅ 依赖已获取"

log_step "📚 安装 iOS Pods..."
(cd ios && pod install)
echo "✅ pod install 完成"

log_step "🧽 清空并重置所有模拟器..."
xcrun simctl erase all || true
echo "✅ 模拟器已重置"

log_step "🚀 启动 iOS 模拟器..."
open -a Simulator
echo "✅ 模拟器已启动"

log_step "🏃‍♂️ 运行 Flutter 项目..."
flutter run
echo "✅ Flutter 项目已启动"

