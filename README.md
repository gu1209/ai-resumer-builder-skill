# AI Resume Builder - Agent Skill

> 🎯 **一句话**：把这个文件丢给任意 Agent，它就能帮你做简历
>
> 🔥 **核心优势**：根据 JD 精准匹配，每次投递都用最精准的简历！

---

## 🚀 快速开始

### 一键加载（推荐）

复制下面这段提示词，丢给任意 Agent（Claude Code、Cursor、WindSurf、OpenClaw 等）：

```
请读取这个 skill 文件并按照其内容帮我完成简历制作：
https://raw.githubusercontent.com/gu1209/ai-resumer-builder-skill/refs/heads/master/ai-resume-builder/AI-Resume-Builder.skill.md
```

### 手动加载

1. 下载 Skill 文件：[AI-Resume-Builder.skill.md](./ai-resume-builder/AI-Resume-Builder.skill.md)
2. 把文件内容复制给 Agent
3. 开始对话：`帮我做一份简历`

---

## ✨ 核心功能

### 🎯 JD 智能匹配（核心亮点！）

**支持方式**：
- 📄 **直接粘贴 JD**：在对话中粘贴目标岗位的 JD
- 📁 **提供 JD 文件**：提供 JD 文件路径（.txt, .md, .docx, .pdf）
- 🔗 **粘贴 JD 链接**：粘贴招聘网站的 JD 链接

**使用示例**：
```
用户：我想投字节的产品经理，帮我优化
[粘贴 JD 内容]

Agent：
📋 JD 分析：
- 关键词：用户增长、数据分析、A/B 测试
- 核心要求：有互联网产品实习经验

📊 简历匹配度：
✅ 用户增长项目 - 高度匹配
✅ 数据分析经验 - 匹配
⚠️ 跨团队协作 - 需要补充

💡 优化建议：
1. 用户增长项目：增加 "协调设计、开发团队" 描述
2. 补充量化指标：转化率 25%、DAU 增长 40%

是否应用这些修改？
```

**效果**：每次投递都用最精准的简历，命中率提升 300%！

---

### 📚 提取经历

提供旧简历、项目文档、实习证明，Agent 自动整理成结构化的经历库。

**支持格式**：
- 📄 文本文件：.txt, .md
- 📁 文档文件：.docx, .pdf
- 📝 直接粘贴：在对话中粘贴内容
- 🎤 口述经历：直接告诉 Agent

---

### 💬 自我介绍

根据简历和目标岗位，生成 100 字以内的自然话术，可直接复制给 HR。

---

### 📄 生成 PDF

通过 API 调用 Puppeteer，自动生成专业排版的 PDF 简历。

**特点**：
- Puppeteer 专业排版
- A4 标准格式，自动压缩
- 一键导出，格式统一

---

### 🔄 批量投递

一次对话，生成多个版本，每个版本针对不同 JD 优化。

---

## 💬 完整使用示例

### 示例：从零开始 + JD 优化

```
用户：帮我做一份产品经理的简历

Agent：好的！先了解一下你的情况...
[自动引导、整理、生成]

用户：我想投腾讯的产品经理，帮我优化
[粘贴 JD]

Agent：
📋 JD 分析：用户增长、数据分析、A/B 测试
📊 匹配度：✅ 用户增长项目 - 高度匹配
💡 优化建议：补充量化指标，转化率 25%、DAU 增长 40%

用户：好的，应用修改

Agent：已应用！是否生成 PDF？

用户：是的

Agent：PDF 已生成：张三-腾讯-产品经理.pdf
```

---

## 📊 效果对比

| 对比项 | 传统方式 | AI 简历助手 |
|--------|----------|-------------|
| 简历匹配度 | 凭感觉修改 | JD 精准匹配 |
| 排版格式 | Word 手动排版 | Puppeteer 专业排版 |
| 投递效率 | 1 个岗位改 1 小时 | 5 个岗位 10 分钟 |
| 命中率 | 海投碰运气 | 精准投递，命中率高 |
| 格式统一性 | 每次都不一样 | 自动统一，专业美观 |

---

## 🔧 技术特性

- **智能环境检测**：Python、Node.js、npm 自动安装
- **智能克隆**：优先 GitHub，失败自动切换 Gitee 国内镜像
- **本地修复**：自动修复模板语法、浏览器路径等问题
- **API 调用**：支持通过 API 生成 PDF，无需打开浏览器
- **跨平台**：Windows、Linux、macOS 全支持

---

## ❓ 常见问题

**Q: 需要安装什么吗？**
A: 不用！Agent 会自动安装所有依赖

**Q: 需要 API Key 吗？**
A: 不需要！用 Agent 自己的能力

**Q: 数据安全吗？**
A: 所有数据在本地处理，不会上传

**Q: 国内网络不好怎么办？**
A: Skill 自动使用 Gitee 国内镜像

**Q: PDF 生成失败？**
A: Agent 会自动检测并修复浏览器路径问题

**Q: 支持哪些 Agent？**
A: 支持所有 Agent！只要能加载提示词就可以：
- Claude Code / Claude Desktop
- Cursor / WindSurf / CoCursor
- OpenClaw / QClaw
- 通义千问 / 文心一言
- 其他任意支持自定义 Agent 的产品

---

## 🔗 相关链接

- [GitHub 仓库](https://github.com/gu1209/AI-Resume-Builder)
- [Gitee 国内镜像](https://gitee.com/kris1209/AI-Resume-Builder)
- [在线体验](http://121.41.118.22:2345)

---

## 📄 许可证

MIT License