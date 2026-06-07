# Resume Builder Skill

AI-powered Chinese resume optimization and interview preparation, directly in Claude Code.

## Trigger

User mentions any of: 简历, resume, CV, JD, 职位描述, 求职, 面试, 优化, 修改简历, 面经, 自我介绍, 打招呼

## Modes

This skill supports TWO modes depending on whether the user has the local server running:

### Mode 1: Local Server (Recommended)
If `http://localhost:2345` is accessible, delegate to the Flask API for all operations. The server provides:
- Resume editing with Web GUI
- PDF generation (Puppeteer)
- Experience library management
- Photo upload

**Quick setup**: `pip install flask jinja2 openai && python resume_tool_simple.py`

### Mode 2: Direct (No Server)
If no local server is running, Claude Code handles everything natively:
- JD optimization via direct API calls
- Interview search via WebSearch
- Resume data read/write from local JSON files

---

## Mode 1: Local Server API Reference

All endpoints are on `http://localhost:2345`.

### Resume Operations
```bash
# Load resume
curl http://localhost:2345/api/resume/<filename>

# Update field
curl -X POST http://localhost:2345/api/update \
  -H 'Content-Type: application/json' \
  -d '{"filename":"...","path":"versions.0.targetJob","value":"产品经理"}'

# Toggle visibility
curl -X POST http://localhost:2345/api/toggle \
  -H 'Content-Type: application/json' \
  -d '{"filename":"...","sectionId":"...","itemId":"...","bulletId":"...或空"}'

# Generate PDF
curl -X POST http://localhost:2345/api/generate \
  -H 'Content-Type: application/json' \
  -d '{"resumeId":"..."}'
```

### AI Operations (require API key)
```bash
# JD Optimization (anti-hallucination constrained)
curl -X POST http://localhost:2345/api/jd-optimize \
  -H 'Content-Type: application/json' \
  -d '{"filename":"...","jdText":"职位描述...","model":"deepseek-v4-flash","apiKey":"sk-..."}'

# AI Build Resume from library
curl -X POST http://localhost:2345/api/ai-build-resume \
  -H 'Content-Type: application/json' \
  -d '{"jdText":"...","model":"deepseek-v4-flash","apiKey":"sk-..."}'

# Generate self-introduction
curl -X POST http://localhost:2345/api/generate-intro \
  -H 'Content-Type: application/json' \
  -d '{"filename":"...","jdText":"...","model":"deepseek-v4-flash","apiKey":"sk-..."}'

# Generate interview report
curl -X POST http://localhost:2345/api/interview-report \
  -H 'Content-Type: application/json' \
  -d '{"filename":"...","jdText":"...","company":"字节跳动","model":"deepseek-v4-flash","apiKey":"sk-..."}'

# View report (returns report_id from above)
# Open in browser: http://localhost:2345/api/report/<report_id>/html
```

### Apply suggestions from report
```
The interview report HTML page has interactive [应用] buttons for each suggestion.
Or use API: POST /api/report/<report_id>/apply/<idx>
```

---

## Mode 2: Direct Operation (No Server)

When no local server, Claude Code executes these operations directly.

### Step 1: Get Resume Data
Ask user for their resume JSON file path or let them paste content. Parse to extract:
- name, targetJob, sections with items
- Each item has: id, type-specific fields, enabled flag

### Step 2: JD Optimization

Construct this prompt and send to DeepSeek API:

```
System: You are a resume wording optimization assistant. You MUST respond in Chinese.

User: 你是简历措辞优化顾问。你的任务是优化简历的表达方式，使之更匹配JD要求。

## 允许的操作（仅限以下）
1. **关键词对齐**：将简历中的用词替换为JD中的同义关键词
2. **表达精炼**：改进句式，使表达更专业、更简洁（不改变任何事实）
3. **冗余删除**：删除"深刻理解""显著提升""积累了丰富经验"等主观评价词
4. **顺序建议**：标注哪些经历与JD最匹配，建议前置

## 严格禁止
❌ 编造不存在的数据（百分比、金额、数量、转化率）
❌ 虚构项目名称、公司名称、技术名词、工具名
❌ 添加简历中没有的经历、成果、职责
❌ 改变工作范围（如将"参与"改成"主导"、"协助"改成"负责"）
❌ 添加JD中有但简历中没有的技能或经验

## 核心原则
- 只做"翻译"不做"创作"——用JD的语言重新表达简历中的既有事实
- 每条建议的suggested必须能从original中找到事实依据
- 如果原文已经很好，不要强行提建议

## 字数控制
每条要点控制在94字以内（约2行）。

返回严格JSON：
{"analysis":"JD关键要求概述","suggestions":[{"sectionId":"...","itemId":"...","bulletId":"...或空","field":"content/title/role/category","original":"原文完整内容","suggested":"仅措辞优化后的文本","reason":"修改原因（说明改了什么措辞）"}]}

JD：
<jd_text>

简历：
<resume_json>
```

