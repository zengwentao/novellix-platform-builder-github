#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
"$repo_root/skills/novellix-platform-builder/scripts/validate-skill.sh"

required_repository_files=(
  "README.md"
  "PUBLISHING.md"
  "LICENSE"
  "CHANGELOG.md"
  ".gitignore"
)

for relative_path in "${required_repository_files[@]}"; do
  test -f "$repo_root/$relative_path" || {
    printf 'Missing repository file: %s\n' "$relative_path" >&2
    exit 1
  }
done

if find "$repo_root" -type l -print -quit | grep -q .; then
  printf 'Repository contains a symbolic link; remove it before publishing.\n' >&2
  exit 1
fi

printf 'Repository package is ready for GitHub upload: %s\n' "$repo_root"
