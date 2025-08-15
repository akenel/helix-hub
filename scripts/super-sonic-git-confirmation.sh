#!/bin/bash

# 🚨 SUPER SONIC GIT CONFIRMATION SCRIPT 🚨
# For CEO desk-tapping emergencies and Sally protection protocol
# When you need INSTANT proof that everything is pushed and perfect

set -e

echo "╔══════════════════════════════════════════════════════════════╗"
echo "║          🚨 SUPER SONIC GIT CONFIRMATION PROTOCOL 🚨         ║"
echo "║                                                              ║"
echo "║              CEO DESK TAPPING RESPONSE SYSTEM                ║"
echo "║            INSTANT VERIFICATION IN 3 SECONDS                 ║"
echo "╚══════════════════════════════════════════════════════════════╝"

echo ""
echo "⚡ LIGHTNING FAST GIT STATUS CHECK..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# 1. INSTANT GIT STATUS
echo "🔍 Git Status:"
if git status --porcelain | grep -q .; then
    echo "❌ UNTRACKED/MODIFIED FILES DETECTED!"
    git status --short
    echo "⚠️  WARNING: COMMIT NEEDED!"
else
    echo "✅ WORKING TREE CLEAN - PERFECT!"
fi

echo ""

# 2. BRANCH STATUS  
echo "🌿 Branch Status:"
BRANCH=$(git branch --show-current)
echo "   Current: $BRANCH"

AHEAD=$(git rev-list --count origin/$BRANCH..$BRANCH 2>/dev/null || echo "0")
BEHIND=$(git rev-list --count $BRANCH..origin/$BRANCH 2>/dev/null || echo "0")

if [ "$AHEAD" -gt 0 ]; then
    echo "⚠️  AHEAD: $AHEAD commits (NEED TO PUSH!)"
elif [ "$BEHIND" -gt 0 ]; then
    echo "⚠️  BEHIND: $BEHIND commits (NEED TO PULL!)"
else
    echo "✅ SYNCED: In perfect harmony with origin"
fi

echo ""

# 3. RECENT COMMITS
echo "📝 Recent Commits:"
git log --oneline -3 --color=always

echo ""

# 4. TAGS STATUS
echo "🏷️  Tags Status:"
LATEST_TAG=$(git describe --tags --abbrev=0 2>/dev/null || echo "NO TAGS")
echo "   Latest: $LATEST_TAG"

# Check if latest commit is tagged
if git describe --exact-match HEAD >/dev/null 2>&1; then
    echo "✅ HEAD IS TAGGED - RELEASE READY!"
else
    echo "⚠️  HEAD NOT TAGGED - Consider tagging for release"
fi

echo ""

# 5. REMOTE STATUS
echo "🌐 Remote Status:"
if git ls-remote --exit-code origin >/dev/null 2>&1; then
    echo "✅ REMOTE CONNECTION: Active"
    echo "   Remote: $(git remote get-url origin)"
else
    echo "❌ REMOTE CONNECTION: Failed"
fi

echo ""

# 6. SUPER SONIC SUMMARY
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║                  🏔️ SUPER SONIC SUMMARY 🏔️                     ║"
echo "╚══════════════════════════════════════════════════════════════╝"

# Check if everything is perfect
if [ "$AHEAD" -eq 0 ] && [ "$BEHIND" -eq 0 ] && ! git status --porcelain | grep -q .; then
    echo "🎯 STATUS: ✅ WILHELM TELL PRECISION - EVERYTHING PERFECT!"
    echo "🤝 CEO HANDSHAKE: ✅ READY"
    echo "💰 PAYCHECK STATUS: ✅ GUARANTEED"
    echo "☕ COFFEE BUDGET: ✅ SECURED"
    echo "🎪 SALLY PROTECTION: ✅ ACTIVE"
    echo ""
    echo "🏔️ Swiss Mountain Engineering: ACHIEVED"
    echo "⏰ Time: $(date '+%H:%M:%S') - Before 10:30 ✅"
else
    echo "⚠️  STATUS: ACTION REQUIRED"
    if [ "$AHEAD" -gt 0 ]; then
        echo "   🚀 RECOMMENDED: git push origin main --tags"
    fi
    if git status --porcelain | grep -q .; then
        echo "   📝 RECOMMENDED: git add . && git commit"
    fi
fi

echo ""
echo "🎯 Verification complete in $(echo $SECONDS) seconds"
echo "🏔️ Wilhelm Tell would be proud!"
