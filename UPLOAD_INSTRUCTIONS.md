# 上传到 GitHub 的说明

## 方法 1: 使用提供的脚本（推荐）

```bash
cd /Users/dai/Desktop/HaotianDesign
./upload_to_github.sh
```

## 方法 2: 手动执行 Git 命令

```bash
cd /Users/dai/Desktop/HaotianDesign

# 1. 初始化 Git 仓库（如果还没有）
git init

# 2. 连接到远程仓库
git remote remove origin 2>/dev/null || true
git remote add origin https://github.com/baolingxiao/HaotianDesign.git

# 3. 添加所有文件
git add .

# 4. 提交更改
git commit -m "Update Flutter project: Complete iOS conversion"

# 5. 切换到 main 分支
git branch -M main

# 6. 强制推送到 GitHub（覆盖远程仓库）
git push -f origin main
```

## 注意事项

- 使用 `-f` (force) 参数会覆盖远程仓库的所有内容
- 确保你有该仓库的写入权限
- 如果遇到认证问题，可能需要配置 GitHub 凭证

## 如果遇到认证问题

如果 Git 需要认证，可以：

1. 使用 Personal Access Token:
   - 在 GitHub 设置中生成 token
   - 使用 token 作为密码

2. 使用 SSH:
   ```bash
   git remote set-url origin git@github.com:baolingxiao/HaotianDesign.git
   ```

