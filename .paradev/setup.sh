#!/usr/bin/env bash
set -euo pipefail

root="${SUPERSET_ROOT_PATH:?SUPERSET_ROOT_PATH is not set}"

# Git-ignored local files a fresh worktree lacks.
copy() {
  if [ -e "$root/$1" ] && [ ! -e "$1" ]; then
    mkdir -p "$(dirname "$1")"
    cp -R "$root/$1" "$1"
    echo "copied $1"
  fi
}

copy .env                    # required by --dart-define-from-file
copy android/key.properties  # release signing
copy supabase/.temp          # supabase CLI link (db query --linked)

[ -e .env ] || echo "warning: no .env in $root — copy .env.example and fill it in" >&2

flutter pub get
