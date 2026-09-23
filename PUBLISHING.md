# 发布到 GitHub

本目录已经按独立 Git 仓库组织。发布前先运行：

```bash
./scripts/validate-repository.sh
```

## 方式一：GitHub CLI

已安装并登录 `gh` 时，在本目录执行：

```bash
gh repo create novellix-platform-builder \
  --public \
  --source=. \
  --remote=origin \
  --push
```

## 方式二：GitHub 网站和 Git

1. 在 GitHub 新建一个名为 `novellix-platform-builder` 的空仓库。
2. 不要在 GitHub 勾选自动创建 README、License 或 `.gitignore`，本目录已经包含这些文件。
3. 在本目录执行：

```bash
git remote add origin https://github.com/<owner>/novellix-platform-builder.git
git push -u origin main
```

## 创建版本

首次发布可创建 `v1.0.0` 标签：

```bash
git tag -a v1.0.0 -m "Novellix Platform Builder v1.0.0"
git push origin v1.0.0
```

也可以在 GitHub 的 Releases 页面基于 `v1.0.0` 创建 Release。

## 安装验证

发布后，在另一台机器或临时 Codex 环境中执行：

```bash
python3 ~/.codex/skills/.system/skill-installer/scripts/install-skill-from-github.py \
  --repo <owner>/novellix-platform-builder \
  --path skills/novellix-platform-builder
```

重启 Codex 或开启一个新任务，然后调用：

```text
$novellix-platform-builder 帮我开发一套短剧系统。
```
