# Novellix Platform Builder

一个用于 Codex 的可复用 Skill：按照 Novellix 的架构和设计规范，构建带有用户端、管理后台、Web、iOS、Android、MySQL 和 Docker 部署能力的内容型产品。

适用领域：小说、短剧、漫画、课程、音频和会员内容平台。

## 目录

```text
.
├── SKILL.md
├── agents/openai.yaml
├── assets/design-tokens.json
├── references/
│   ├── architecture.md
│   ├── delivery-playbook.md
│   ├── design-system.md
│   ├── domain-blueprints.md
│   └── security-and-deployment.md
└── scripts/validate-skill.sh
```

## 安装到 Codex

将本目录放进 GitHub 仓库的 `skills/novellix-platform-builder` 后，可以让 Codex 安装：

```text
请安装这个 Skill：
https://github.com/<owner>/<repo>/tree/main/skills/novellix-platform-builder
```

或者运行 Codex 自带安装脚本：

```bash
python3 ~/.codex/skills/.system/skill-installer/scripts/install-skill-from-github.py \
  --repo <owner>/<repo> \
  --path skills/novellix-platform-builder
```

默认安装到：

```text
~/.codex/skills/novellix-platform-builder
```

安装完成后新建一个 Codex task，再调用这个 Skill。不同宿主可能缓存已加载的 Skill。

## 使用示例

```text
$novellix-platform-builder 帮我开发一套短剧系统。

品牌名叫星幕，主色使用黑色和红色。
需要用户端、管理后台、Web、iOS、Android、MySQL 和 Docker 部署。
```

也可以用于其他内容产品：

```text
$novellix-platform-builder 帮我开发一个漫画平台。

品牌名叫墨页，使用黑白和靛蓝色。
需要 Web、iOS、Android、管理后台、MySQL 和 Docker。
```

## 设计原则

- 一个权威 API 服务用户端和管理后台。
- 客户端不直接连接 MySQL，也不负责最终的权益、支付和角色判断。
- 业务内容与 UI 语言切换分离；除非明确要求，不翻译用户存储的内容。
- 颜色、间距、圆角和状态使用语义 Token。
- 管理后台优先考虑高密度运营效率，用户端优先考虑内容消费体验。
- 视频、音频和大图片进入对象存储、CDN 或媒体服务，不写入 MySQL。
- 开发态样片、模拟支付和开发授权必须明确标注，并在生产环境关闭。

## 发布前检查

```bash
./scripts/validate-skill.sh
```

检查会确认支持资源存在、名称一致、主题 Token 合法、没有明显密钥内容和软链接。

公开仓库不应包含真实密码、JWT、API Key、服务器 IP、客户数据或 `.env` 文件。

## 版本

使用语义化版本：

```bash
git tag -a v1.0.0 -m "Initial public release"
git push origin v1.0.0
```

## 许可证

MIT。Skill 本身的许可证不替代生成项目中图片、字体、视频、SDK 或第三方服务的原始许可证和合规要求。
