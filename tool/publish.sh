#!/bin/bash

# Make script exit on first error
set -e

# Store the script's directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

echo "📦 Preparing files for publishing..."

# Create temporary README for publishing
cp "$PROJECT_DIR/README.md" "$PROJECT_DIR/README.md.bak"

# Remove github-specific elements and comments
sed -i '' \
    -e '/<!--github-->/,/<!--\^github-->/d' \
    -e '/<picture id="github_.*>/,/<\/picture>/d' \
    -e 's/id="pubdev_.*" style="display:none;"/id="pubdev_header"/' \
    "$PROJECT_DIR/README.md"

# Commit changes
git commit -am "chore: prepare README.md for publishing."

echo "🚀 Publishing to pub.dev..."
flutter pub publish

echo "🧹 Cleaning up..."
# Restore original README
git reset --hard HEAD^1
# mv "$PROJECT_DIR/README.md.bak" "$PROJECT_DIR/README.md"

echo "✅ Published successfully!"