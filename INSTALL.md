# 安装说明

## 超级简单版（推荐）

1. 下载 `ai-resume-builder.skill.md`
2. 拖进 Claude Code
3. 完成！

就这么简单，不需要任何命令行操作。

---

## 如果你想要手动安装

### 1. 安装 Skill

```bash
# 克隆仓库
git clone https://github.com/gu1209/ai-resumer-builder-skill.git

# 复制 Skill 文件到 Claude Code 配置目录
cp ai-resume-builder.skill.md ~/.claude/skills/
```

### 2. 安装简历工具

```bash
# 克隆项目
git clone https://github.com/gu1209/AI-Resume-Builder.git
cd AI-Resume-Builder

# 安装依赖
pip install -r requirements.txt
npm install puppeteer-core nunjucks

# 启动
python resume_tool_simple.py
```

### 3. 开始使用

在 Claude Code 中说「帮我做一份简历」

---

## 环境要求

- Python 3.8+
- Node.js 16+
- Ghostscript（可选，用于 PDF 压缩）

## 常见问题

### Q: Claude 说找不到项目？
A: 让 Claude 重新安装：「重新安装简历工具」

### Q: PDF 生成失败？
A: 检查 Node.js 是否安装：`node --version`

### Q: 如何更新？
A: 重新下载 .skill.md 文件丢给 Claude 即可
