# AI Resume Builder - Claude Code Skill

> 🎯 **一句话**：把这个文件丢给 Claude Code，它就能帮你做简历

## 🚀 使用方法

### 第一步：下载 Skill 文件

点击下载：[ai-resume-builder.skill.md](./ai-resume-builder.skill.md)

### 第二步：丢给 Claude Code

直接把文件拖进 Claude Code 窗口，或者复制内容粘贴进去

### 第三步：开始对话

```
帮我做一份简历
```

就这么简单！Claude 会自动完成所有事情。

---

## ✨ 功能

| 功能 | 说明 |
|------|------|
| 📚 提取经历 | 提供旧简历/文档，自动整理成经历库 |
| 🎯 优化简历 | 粘贴 JD，自动分析并优化 |
| 💬 自我介绍 | 生成 100 字以内给 HR 的话术 |
| 📄 生成 PDF | 一键导出，自动压缩 |
| 🌐 国内镜像 | 支持 Gitee 克隆，解决网络问题 |

---

## 💬 使用示例

### 示例 1：从零开始

```
用户：帮我做一份产品经理的简历

Claude：好的！先了解一下你的情况...
[自动引导、整理、生成]
```

### 示例 2：优化现有简历

```
用户：我想投字节的产品经理，帮我优化
[粘贴 JD]

Claude：分析 JD 关键要求... 对比简历... 优化建议...
[自动修改]
```

### 示例 3：生成自我介绍

```
用户：帮我写一段给 HR 的自我介绍

Claude：根据你的简历和目标岗位：
您好！我是天津大学金融硕士在读的顾杰...
```

### 示例 4：生成 PDF

```
用户：帮我生成 PDF

Claude：PDF 已生成：~/AI-Resume-Builder/pdfs-puppeteer/张三-xxx.pdf
```

---

## 🔧 技术特性

- **自动环境检测**：Python、Node.js、npm
- **智能克隆**：优先 GitHub，失败自动切换 Gitee 国内镜像
- **本地修复**：自动修复模板语法、Chrome 路径等问题
- **API 调用**：支持通过 API 生成 PDF，无需打开浏览器
- **跨平台**：Windows、Linux、macOS 全支持

---

## ❓ 常见问题

**Q: 需要安装什么吗？**
A: 不用！Claude 会自动安装所有依赖

**Q: 需要 API Key 吗？**
A: 不需要！用 Claude 自己的能力

**Q: 数据安全吗？**
A: 所有数据在本地处理，不会上传

**Q: 国内网络不好怎么办？**
A: Skill 自动使用 Gitee 国内镜像

**Q: PDF 生成失败？**
A: Claude 会自动检测并修复 Chrome 路径问题

---

## 🔗 相关项目

- [GitHub 仓库](https://github.com/gu1209/AI-Resume-Builder)
- [Gitee 国内镜像](https://gitee.com/kris1209/AI-Resume-Builder)
- [在线体验](http://121.41.118.22:2345)

---

## 📄 许可证

MIT License
