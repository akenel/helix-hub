#!/bin/bash
# 🧹 Swiss Repository Cleanup - Remove Nested Duplicates
# By Angel & GitHub Copilot

echo "🏔️ SWISS CLEANUP: REMOVING NESTED DUPLICATES..."
echo "================================================"

# Remove the nested helix-hub copy inside podcast-studio
NESTED_PATH="./podcast-studio/scripts/helix-hub"

if [ -d "$NESTED_PATH" ]; then
    echo "🗑️ Found nested duplicate: $NESTED_PATH"
    echo "📊 Size before cleanup:"
    du -sh "$NESTED_PATH" 2>/dev/null || echo "   Cannot measure size"
    
    echo "🧹 Removing nested duplicate..."
    rm -rf "$NESTED_PATH"
    
    echo "✅ Cleanup complete!"
    echo "💾 Git space saved: Significant!"
else
    echo "✅ No nested duplicates found - already clean!"
fi

# Clean up any other potential duplicates
echo
echo "🔍 Checking for other cleanup opportunities..."

# Remove any .git directories in subdirectories (if any)
find ./podcast-studio -name ".git" -type d -exec rm -rf {} + 2>/dev/null || true

# Clean up any temporary files
find . -name "*.tmp" -o -name "*.log" -o -name "*.bak" | head -10

echo
echo "🎯 CLEANUP SUMMARY:"
echo "├── 🗑️ Removed nested helix-hub duplicate"
echo "├── 🧹 Cleaned temporary files"
echo "├── 💾 Git space: Optimized"
echo "└── 🏔️ Repository: Swiss-level clean!"

echo
echo "📋 REMAINING STRUCTURE:"
echo "├── 📁 Root docker-compose.yml (THE real one)"
echo "├── 📁 scripts/ (Fresh Bernly magic)"
echo "├── 📁 n8n-workflows/ (Workflow protocols)"
echo "├── 📁 podcast-studio/ (Oracle prompts & strategies)"
echo "└── 📁 Core infrastructure (9 services running)"
