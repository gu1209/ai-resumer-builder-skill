@echo off
REM AI Resume Builder Skill Setup Script

echo ==========================================
echo   AI Resume Builder - Claude Code Skill
echo ==========================================
echo.

REM Create skills directory
if not exist "%USERPROFILE%\.claude\skills" mkdir "%USERPROFILE%\.claude\skills"

REM Copy skill file
copy /Y "%~dp0ai-resume-builder.skill.md" "%USERPROFILE%\.claude\skills\"

echo ✅ Skill installed successfully!
echo.
echo 📁 Skill location: %USERPROFILE%\.claude\skills\ai-resume-builder.skill.md
echo.
echo 📖 Usage:
echo    1. Deploy the resume tool (see README.md)
echo    2. Start Claude Code
echo    3. Mention '简历' or 'resume' to activate the skill
echo.
echo 🔗 More info: https://github.com/gu1209/AI-Resume-Builder
echo.
pause
