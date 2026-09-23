#!/usr/bin/env bash
set -euo pipefail

skill_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
skill_name="$(basename "$skill_root")"

required_files=(
  "SKILL.md"
  "agents/openai.yaml"
  "assets/design-tokens.json"
  "references/architecture.md"
  "references/delivery-playbook.md"
  "references/design-system.md"
  "references/domain-blueprints.md"
  "references/security-and-deployment.md"
)

for relative_path in "${required_files[@]}"; do
  test -f "$skill_root/$relative_path" || {
    printf 'Missing required file: %s\n' "$relative_path" >&2
    exit 1
  }
done

command -v python3 >/dev/null 2>&1 || {
  printf 'python3 is required for validation\n' >&2
  exit 1
}

python3 - "$skill_root" "$skill_name" <<'PY'
import json
import pathlib
import re
import sys

root = pathlib.Path(sys.argv[1])
name = sys.argv[2]
skill = (root / "SKILL.md").read_text(encoding="utf-8")
tokens = json.loads((root / "assets/design-tokens.json").read_text(encoding="utf-8"))

if not re.search(r"^name:\s*" + re.escape(name) + r"\s*$", skill, re.MULTILINE):
    raise SystemExit("SKILL.md name does not match its directory name")

if not isinstance(tokens, dict) or "color" not in tokens or "spacing" not in tokens:
    raise SystemExit("design-tokens.json is missing required theme sections")

for path in root.rglob("*"):
    if path.is_symlink():
        raise SystemExit(f"symlink is not allowed: {path.relative_to(root)}")

secret_pattern = re.compile(
    r"(?i)(BEGIN (?:RSA|OPENSSH|EC|DSA) PRIVATE KEY|api[_-]?key\s*[:=]|"
    r"access[_-]?token\s*[:=]|password\s*[:=]\s*[^<>{}]+)"
)
for path in root.rglob("*"):
    if not path.is_file() or path.stat().st_size > 2_000_000:
        continue
    try:
        text = path.read_text(encoding="utf-8")
    except UnicodeDecodeError:
        continue
    if secret_pattern.search(text):
        raise SystemExit(f"possible secret-like content: {path.relative_to(root)}")

print(f"Validated {name}: {len(list(root.rglob('*')))} entries")
PY

printf 'Skill package is valid: %s\n' "$skill_root"
