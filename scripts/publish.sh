#!/usr/bin/env bash
set -euo pipefail

if [[ ! -f "$HOME/.openclaw/credentials/github.env" ]]; then
  echo "Missing $HOME/.openclaw/credentials/github.env"
  exit 1
fi

source "$HOME/.openclaw/credentials/github.env"
: "${GITHUB_TOKEN:?GITHUB_TOKEN is not set in github.env}"

REPO_NAME="openclaw-marketing-skills"
OWNER="BrianRWagner"
REPO_DESC="Public showcase of Brian Wagner's OpenClaw marketing skills"

HTTP_CODE=$(curl -sS -o /tmp/${REPO_NAME}-create.json -w '%{http_code}' \
  -H "Authorization: token ${GITHUB_TOKEN}" \
  -H "Accept: application/vnd.github+json" \
  https://api.github.com/user/repos \
  -d "{\"name\":\"${REPO_NAME}\",\"private\":false,\"description\":\"${REPO_DESC}\"}")

if [[ "$HTTP_CODE" != "201" && "$HTTP_CODE" != "422" ]]; then
  echo "GitHub repo create failed (HTTP $HTTP_CODE)"
  cat /tmp/${REPO_NAME}-create.json
  exit 1
fi

if git remote get-url origin >/dev/null 2>&1; then
  git remote set-url origin "https://github.com/${OWNER}/${REPO_NAME}.git"
else
  git remote add origin "https://github.com/${OWNER}/${REPO_NAME}.git"
fi

git push -u origin main

echo "Published: https://github.com/${OWNER}/${REPO_NAME}"
