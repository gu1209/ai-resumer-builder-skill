# Resume Builder Skill

AI-powered Chinese resume optimization and interview preparation. Claude Code handles everything natively — no external API key needed.

## Trigger

User mentions: 简历, resume, CV, JD, 职位描述, 求职, 面试, 优化, 面经, 自我介绍

## How It Works

Claude Code IS the AI. No external API calls needed. Claude Code:
- Reads and analyzes the user's resume JSON
- Compares it against the JD using native reasoning
- Suggests wording optimizations following anti-hallucination rules
- Uses WebSearch to find real interview experiences
- Generates formatted reports directly in the conversation

**Optional**: If `http://localhost:2345` is running, delegate to the Flask server for PDF generation and Web GUI.

---

## Workflows

### 1. JD Optimization

When user provides a JD and wants resume optimized:

1. **Read** the resume JSON file (user provides path or pastes content)
2. **Analyze** the JD: extract key skills, experience requirements, keywords
3. **Compare** each section of the resume against JD requirements
4. **Suggest changes** following these strict rules:

**Allowed (措辞优化)**
- Replace words with JD-aligned synonyms (e.g., "数据处理" → "数据分析" if JD uses that term)
- Improve sentence flow and professionalism (without changing facts)
- Remove subjective fluff ("深刻理解", "显著提升", "积累了丰富经验")

**Forbidden (禁止编造)**
- NEVER invent numbers, percentages, or metrics not in the original
- NEVER create fake project names, company names, or technologies
- NEVER inflate roles ("参与" → "主导", "协助" → "负责")
- NEVER add skills or experiences not present in the resume
- NEVER fabricate STAR details (situation, task context)

5. **Display** each suggestion as:
   ```
   ~~原文（红色删除线）~~
   **建议（绿色加粗）**
   💡 修改原因
   ```
6. **Apply**: Ask user "是否应用这些修改？" before writing back to JSON

### 2. Interview Preparation Report

When user wants interview prep for a specific role/company:

1. **WebSearch** for real interview experiences:
   ```
   "{targetJob} 面试经验 面经 2025 2026"
   "{targetJob} 面试题 高频"
   "{company} {targetJob} 面试流程"  (if company specified)
   ```

2. **WebFetch** 2-3 most promising results for detailed content

3. **Generate report** with three sections directly in the conversation:

**📊 匹配度分析**
- Overall match score (estimated from JD vs resume comparison)
- Skill-by-skill breakdown: ✅ matched / ⚠️ partial / ❌ missing
- Gap analysis: what the JD requires but the resume lacks

**✏️ 简历修改建议**
- Specific wording changes following anti-hallucination rules
- Each suggestion shows original → suggested → reason

**💡 面试经验**
- High-frequency questions (from search results, categorized)
- Answer approach tips (general strategies, no made-up personal stories)
- Company-specific insights (if company provided)

### 3. AI Build Resume from Library

When user wants a new resume built from their experience library:

1. Read the experience library JSON (`experience_library.json`)
2. Analyze JD requirements
3. Select the most relevant internships, projects, and skills
4. Organize into a complete resume JSON structure
5. Only rephrase existing descriptions for JD alignment — never add fake content

### 4. Self-Introduction Generation

Generate a natural, friendly greeting message for HR (under 100 characters), including education background and 1-2 JD-relevant highlights. Suitable for instant messaging.

---

## Resume JSON Format

```json
{
  "name": "姓名",
  "fontSize": 10.5,
  "versions": [{
    "targetJob": "产品经理",
    "contactInfo": {
      "phone": "", "email": "", "birthDate": "", "location": "",
      "availability": "", "photo": ""
    },
    "sections": [
      {
        "id": "sec-xxx", "type": "education|internship|project|skills|custom",
        "title": "教育背景", "enabled": true, "order": 0,
        "content": { "items": [...] }
      }
    ]
  }]
}
```

**Item types:**
- Education: `{id, school, major, degree, startDate, endDate, gpa, courses, enabled, order}`
- Internship: `{id, role, organization, dateRange, description: [{id, title, content, enabled, order}], enabled, order}`
- Project: `{id, projectName, organization, dateRange, description: [...], enabled, order}`
- Skills: `{id, category, content, enabled, order}`

Always use `item.enabled !== false` for backward compatibility. Bullet content supports HTML: `<b>`, `<strong>`, `<i>`, `<em>`.

---

## Anti-Hallucination Checklist

Before presenting any resume modification to the user, verify:
- [ ] Numbers in suggestion exist in original text
- [ ] No new proper nouns (companies, projects, technologies) introduced
- [ ] Role scope unchanged (参与 ≠ 主导, 协助 ≠ 负责)
- [ ] Total characters ≤ 94 per bullet
- [ ] If change is >60% different from original, flag with ⚠️

---

## Optional: Local Server Mode

If the user has the Flask server running on `localhost:2345`:
- PDF generation: `POST /api/generate`
- Web GUI: open `http://localhost:2345`
- Photo upload: `POST /api/upload-photo`

Quick setup: `pip install flask jinja2 openai && python resume_tool_simple.py`

But the server is NOT required — all analysis, optimization, and reports work without it.
