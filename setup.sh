#!/bin/bash
# AI Resume Builder Skill Setup Script

echo "=========================================="
echo "  AI Resume Builder - Claude Code Skill"
echo "=========================================="
echo ""

# Check if Claude Code is installed
if ! command -v claude &> /dev/null; then
    echo "⚠️  Claude Code CLI not found"
    echo "   Please install Claude Code first: https://claude.ai/code"
    echo ""
fi

# Create skills directory
SKILL_DIR="$HOME/.claude/skills"
mkdir -p "$SKILL_DIR"

# Copy skill file
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cp "$SCRIPT_DIR/ai-resume-builder.skill.md" "$SKILL_DIR/"

echo "✅ Skill installed successfully!"
echo ""
echo "📁 Skill location: $SKILL_DIR/ai-resume-builder.skill.md"
echo ""
echo "📖 Usage:"
echo "   1. Deploy the resume tool (see README.md)"
echo "   2. Start Claude Code"
echo "   3. Mention '简历' or 'resume' to activate the skill"
echo ""
echo "🔗 More info: https://github.com/gu1209/AI-Resume-Builder"
echo ""
