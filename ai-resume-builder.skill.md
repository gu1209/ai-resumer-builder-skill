# AI Resume Builder Skill

> 用户只需要把这个文件丢给 Claude Code，一切自动完成

## 🚀 首次使用（自动安装）

当用户第一次使用时，Claude 自动执行以下步骤：

### Step 1: 检查环境

```bash
# 检查 Python
python3 --version || python --version

# 检查 Node.js
node --version

# 检查 npm
npm --version
```

如果缺少环境，提示用户安装。

### Step 2: 克隆项目

```bash
# 克隆到用户目录（优先 GitHub，失败则用 Gitee 国内镜像）
git clone https://github.com/gu1209/AI-Resume-Builder.git ~/AI-Resume-Builder 2>/dev/null || \
git clone https://gitee.com/kris1209/AI-Resume-Builder.git ~/AI-Resume-Builder

cd ~/AI-Resume-Builder
```

### Step 3: 安装依赖

```bash
# Python 依赖
pip install -r requirements.txt

# Node.js 依赖
npm install puppeteer-core nunjucks
```

### Step 4: 本地修复（自动应用）

克隆完成后，Claude 自动修复以下已知问题（仅本地修改，不影响远程仓库）：

**修复 1：模板语法错误**
模板中使用了 Python 的 `.get()` 方法，nunjucks 不支持：

```bash
# Linux/Mac
sed -i "s/section\.content\.get('items', \[\] or \[\])/section.content.items or []/g" templates/resume.html.j2

# Windows PowerShell
(Get-Content templates\resume.html.j2) -replace "section\.content\.get\('items', \[\] or \[\]\)", "section.content.items or []" | Set-Content templates\resume.html.j2
```

**修复 2：Chrome 路径配置**
Puppeteer 需要 Chrome 浏览器，自动检测并配置路径：

```javascript
// 在 generate_puppeteer.js 中修改 executablePath
// Windows 示例：
executablePath: process.env.CHROME_PATH || 'C:\\Users\\用户名\\AppData\\Local\\Google\\Chrome\\Application\\chrome.exe'

// Linux 示例：
executablePath: process.env.CHROME_PATH || '/usr/bin/google-chrome'

// Mac 示例：
executablePath: process.env.CHROME_PATH || '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'
```

**修复 3：创建缺失的 experience_library.json**
```bash
# 如果文件不存在，创建默认的
if [ ! -f experience_library.json ]; then
  echo '{"internships":[],"projects":[],"skills":[],"educations":[]}' > experience_library.json
fi
```

**修复 4：重命名模板文件（如果需要）**
```bash
# 如果模板文件名是 index_simple.html，重命名为 index.html
if [ -f templates_gui/index_simple.html ] && [ ! -f templates_gui/index.html ]; then
  mv templates_gui/index_simple.html templates_gui/index.html
fi
```

### Step 5: 启动服务

**Linux/Mac:**
```bash
# 后台启动
nohup python resume_tool_simple.py > /dev/null 2>&1 &

# 等待服务启动
sleep 2

# 验证服务
curl -s http://localhost:2345 > /dev/null && echo "服务启动成功" || echo "服务启动失败"
```

**Windows (PowerShell):**
```powershell
# 后台启动
Start-Process python -ArgumentList "resume_tool_simple.py" -WindowStyle Hidden

# 等待服务启动
Start-Sleep -Seconds 3

# 验证服务
try {
    $response = Invoke-WebRequest -Uri "http://localhost:2345" -UseBasicParsing -TimeoutSec 5
    Write-Host "服务启动成功！状态码: $($response.StatusCode)"
} catch {
    Write-Host "服务访问失败: $($_.Exception.Message)"
}
```

## 📍 服务地址

- 本地：http://localhost:2345
- 在线体验：http://121.41.118.22:2345

## 🎯 核心功能

### 功能 1：从文件提取经历

用户只需提供文件，Claude 自动整理：

```
用户：这是我的简历/项目文档，帮我整理经历库
[粘贴内容或提供文件路径]
```

**Claude 执行步骤**：
1. 读取用户提供的文件内容
2. 使用正则表达式和关键词提取信息：
   - 教育背景：学校、专业、学位、时间、GPA
   - 实习经历：公司、职位、时间、工作内容
   - 项目经历：项目名、角色、时间、描述
   - 技能证书：类别、具体内容
3. 按标准格式整理成 JSON
4. 保存到 `~/AI-Resume-Builder/experience_library.json`

**输出格式**：
```json
{
  "educations": [
    {
      "id": "edu-xxx",
      "school": "学校名称",
      "major": "专业",
      "degree": "硕士/学士",
      "startDate": "2023.09",
      "endDate": "2026.06",
      "gpa": "3.8/4.0",
      "courses": ["课程1", "课程2"],
      "tags": [{"text": "985", "color": "#c53030", "bg": "#fed7d7"}],
      "order": 0,
      "enabled": true
    }
  ],
  "internships": [
    {
      "id": "int-xxx",
      "role": "职位名称",
      "organization": "公司名称",
      "dateRange": "2025.06 - 2025.12",
      "description": [
        {
          "id": "desc-xxx",
          "title": "工作内容标题",
          "content": "具体工作描述",
          "order": 0,
          "enabled": true
        }
      ],
      "tags": [],
      "order": 0,
      "enabled": true
    }
  ],
  "projects": [...],
  "skills": [...]
}
```

### 功能 2：根据 JD 优化简历

```
用户：我想投这个岗位，帮我优化简历
[粘贴 JD]
```

