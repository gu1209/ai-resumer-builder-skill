# 安装指南

## 方式一：自动安装（推荐）

### Linux/Mac
```bash
chmod +x setup.sh
./setup.sh
```

### Windows
```cmd
setup.bat
```

## 方式二：手动安装

### 1. 复制 Skill 文件

将 `ai-resume-builder.skill.md` 复制到 Claude Code 的 skills 目录：

```bash
# Linux/Mac
mkdir -p ~/.claude/skills
cp ai-resume-builder.skill.md ~/.claude/skills/

# Windows
mkdir %USERPROFILE%\.claude\skills
copy ai-resume-builder.skill.md %USERPROFILE%\.claude\skills\
```

### 2. 部署简历工具

```bash
# 克隆项目
git clone https://github.com/gu1209/AI-Resume-Builder.git
cd AI-Resume-Builder

# 安装依赖
pip install -r requirements.txt
npm install puppeteer-core nunjucks

# 启动服务
python resume_tool_simple.py
```

### 3. 配置 API Key

1. 访问 http://localhost:2345
2. 注册账号并登录
3. 在侧边栏「API 设置」中输入 DeepSeek API Key

获取 API Key: https://platform.deepseek.com/api_keys

## 验证安装

启动 Claude Code，输入以下内容测试：

```
帮我写一段给 HR 的自我介绍，目标岗位是产品经理
```

如果 Skill 正常工作，Claude Code 会调用简历工具生成自我介绍。

## 常见问题

### Q: Skill 没有被激活？
A: 确认 skill 文件在正确的位置，且文件名以 `.skill.md` 结尾

### Q: API 调用失败？
A: 检查简历工具是否在运行，API Key 是否正确配置

### Q: PDF 生成失败？
A: 需要安装 Ghostscript 和中文字体

```bash
# Ubuntu/Debian
sudo apt install ghostscript fonts-wqy-microhei

# CentOS/RHEL
sudo yum install ghostscript wqy-microhei-fonts

# macOS
brew install ghostscript
```

## 卸载

```bash
# 删除 skill 文件
rm ~/.claude/skills/ai-resume-builder.skill.md

# （可选）删除简历工具
rm -rf /path/to/AI-Resume-Builder
```
