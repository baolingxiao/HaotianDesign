#!/bin/bash
set -e

echo "📦 开始上传到 GitHub..."
cd /Users/dai/Desktop/HaotianDesign

# 检查是否是 git 仓库
if [ ! -d .git ]; then
  echo "🔧 初始化 Git 仓库..."
  git init
fi

# 设置远程仓库
echo "🔗 设置远程仓库..."
git remote remove origin 2>/dev/null || true
git remote add origin https://github.com/baolingxiao/HaotianDesign.git

# 获取远程仓库信息
echo "📥 获取远程仓库信息..."
git fetch origin --depth=1 2>&1 || echo "远程仓库可能为空或不存在"

# 检查远程分支
REMOTE_BRANCH=$(git ls-remote --heads origin main 2>/dev/null | head -1 | cut -f2 | sed 's|refs/heads/||')
if [ -z "$REMOTE_BRANCH" ]; then
  REMOTE_BRANCH=$(git ls-remote --heads origin master 2>/dev/null | head -1 | cut -f2 | sed 's|refs/heads/||')
  if [ -z "$REMOTE_BRANCH" ]; then
    REMOTE_BRANCH="main"
  fi
fi

echo "📋 检测到远程分支: $REMOTE_BRANCH"

# 创建或切换到 main 分支
git checkout -b main 2>/dev/null || git checkout main 2>/dev/null || true

# 添加所有文件
echo "➕ 添加所有文件..."
git add .

# 创建 .gitignore（如果不存在）
if [ ! -f .gitignore ]; then
  echo "📝 创建 .gitignore..."
  cat > .gitignore << 'EOF'
# Flutter/Dart
.dart_tool/
.flutter-plugins
.flutter-plugins-dependencies
.packages
.pub-cache/
.pub/
build/
**/generated_plugin_registrant.dart
**/generated_plugin_registrant.m
**/GeneratedPluginRegistrant.swift
**/GeneratedPluginRegistrant.m

# iOS
ios/Pods/
ios/.symlinks/
ios/Flutter/Flutter.framework
ios/Flutter/Flutter.podspec
ios/Flutter/Flutter.podspec.lock
ios/Flutter/Generated.xcconfig
ios/Flutter/app.flx
ios/Flutter/app.zip
ios/Flutter/flutter_assets/
ios/Flutter/flutter_export_environment.sh
ios/ServiceDefinitions.json
ios/Runner/GeneratedPluginRegistrant.*
ios/.xcode.env.local
ios/Podfile.lock

# macOS
.DS_Store

# IDE
.idea/
.vscode/
*.iml
*.ipr
*.iws

# Temporary files
*.swp
*.swo
*~
EOF
  git add .gitignore
fi

# 提交更改
echo "💾 提交更改..."
git commit -m "Update Flutter project: Convert from React to Flutter iOS app

- Complete Flutter iOS conversion
- New Home module with DashboardScreen
- All components converted to Flutter widgets
- iOS-only platform support
- Fixed build errors and rendering issues" 2>&1 || echo "没有更改需要提交"

# 强制推送（覆盖远程仓库）
echo "🚀 推送到 GitHub (覆盖远程仓库)..."
git push -f origin main:$REMOTE_BRANCH 2>&1

echo "✅ 上传完成！"
echo "📱 仓库地址: https://github.com/baolingxiao/HaotianDesign.git"

