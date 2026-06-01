# AI Resume Builder - Claude Code Skill

> 🎯 让 Claude Code 成为你的简历助手：智能匹配经历、优化简历、生成 PDF

## ✨ 三大版本

| 版本 | 说明 | AI 能力 | 用户管理 |
|------|------|---------|----------|
| **Claude Code Skill** | 本仓库 | Claude 原生能力 | ❌ |
| [Web 完整版](https://github.com/gu1209/AI-Resume-Builder) | Flask + 用户系统 | DeepSeek API | ✅ |
| [Web 开源版](https://github.com/gu1209/AI-Resume-Builder) | Flask 简化版 | DeepSeek API | ❌ |

## 🚀 快速开始

### 1. 安装 Skill

```bash
# 克隆仓库
git clone https://github.com/gu1209/ai-resumer-builder-skill.git
cd ai-resumer-builder-skill

# 运行安装脚本
./setup.sh      # Linux/Mac
setup.bat       # Windows
```

### 2. 部署 PDF 生成工具

```bash
# 克隆主项目
git clone https://github.com/gu1209/AI-Resume-Builder.git
cd AI-Resume-Builder

# 安装依赖
pip install -r requirements.txt
npm install puppeteer-core nunjucks
```

### 3. 开始使用

在 Claude Code 中直接对话：

```
帮我整理这份简历的经历库
```

## 🎯 核心功能

### 📚 从文件总结经历库

提供旧简历、项目文档等文件，Claude 自动提取并整理：

```
用户：这是我的旧简历和项目文档，帮我整理成经历库
[提供文件]

Claude 自动提取：
- 教育背景
- 实习经历
- 项目经历
- 技能证书
```

### 🎯 根据 JD 优化简历

无需外部 API，直接用 Claude 分析：

```
用户：我想投这个产品经理岗位，帮我优化简历
[粘贴 JD]

Claude：
1. 分析 JD 关键要求
2. 对比简历内容
3. 提供逐条优化建议
4. 用户确认后直接修改
```

### 💬 生成自我介绍

```
用户：帮我写一段给 HR 的自我介绍

Claude 生成 100 字以内的话术，可直接复制使用
```

### 📄 生成 PDF

```
用户：帮我生成 PDF

Claude 调用 Puppeteer 生成高质量 PDF，自动压缩
```

## 🔧 技术实现

### Skill 工作原理

```
用户输入 → Claude Code → 读取本地文件 → Claude 分析 → 输出结果
                ↓
         调用 generate_puppeteer.js → 生成 PDF
```

### 与 Web 版的区别

| 功能 | Skill 版 | Web 版 |
|------|----------|--------|
| AI 分析 | Claude 原生 | DeepSeek API |
| API Key | 不需要 | 需要配置 |
| 用户管理 | 无 | 有 |
| 界面 | CLI 对话 | Web UI |
| 离线使用 | 部分功能 | 需要网络 |

## 📖 使用场景

### 场景 1：从零开始

```
用户：我找实习，帮我做一份简历

Claude：
1. 了解你的背景和目标岗位
2. 引导你描述经历
3. 按 STAR 法则整理
4. 生成简历 JSON
5. 导出 PDF
```

### 场景 2：优化现有简历

```
用户：我想投字节的产品经理，帮我优化简历
[粘贴 JD]

Claude：
1. 分析 JD 关键要求
2. 对比你的简历
3. 给出具体优化建议
4. 你确认后直接修改
```

### 场景 3：批量投递

```
用户：我要投 5 个不同岗位，帮我分别优化

Claude：
1. 分析每个 JD 的差异
2. 为每个岗位生成针对性版本
3. 分别导出 PDF
```

## 📁 文件说明

| 文件 | 说明 |
|------|------|
| `ai-resume-builder.skill.md` | Skill 主文件 |
| `README.md` | 本文件 |
| `INSTALL.md` | 安装指南 |
| `setup.sh` / `setup.bat` | 安装脚本 |
| `LICENSE` | MIT 许可证 |

## 🔗 相关链接

- **Web 版**: https://github.com/gu1209/AI-Resume-Builder
- **Skill 版**: https://github.com/gu1209/ai-resumer-builder-skill
- **在线体验**: http://121.41.118.22:2345

## 📝 更新日志

### v1.0.0 (2026-06-01)
- ✨ 初始版本
- 📚 从文件提取经历
- 🎯 JD 匹配优化
- 💬 自我介绍生成
- 📄 PDF 导出

## 🤝 贡献

欢迎 Issue 和 PR！

## 📄 许可证

MIT License

---

**如果觉得有用，欢迎点个 ⭐ Star 支持一下！**