Execute via: write a temp Python script → `python -c` → call openai → parse JSON result.

### Step 3: Display Results
Show each suggestion as:
- ~~原文（红色删除线）~~
- **建议（绿色加粗）**
- 💡 原因
- Offer to apply each suggestion

### Step 4: Interview Report Generation

When user asks for interview preparation:

1. **WebSearch** for interview experiences:
   ```
   Search: "{targetJob} 面试经验 面经 2025 2026"
   Search: "{targetJob} 面试题 高频面试"  
   (If company specified) Search: "{company} {targetJob} 面试流程"
   ```

2. **WebFetch** 2-3 most promising results to get detailed content.

3. **Match Analysis**: Compare JD requirements against resume skills/experience. List matched skills (✅), partial matches (⚠️), and gaps (❌).

4. **Synthesize report** with three sections:
   - 📊 Match Analysis (score, skill-by-skill breakdown)
   - ✏️ Resume Suggestions (anti-hallucination constrained, with apply buttons if server mode)
   - 💡 Interview Prep (categorized questions from real search results, preparation tips)

5. **Render** as formatted Markdown/HTML in the conversation.

### Step 5: Self-Introduction Generation

Prompt:
```
根据以下简历信息和目标岗位JD，生成一段简洁的自我介绍，用于给HR打招呼。

要求：
1. 字数控制在100字以内
2. 包含学历信息（学校、专业、学位、毕业时间）
3. 突出与JD最匹配的1-2个亮点
4. 语言自然、专业、有亲和力
5. 不要太正式，适合即时通讯场景

直接输出自我介绍内容，不要添加解释。
```

---

## Data Model

```json
{
  "name": "姓名",
  "fontSize": 10.5,
  "versions": [{
    "targetJob": "产品经理",
    "contactInfo": { "phone": "", "email": "", "birthDate": "", "location": "", "photo": "" },
    "sections": [
      {
        "id": "sec-edu", "type": "education", "title": "教育背景", "enabled": true, "order": 0,
        "content": { "items": [
          { "id": "edu-1", "school": "北京大学", "major": "计算机科学", "degree": "硕士",
            "startDate": "2024.9", "endDate": "2026.6", "gpa": "3.8/4.0", "courses": ["..."], "enabled": true, "order": 0 }
        ]}
      },
      {
        "id": "sec-intern", "type": "internship", "title": "实习经历", "enabled": true, "order": 1,
        "content": { "items": [
          { "id": "int-1", "role": "产品实习生", "organization": "字节跳动", "dateRange": "2025.4-2025.9",
            "description": [
              { "id": "desc-1", "title": "用户增长", "content": "通过A/B测试优化...", "enabled": true, "order": 0 }
            ], "enabled": true, "order": 0 }
        ]}
      },
      {
        "id": "sec-proj", "type": "project", "title": "项目经历", "enabled": true, "order": 2,
        "content": { "items": [
          { "id": "proj-1", "projectName": "智能推荐系统", "organization": "北京大学",
            "dateRange": "2024.10-2025.1",
            "description": [{ "id": "desc-1", "title": "...", "content": "...", "enabled": true, "order": 0 }],
            "enabled": true, "order": 0 }
        ]}
      },
      {
        "id": "sec-skills", "type": "skills", "title": "技能与证书", "enabled": true, "order": 3,
        "content": { "items": [
          { "id": "sk-1", "category": "编程语言", "content": "Python, SQL", "enabled": true, "order": 0 }
        ]}
      }
    ]
  }]
}
```

Key rules:
- Use `item.enabled !== false` for backward compatibility
- Sections sorted by `order` field
- Items within sections sorted by `order` field
- Bullet content supports HTML: `<b>`, `<strong>`, `<i>`, `<em>`

---

## Configuration

Required: DeepSeek API key (or compatible OpenAI API)
- Set via: environment variable `DEEPSEEK_API_KEY` or pass per-request
- Default base URL: `https://api.deepseek.com`
- Default model: `deepseek-v4-flash` (fast) or `deepseek-v4-pro` (powerful)

---

## Files

When user has cloned the repo, key files are:
- `resumes/*.json` — Resume data files
- `experience_library.json` — Master experience library
- `templates/resume.html.j2` — PDF HTML template
- `generate_puppeteer.js` — PDF generation script
- `resume_tool_simple.py` — Flask web server (for Mode 1)
- `interview_report.py` — Interview report module

---

## Anti-Hallucination Rules (ALWAYS apply)

When generating ANY resume content modifications:
1. NEVER invent data not in the original resume
2. NEVER change scope of responsibility (参与→主导, 协助→负责)
3. NEVER add skills/experience not present in the source
4. Only rephrase existing facts using JD-aligned terminology
5. If unsure whether a change is factual vs fabricated, flag for user review
6. Mark potentially suspicious suggestions with ⚠️
