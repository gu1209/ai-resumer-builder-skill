# AI Resume Builder Skill

> 用户只需要把这个文件丢给 Claude Code，一切自动完成

## 🚀 首次使用（自动安装）

当用户第一次使用时，Claude 自动执行：

```bash
# 1. 克隆项目到用户目录
git clone https://github.com/gu1209/AI-Resume-Builder.git ~/AI-Resume-Builder
cd ~/AI-Resume-Builder

# 2. 安装依赖
pip install -r requirements.txt
npm install puppeteer-core nunjucks

# 3. 启动服务（后台运行）
nohup python resume_tool_simple.py > /dev/null 2>&1 &
```

## 📍 服务地址

本地：http://localhost:2345
在线体验：http://121.41.118.22:2345

## 🎯 核心功能

### 功能 1：从文件提取经历

用户只需提供文件，Claude 自动整理：

```
用户：这是我的简历/项目文档，帮我整理经历库
[粘贴内容或提供文件路径]

Claude 自动：
1. 读取文件内容
2. 提取教育、实习、项目、技能
3. 按标准格式整理
4. 保存到 experience_library.json
```

**输出格式**：
```json
{
  "educations": [{"school": "...", "major": "...", "degree": "...", ...}],
  "internships": [{"role": "...", "organization": "...", "description": [...]}],
  "projects": [{"projectName": "...", "role": "...", "description": [...]}],
  "skills": [{"category": "...", "content": "..."}]
}
```

### 功能 2：根据 JD 优化简历

```
用户：我想投这个岗位，帮我优化简历
[粘贴 JD]

Claude 自动：
1. 分析 JD 关键要求（技能、经验、素质）
2. 读取当前简历
3. 逐条对比，找出匹配点和差距
4. 提供具体优化建议
5. 用户确认后直接修改 JSON 文件
```

**输出示例**：
```
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

### 功能 3：生成自我介绍

```
用户：帮我写一段给 HR 的自我介绍

Claude 自动：
1. 读取简历中的教育背景
2. 提取与目标岗位匹配的关键经历
3. 生成 100 字以内的自然话术
```

**输出示例**：
```
💬 自我介绍（可直接复制）：

您好！我是天津大学金融硕士在读的顾杰，26年毕业。
之前在 Momenta 做过 AI 产品实习，独立设计并落地了基于飞书的
AI 智能助手，覆盖意图识别、Prompt 设计、数据检索全链路。
对 Agent 架构和 AI 产品落地有实际经验，很期待能聊聊！
```

### 功能 4：生成 PDF

```
用户：帮我生成 PDF

Claude 自动：
1. 调用 generate_puppeteer.js
2. 生成高质量 PDF
3. 自动压缩（文件大小减少 95%）
4. 返回下载链接
```

## 📁 数据文件说明

### 简历文件位置
```
~/AI-Resume-Builder/
├── resumes/
│   ├── internet-product.json   # 互联网产品方向
│   ├── finance.json            # 金融方向
│   └── public-sector.json      # 泛体制方向
├── experience_library.json     # 经历库
└── pdfs-puppeteer/             # 生成的 PDF
```

### 简历 JSON 结构

```json
{
  "id": "r-xxx",
  "name": "张三",
  "fontSize": 10.5,
  "versions": [{
    "id": "v-xxx",
    "title": "互联网产品方向",
    "targetJob": "产品经理",
    "contactInfo": {
      "phone": "13800138000",
      "email": "zhangsan@example.com",
      "birthDate": "2000.01",
      "location": "北京",
      "availability": "可立即到岗"
    },
    "sections": [...]
  }]
}
```

## 💡 使用技巧

### 1. 首次使用
直接说：「帮我做一份简历」，Claude 会引导你完成

### 2. 批量投递
说：「我要投 5 个岗位，帮我分别优化」，Claude 会生成 5 个版本

### 3. 快速修改
说：「把实习经历的第二条改一下」，Claude 直接修改文件

### 4. 导出分享
说：「生成 PDF 发给 HR」，Claude 自动导出

## ⚠️ 注意事项

1. **首次使用需要网络**：需要克隆仓库和安装依赖
2. **PDF 生成需要 Node.js**：确保已安装 Node.js 16+
3. **中文字体**：Linux 服务器需要安装中文字体
4. **Ghostscript**：PDF 压缩需要 Ghostscript

## 🔧 常见问题

### Q: Claude 说找不到项目？
A: 让 Claude 重新克隆：「重新安装简历工具」

### Q: PDF 生成失败？
A: 让 Claude 检查环境：「检查 Node.js 和依赖是否安装」

### Q: 如何更新 Skill？
A: 重新下载最新的 .skill.md 文件丢给 Claude 即可

## 📖 完整对话示例

```
用户：我想找产品经理实习，帮我做一份简历

Claude：好的，我来帮你！首先让我了解一下你的情况：
1. 你现在是什么学校什么专业？
2. 有哪些实习或项目经历？
3. 目标公司是哪些？

用户：我是天津大学金融硕士，有一段 AI 产品实习...

Claude：好的，我来帮你整理简历。
[自动创建简历 JSON]
[引导用户补充细节]
[按 STAR 法则整理经历]

简历已创建，是否需要：
1. 针对某个 JD 优化？
2. 生成 PDF？
3. 写一段自我介绍？

用户：帮我针对字节的产品经理优化一下
[粘贴 JD]

Claude：
📋 JD 分析：...
📊 匹配度：...
💡 优化建议：...

是否应用？

用户：好的

Claude：已应用！是否生成 PDF？

用户：是的

Claude：PDF 已生成：~/AI-Resume-Builder/pdfs-puppeteer/顾杰-xxx.pdf
```

## 🔗 相关链接

- **GitHub**: https://github.com/gu1209/AI-Resume-Builder
- **Skill 版**: https://github.com/gu1209/ai-resumer-builder-skill
- **在线体验**: http://121.41.118.22:2345
