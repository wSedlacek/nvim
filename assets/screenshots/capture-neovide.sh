#!/usr/bin/env zsh
# Recapture README screenshots from Neovide (IosevkaTerm Nerd Font Mono).
# Requires Screen Recording permission for the app running this script.
#
# Usage:
#   ~/.config/nvim/assets/screenshots/capture-neovide.sh

set -euo pipefail

OUT="${0:A:h}"
DEMO=/tmp/nvim-demo
SOCK=/tmp/neovide-shot.sock
WID_BIN=/tmp/pidwins-simple

remote() { nvim --server "$SOCK" --remote-send "$1" >/dev/null 2>&1; }
remote_cmd() { remote "<Cmd>$1<CR>"; }
remote_expr() { nvim --server "$SOCK" --remote-expr "$1" 2>/dev/null; }

ensure_demo() {
  mkdir -p "$DEMO/src"
  [[ -f "$DEMO/src/main.ts" ]] || cat >"$DEMO/src/main.ts" <<'EOF'
/** Demo entry for Neovim screenshots. */
export type User = {
  id: string
  name: string
  roles: Array<"admin" | "editor" | "viewer">
}

export function greet(user: User): string {
  // TODO: localize greeting
  const title = user.roles.includes("admin") ? "Admin" : "User"
  return `Hello, ${title} ${user.name}!`
}

export async function loadUser(id: string): Promise<User> {
  const res = await fetch(`/api/users/${id}`)
  if (!res.ok) {
    throw new Error(`Failed to load user ${id}`)
  }
  return res.json() as Promise<User>
}
EOF
  [[ -f "$DEMO/src/broken.ts" ]] || cat >"$DEMO/src/broken.ts" <<'EOF'
export function oops(x: number) {
  return x.toUpperCase()
}
EOF
  [[ -f "$DEMO/package.json" ]] || printf '%s\n' '{"name":"nvim-demo","private":true}' >"$DEMO/package.json"
  if [[ ! -d "$DEMO/.git" ]]; then
    git -C "$DEMO" init >/dev/null
    git -C "$DEMO" -c user.email=demo@example.com -c user.name=Demo add -A
    git -C "$DEMO" -c user.email=demo@example.com -c user.name=Demo commit -m demo >/dev/null
  fi
}

ensure_wid_helper() {
  if [[ ! -x "$WID_BIN" ]]; then
    cat >/tmp/pidwins.swift <<'EOF'
import Cocoa
let opts = CGWindowListOption(arrayLiteral: .optionOnScreenOnly)
guard let info = CGWindowListCopyWindowInfo(opts, kCGNullWindowID) as? [[String: Any]] else { exit(1) }
for w in info {
  let owner = (w[kCGWindowOwnerName as String] as? String) ?? ""
  if owner != "Neovide" { continue }
  let id = (w[kCGWindowNumber as String] as? Int) ?? 0
  print(id)
}
EOF
    swiftc -O /tmp/pidwins.swift -o "$WID_BIN"
  fi
}

start_neovide() {
  pkill -x neovide 2>/dev/null || true
  sleep 0.4
  rm -f "$SOCK"
  # Use config.toml frame (transparent) so macOS traffic lights show in shots.
  open -na Neovide --args -- --listen "$SOCK" -c "cd $DEMO"
  for _ in {1..60}; do
    remote_expr 'mode()' >/dev/null && break
    sleep 0.4
  done
  remote_expr 'mode()' >/dev/null || { echo "Neovide RPC failed" >&2; exit 1; }
  osascript -e 'tell application "Neovide" to activate' >/dev/null 2>&1 || true
  sleep 0.8
  # Config uses 0.75 opacity; flatten against a light desktop washes shots out.
  remote_cmd "lua vim.g.neovide_opacity=1; vim.g.neovide_normal_opacity=1; vim.g.neovide_window_blurred=false; vim.g.transparency=0"
  sleep 0.3
}

capture() {
  local name="$1"
  local dest="$OUT/${name}.png"
  sleep 0.5
  osascript -e 'tell application "Neovide" to activate' >/dev/null 2>&1 || true
  sleep 0.3
  local wid
  wid="$("$WID_BIN" | head -1)"
  [[ -n "$wid" ]] || { echo "no Neovide window" >&2; exit 1; }
  screencapture -x -l"$wid" -t png "$dest"
  local bytes
  bytes="$(wc -c <"$dest" | tr -d ' ')"
  [[ "$bytes" -gt 20000 ]] || { echo "capture too small for $name ($bytes bytes) — permission?" >&2; exit 2; }
  echo "ok $name ($bytes bytes, wid=$wid)"
}

ensure_demo
ensure_wid_helper
start_neovide

remote_cmd "lua vim.cmd('Nvdash')"
sleep 1.5
capture dashboard

remote_cmd "edit src/main.ts"
sleep 2.5
capture code

remote_cmd "lua require('fff').find_files()"
sleep 1.0
remote "main"
sleep 0.9
capture finder
remote "<Esc>"
sleep 0.2

remote_cmd "Oil"
sleep 1.0
capture oil
remote_cmd "close"
sleep 0.2

remote_cmd "edit src/broken.ts"
sleep 2.5
remote_cmd "Trouble diagnostics"
sleep 1.2
capture diagnostics
remote_cmd "Trouble close"
sleep 0.2

remote_cmd "NvCheatsheet"
sleep 1.0
capture cheatsheet
remote "<Esc>"
sleep 0.2

remote_cmd "edit src/main.ts"
sleep 0.5
remote_cmd "lua require('lazy').load({ plugins = { 'neogit' } })"
sleep 0.5
remote_cmd "lua require('neogit').open()"
sleep 1.8
capture neogit
remote "<Esc>"
sleep 0.3

remote_cmd "edit src/main.ts"
sleep 0.4
remote_cmd "lua require('nvchad.term').new({ pos = 'sp' })"
sleep 1.0
capture terminal
remote_cmd "wincmd q"
sleep 0.2

remote_cmd "CopilotAgentChat"
sleep 3.5
capture agent
remote_cmd "CopilotAgentChatToggle"
sleep 0.3

remote_cmd "Telescope themes"
sleep 1.2
capture themes
remote "<Esc>"
sleep 0.2

remote_cmd "edit src/main.ts"
sleep 0.5
remote_cmd "lua require('dap-view').open()"
sleep 1.2
capture dap

echo "Done → $OUT"
ls -la "$OUT"/*.png
