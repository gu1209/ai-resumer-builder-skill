# AI Resume Builder · Claude Code Skill

<p align="center">
  <a href="https://github.com/gu1209/AI-Resume-Builder"><b>📦 主仓库</b></a> ·
  <a href="http://121.41.118.22:2345"><b>🚀 在线体验</b></a>
</p>

---

> 把这个 Skill 装到 Claude Code，对话就能做简历。**不需要 git clone，不需要装任何东西。**

## 🚀 安装

在 Claude Code 中输入：

```
/install-skill https://raw.githubusercontent.com/gu1209/ai-resumer-builder-skill/master/ai-resume-builder/AI-Resume-Builder.skill.md
```

完成。不需要任何 API Key，Claude Code 本身就是 AI。

## ✨ 能做什么

| 功能 | 用法 |
|------|------|
| **JD 优化** | "帮我分析这个JD，优化我的简历" + 粘贴 JD |
| **面试报告** | "帮我生成字节跳动产品经理的面试准备报告" |
| **AI 构建简历** | "根据这个 JD 帮我从经历库里选经历，做一份新简历" |
| **自我介绍** | "帮我写一段给 HR 的自我介绍" |
| **PDF 生成** | "帮我生成 PDF"（需要本地有 Flask 服务） |

## 🎯 两种模式

### 模式一：纯对话（零依赖）

Claude Code 直接调用 AI + 搜索，对话内输出结果。适合快速分析和建议，不需要安装任何东西。

### 模式二：本地服务（完整功能）

克隆仓库启动 Flask 后，支持 PDF 生成、Web 界面编辑、一键应用修改等完整功能。

```bash
git clone https://github.com/gu1209/AI-Resume-Builder.git
cd AI-Resume-Builder
pip install flask jinja2 openai && npm install
python resume_tool_simple.py
```

## 🛡️ 反幻觉保护

所有 AI 修改建议严格遵循：

- ❌ 不编造数据、不虚构经历、不篡改职责范围
- ✅ 只优化措辞：用 JD 的语言重新表达已有事实
- ⚠️ 改动过大时自动标记提醒审核

## 🔗 链接

- [主仓库](https://github.com/gu1209/AI-Resume-Builder) — 开源代码 + Web 工具
- [在线 Demo](http://121.41.118.22:2345) — 直接体验
- [DeepSeek API](https://platform.deepseek.com/api_keys) — 获取 API Key

## 📄 许可证

CC BY-NC 4.0 — 署名 · 非商业使用
