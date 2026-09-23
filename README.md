# Novellix Skills

可复用的 Codex Skills，用于按照 Novellix 架构和设计系统构建多端内容产品。

## Included Skill

### `novellix-platform-builder`

用于构建小说、短剧、漫画、课程、音频和会员内容平台，覆盖：

- TypeScript / Express API
- Prisma / MySQL
- Next.js 管理后台
- Expo Web / iOS / Android
- Docker Compose / Nginx
- 语义化设计 Token
- 认证、内容生命周期、播放/阅读、权益、订单和部署规范

完整 Skill 位于：

```text
skills/novellix-platform-builder/
```

## 安装

将本仓库发布到 GitHub 后，使用 Codex 自带安装器：

```bash
python3 ~/.codex/skills/.system/skill-installer/scripts/install-skill-from-github.py \
  --repo <owner>/<repo> \
  --path skills/novellix-platform-builder
```

也可以直接让 Codex 安装：

```text
请安装这个 Skill：
https://github.com/<owner>/<repo>/tree/main/skills/novellix-platform-builder
```

安装完成后，在新的 Codex task 中调用：

```text
$novellix-platform-builder 帮我开发一套短剧系统。

品牌名叫星幕，主色使用黑色和红色。
需要用户端、管理后台、Web、iOS、Android、MySQL 和 Docker 部署。
```

## 发布前检查

```bash
./scripts/validate-repository.sh
```

不要把真实密码、Token、API Key、服务器凭据、客户数据或 `.env` 文件提交到公开仓库。

完整的 GitHub 发布步骤见 [PUBLISHING.md](PUBLISHING.md)。

## License

MIT，详见 [LICENSE](LICENSE)。
