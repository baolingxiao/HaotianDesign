# Git 上传说明

由于终端命令可能无法直接执行 `git push`（需要认证），请按照以下步骤手动上传：

## 步骤 1: 打开终端

在 macOS 上打开 Terminal 应用。

## 步骤 2: 执行以下命令

```bash
cd /Users/dai/Desktop/HaotianDesign

# 初始化 Git 仓库（如果还没有）
git init

# 设置远程仓库
git remote remove origin 2>/dev/null || true
git remote add origin https://github.com/baolingxiao/HaotianDesign.git

# 添加所有文件
git add .

# 提交更改
git commit -m "Update Flutter project: Complete iOS conversion from React

- Converted React/TypeScript project to Flutter iOS app
- New Home module with DashboardScreen  
- All components converted to Flutter widgets
- iOS-only platform support
- Fixed build errors and rendering issues
- Added bottom navigation bar"

# 切换到 main 分支
git branch -M main

# 推送到 GitHub（会覆盖远程仓库）
git push -f origin main
```

## 步骤 3: 处理认证

如果 `git push` 提示需要认证：

1. **使用 Personal Access Token（推荐）**：
   - 访问：https://github.com/settings/tokens
   - 点击 "Generate new token" > "Generate new token (classic)"
   - 选择权限：至少勾选 `repo`
   - 复制生成的 token
   - 在 Git 提示输入密码时，使用这个 token 作为密码

2. **或者使用 SSH**：
   ```bash
   git remote set-url origin git@github.com:baolingxiao/HaotianDesign.git
   git push -f origin main
   ```

## 注意事项

- `git push -f` 会**强制覆盖**远程仓库的所有内容
- 确保你有该仓库的写入权限
- 如果仓库不存在，需要先在 GitHub 上创建

## 验证上传

上传成功后，访问：
https://github.com/baolingxiao/HaotianDesign

你应该能看到所有项目文件。

