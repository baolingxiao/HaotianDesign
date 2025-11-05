#!/bin/bash
set -e

echo "🚀 开始上传到 GitHub..."
cd /Users/dai/Desktop/HaotianDesign

# 检查 Git 是否已初始化
if [ ! -d .git ]; then
  echo "📦 初始化 Git 仓库..."
  git init
fi

# 设置远程仓库
echo "🔗 设置远程仓库..."
git remote remove origin 2>/dev/null || true
git remote add origin https://github.com/baolingxiao/HaotianDesign.git

# 添加所有文件
echo "➕ 添加所有文件..."
git add .

# 检查是否有更改
if git diff --staged --quiet; then
  echo "ℹ️  没有更改需要提交"
else
  # 提交更改
  echo "💾 提交更改..."
  git commit -m "Update Flutter project: Complete iOS conversion from React

- Converted React/TypeScript project to Flutter iOS app
- New Home module with DashboardScreen
- All components converted to Flutter widgets
- iOS-only platform support
- Fixed build errors and rendering issues
- Added bottom navigation bar
- All debug components functional"
fi

# 切换到 main 分支
echo "🌿 切换到 main 分支..."
git branch -M main

# 显示远程仓库信息
echo "📡 远程仓库信息:"
git remote -v

# 推送到 GitHub
echo "🚀 推送到 GitHub..."
echo "⚠️  注意：如果遇到认证问题，请使用以下方式："
echo "   1. 使用 Personal Access Token 作为密码"
echo "   2. 或在终端手动执行: git push -f origin main"
echo ""
git push -f origin main || {
  echo ""
  echo "❌ 推送失败，可能原因："
  echo "   1. 需要认证（用户名和密码）"
  echo "   2. 没有写入权限"
  echo "   3. 网络问题"
  echo ""
  echo "请手动执行以下命令："
  echo "   cd /Users/dai/Desktop/HaotianDesign"
  echo "   git push -f origin main"
  exit 1
}

echo ""
echo "✅ 上传完成！"
echo "📱 仓库地址: https://github.com/baolingxiao/HaotianDesign.git"

