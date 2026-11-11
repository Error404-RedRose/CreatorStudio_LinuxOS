#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

REPO="Error404-RedRose/CreatorStudio_LinuxOS"
BRANCH="${TWIX_UPDATE_BRANCH:-main}"
EXE="creator-studio"
MEDIA="https://media.githubusercontent.com/media/${REPO}/${BRANCH}/${EXE}"

chmod +x chrome-sandbox chrome_crashpad_handler 2>/dev/null || true

if [ ! -f "$EXE" ]; then
  echo "ERROR: $EXE was not found next to install.sh."
  exit 1
fi

first_line="$(head -n 1 "$EXE" 2>/dev/null || true)"
if [[ "$first_line" != version\ https://git-lfs.github.com/spec/v1* ]]; then
  chmod +x "$EXE"
  echo "Creator Studio executable is already present."
  echo "Starting Creator Studio..."
  exec "./$EXE"
fi

expected_size="$(sed -n 's/^size \([0-9][0-9]*\)$/\1/p' "$EXE" | head -n 1)"
expected_oid="$(sed -n 's/^oid sha256:\([0-9a-fA-F]*\)$/\1/p' "$EXE" | head -n 1)"
echo "Creator Studio is stored with Git LFS. Downloading the full executable..."
echo "Repository: https://github.com/${REPO}"

tmp="${EXE}.download"
rm -f "$tmp"

if command -v curl >/dev/null 2>&1; then
  curl --fail --location --retry 5 --retry-delay 2 --progress-bar -o "$tmp" "$MEDIA"
elif command -v wget >/dev/null 2>&1; then
  wget --tries=5 --waitretry=2 --show-progress -O "$tmp" "$MEDIA"
elif command -v git >/dev/null 2>&1; then
  tmpdir="$(mktemp -d)"
  git lfs install >/dev/null 2>&1 || true
  GIT_LFS_SKIP_SMUDGE=0 git clone --branch "$BRANCH" --single-branch "https://github.com/${REPO}.git" "$tmpdir/repo"
  cp "$tmpdir/repo/$EXE" "$tmp"
  rm -rf "$tmpdir"
else
  echo "ERROR: curl, wget or git is required to restore the executable."
  echo "Download it manually from https://github.com/${REPO}"
  exit 1
fi

actual_size="$(wc -c < "$tmp" | tr -d ' ')"
if [[ -n "$expected_size" && "$actual_size" != "$expected_size" ]]; then
  rm -f "$tmp"
  echo "ERROR: downloaded executable is $actual_size bytes; expected $expected_size."
  echo "Run ./install.sh again or download $EXE directly from GitHub."
  exit 1
fi
if [[ -n "$expected_oid" ]] && command -v sha256sum >/dev/null 2>&1; then
  actual_oid="$(sha256sum "$tmp" | awk '{print $1}')"
  if [[ "$actual_oid" != "$expected_oid" ]]; then
    rm -f "$tmp"
    echo "ERROR: downloaded executable failed its SHA-256 verification."
    exit 1
  fi
fi

mv -f "$tmp" "$EXE"
chmod +x "$EXE" chrome-sandbox chrome_crashpad_handler 2>/dev/null || true
echo "Executable restored and verified ($actual_size bytes)."
echo "Starting Creator Studio..."
exec "./$EXE"
