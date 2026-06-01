# AI Resume Builder Skill

> Claude Code 简历助手：智能匹配经历、优化简历、生成 PDF

## 触发条件

当用户提到以下关键词时激活此 Skill：
- 简历、resume、CV
- 求职、找工作、投递
- JD、岗位描述、职位描述
- 简历优化、简历生成、自我介绍

## 核心能力

### 1. 📚 从文件总结经历库

用户可以提供以下文件，Claude 自动提取经历信息：
- 旧简历（PDF/Word/文本）
- 个人经历档案
- 工作总结/项目文档
- 实习证明/推荐信

**操作流程**：
```
用户：这是我之前的简历和项目文档，帮我整理成经历库
[提供文件]

Claude：
1. 读取文件内容
2. 提取教育、实习、项目、技能等信息
3. 按标准格式整理
4. 生成 experience_library.json
5. 保存到 resumes/ 目录
```

### 2. 🎯 根据 JD 优化简历

无需调用外部 API，直接用 Claude 分析：

```
用户：我想投这个产品经理岗位，帮我优化简历
[粘贴 JD]

Claude：
1. 分析 JD 的关键要求（技能、经验、素质）
2. 读取用户当前简历
3. 逐条对比，找出匹配点和差距
4. 提供具体的优化建议：
   - 哪些经历应该突出
   - 哪些描述需要调整
   - 如何用 STAR 法则重写
   - 字数控制建议
5. 用户确认后，直接修改 JSON 文件
```

### 3. 💬 生成自我介绍

```
用户：帮我写一段给 HR 的自我介绍

Claude：
1. 读取简历中的教育背景
2. 提取与目标岗位匹配的关键经历
3. 生成 100 字以内的自然话术
4. 输出可直接复制的内容
```

### 4. 📄 生成 PDF

```
用户：帮我生成 PDF

Claude：
1. 调用 generate_puppeteer.js
2. 生成高质量 PDF
3. 自动压缩
4. 返回下载链接
```

## 工具依赖

Skill 需要访问以下本地工具：

### 必需
- `generate_puppeteer.js` — PDF 生成脚本
- `templates/resume.html.j2` — 简历模板
- Node.js + puppeteer-core + nunjucks

### 可选
- Ghostscript — PDF 压缩

## 文件结构

```
AI-Resume-Builder/
├── resume_tool_simple.py   # Web 后端（可选）
├── generate_puppeteer.js   # PDF 生成
├── templates/
│   └── resume.html.j2      # 简历模板
├── resumes/                # 简历 JSON 文件
├── experience_library.json # 经历库
└── skills/
    └── resume.skill.md     # 本 Skill 文件
```

## 数据格式

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
    "sections": [
      {
        "id": "sec-edu",
        "type": "education",
        "title": "教育背景",
        "enabled": true,
        "order": 0,
        "content": {
          "items": [{
            "id": "edu-001",
            "school": "北京大学",
            "major": "计算机科学",
            "degree": "硕士",
            "startDate": "2023.09",
            "endDate": "2026.06",
            "gpa": "3.8/4.0",
            "tags": [{"text": "985", "color": "#c53030", "bg": "#fed7d7"}],
            "enabled": true
          }]
        }
      },
      {
        "id": "sec-intern",
        "type": "internship",
        "title": "实习经历",
        "enabled": true,
        "order": 1,
        "content": {
          "items": [{
            "id": "int-001",
            "role": "产品实习生",
            "organization": "某互联网公司",
            "dateRange": "2025.06 - 2025.12",
            "description": [{
              "id": "desc-001",
              "title": "用户增长项目",
              "content": "负责用户增长策略设计...",
              "enabled": true
            }],
            "tags": [{"text": "产品", "color": "#2d5a27", "bg": "#e8f0e6"}],
            "enabled": true
          }]
        }
      }
    ]
  }]
}
```

### 经历库结构

```json
{
  "educations": [...],
  "internships": [...],
  "projects": [...],
  "skills": [...],
  "honors": [...],
  "certificates": [...]
}
```

## 使用示例

### 示例 1：从旧简历提取经历

```
用户：这是我的旧简历，帮我整理成经历库
[提供 PDF 或文本]

Claude：
好的，我来帮你提取经历信息...

提取结果：
📚 教育背景
- 北京大学 | 计算机科学 | 硕士 | 2023.09-2026.06

💼 实习经历
1. 某互联网公司 - 产品实习生 (2025.06-2025.12)
   - 用户增长项目：负责用户增长策略设计，转化率提升 25%
   - 功能迭代优化：主导 APP 首页改版，停留时长提升 20%

🔧 项目经历
1. 校园社交小程序 (2024.09-2025.03)
   - 从 0 到 1 设计，3 个月获取 5000+ 用户

已保存到 experience_library.json，是否需要调整？
```

### 示例 2：根据 JD 优化简历

```
用户：我想投字节跳动的产品经理，帮我优化简历
[粘贴 JD]

Claude：
分析 JD 关键要求：
1. 用户洞察能力
2. 数据分析能力
3. 跨团队协作
4. 有互联网产品实习经验

对比你的简历：
✅ 用户增长项目 - 突出数据驱动决策
✅ APP 改版项目 - 强调用户调研方法
⚠️ 缺少跨团队协作的描述

优化建议：
1. 用户增长项目：增加 "协调设计、开发团队" 的描述
2. 添加数据指标：转化率 25%、DAU 增长 40%

是否应用这些修改？
```

### 示例 3：生成自我介绍

```
用户：帮我写一段给字节 HR 的自我介绍

Claude：
根据你的简历和目标岗位，推荐以下自我介绍：

---
您好！我是北京大学计算机硕士在读的张三，26 年毕业。
之前在某互联网公司做过产品实习，主导了用户增长策略设计，
通过数据驱动的方式将转化率提升了 25%。
对用户洞察和数据分析有实际经验，很期待能聊聊贵司的产品岗位！
---
（98 字，可直接复制使用）
```

## 注意事项

1. **数据安全**：所有数据处理在本地完成，不会上传到第三方
2. **文件格式**：支持 JSON 格式的简历文件
3. **PDF 生成**：需要 Node.js 和 Puppeteer 环境
4. **字体要求**：PDF 生成需要中文字体支持

## 版本记录

### v1.0.0 (2026-06-01)
- ✨ 初始版本
- 📚 从文件提取经历
- 🎯 JD 匹配优化
- 💬 自我介绍生成
- 📄 PDF 导出