**Claude 执行步骤**：
1. 读取当前简历文件（默认 `~/AI-Resume-Builder/resumes/example-product.json`）
2. 分析 JD，提取关键词：
   - 技能要求（如：数据分析、用户增长）
   - 经验要求（如：有互联网产品实习）
   - 素质要求（如：沟通能力、团队协作）
3. 对比简历内容，生成优化建议
4. 用户确认后，直接修改 JSON 文件

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

**修改文件**：
```python
# 使用 Python 修改 JSON
import json

with open('~/AI-Resume-Builder/resumes/example-product.json', 'r') as f:
    data = json.load(f)

# 修改对应字段
# ...

with open('~/AI-Resume-Builder/resumes/example-product.json', 'w') as f:
    json.dump(data, f, ensure_ascii=False, indent=2)
```

### 功能 3：生成自我介绍

```
用户：帮我写一段给 HR 的自我介绍
```

**Claude 执行步骤**：
1. 读取简历文件
2. 提取教育背景（学校、专业、学位、毕业时间）
3. 提取与目标岗位匹配的关键经历（1-2 个亮点）
4. 生成 100 字以内的自然话术

**输出示例**：
```
💬 自我介绍（可直接复制）：

您好！我是天津大学金融硕士在读的顾杰，26年毕业。
之前在 Momenta 做过 AI 产品实习，独立设计并落地了基于飞书的
AI 智能助手，覆盖意图识别、Prompt 设计、数据检索全链路。
对 Agent 架构和 AI 产品落地有实际经验，很期待能聊聊！
```

### 功能 4：生成 PDF（通过 API）

```
用户：帮我生成 PDF
```

**Claude 执行步骤**：
1. 确保服务正在运行
2. 调用 PDF 生成接口

**PowerShell 方式**：
```powershell
# 生成当前简历的 PDF
$body = @{ resumeId = "example-product" } | ConvertTo-Json
$response = Invoke-RestMethod -Uri "http://localhost:2345/api/generate" -Method Post -ContentType "application/json" -Body $body

# 输出结果
Write-Host "生成结果: $($response | ConvertTo-Json -Depth 3)"

# PDF 文件位置
ls ~/AI-Resume-Builder/pdfs-puppeteer/*.pdf
```

**curl 方式（Linux/Mac）**：
```bash
# 生成当前简历的 PDF
curl -X POST http://localhost:2345/api/generate \
  -H "Content-Type: application/json" \
  -d '{"resumeId": "example-product"}'

# PDF 文件位置
ls ~/AI-Resume-Builder/pdfs-puppeteer/*.pdf
```

**直接调用 Node.js（不依赖服务）**：
```bash
# 直接生成 PDF
cd ~/AI-Resume-Builder
node generate_puppeteer.js --resume=example-product

# PDF 文件位置
ls pdfs-puppeteer/*.pdf
```

## 📁 数据文件说明

### 简历文件位置
```
~/AI-Resume-Builder/
├── resumes/
│   ├── example-product.json    # 示例简历
│   ├── internet-product.json   # 互联网产品方向
│   ├── finance.json            # 金融方向
│   └── public-sector.json      # 泛体制方向
├── experience_library.json     # 经历库
├── templates/
│   └── resume.html.j2          # PDF 模板
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
            "school": "学校名称",
            "major": "专业",
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
              "title": "工作内容",
              "content": "具体描述...",
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

## 💡 使用技巧

### 1. 首次使用
直接说：「帮我做一份简历」，Claude 会引导你完成

### 2. 批量投递
说：「我要投 5 个岗位，帮我分别优化」，Claude 会生成 5 个版本

### 3. 快速修改
说：「把实习经历的第二条改一下」，Claude 直接修改文件

### 4. 导出分享
说：「生成 PDF 发给 HR」，Claude 自动导出

### 5. 完全通过 Claude 操作
不需要打开浏览器，Claude 可以直接：
- 读取/修改简历 JSON
- 根据 JD 优化简历
- 生成自我介绍
- 调用 API 生成 PDF

## ⚠️ 注意事项

1. **首次使用需要网络**：需要克隆仓库和安装依赖
2. **PDF 生成需要 Node.js**：确保已安装 Node.js 16+
3. **中文字体**：Linux 服务器需要安装中文字体
4. **Ghostscript**：PDF 压缩需要 Ghostscript（可选）
5. **Chrome 浏览器**：PDF 生成需要 Chrome 或 Chromium
6. **本地修改**：Step 4 的修复仅应用于本地克隆，不影响远程仓库

## 🔧 常见问题

### Q: Claude 说找不到项目？
A: 让 Claude 重新克隆：「重新安装简历工具」

### Q: PDF 生成失败？
A: 让 Claude 检查环境：「检查 Node.js 和依赖是否安装」

### Q: 模板渲染错误？
A: 模板中使用了 `.get()` 方法，需要修复为直接访问：
```bash
# Linux/Mac
sed -i "s/section\.content\.get('items', \[\] or \[\])/section.content.items or []/g" templates/resume.html.j2

# Windows PowerShell
(Get-Content templates\resume.html.j2) -replace "section\.content\.get\('items', \[\] or \[\]\)", "section.content.items or []" | Set-Content templates\resume.html.j2
```

### Q: Chrome 找不到？
A: 需要配置 Chrome 路径，或设置环境变量 `CHROME_PATH`

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

Claude：PDF 已生成：~/AI-Resume-Builder/pdfs-puppeteer/张三-xxx.pdf
```

## 🔗 相关链接

- **GitHub**: https://github.com/gu1209/AI-Resume-Builder
- **Gitee（国内镜像）**: https://gitee.com/kris1209/AI-Resume-Builder
- **Skill 版**: https://github.com/gu1209/ai-resumer-builder-skill
- **在线体验**: http://121.41.118.22:2345
