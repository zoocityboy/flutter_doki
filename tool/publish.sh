#!/bin/bash

# Make script exit on first error
set -e

# Store the script's directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

echo "📦 Preparing files for publishing..."

# Replace content between picture tags using sed
sed -i '' \
    -e '/<picture id="github_header">/,/<\/picture>/c\
<img alt="Doki Dont kill my app!" src="https://raw.githubusercontent.com/zoocityboy/flutter_doki/main/assets/doki.png">' \
    -e '/<picture id="github_zoocityboy">/,/<\/picture>/c\
<img alt="Flutter developer Zoocityboy" src="https://raw.githubusercontent.com/zoocityboy/zoo_brand/main/styles/README/zoocityboy_dark.png">' \
    "$PROJECT_DIR/README.md"

# Commit changes
git add .
git commit -am "chore: prepare README.md for publishing."

echo "🚀 Publishing to pub.dev..."
flutter pub publish

echo "🧹 Cleaning up..."
# Restore original README
git reset --hard HEAD^1
# rm "$PROJECT_DIR/README.md.bak"

echo "✅ Published successfully!"