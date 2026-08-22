#!/bin/sh
# Claude Code notification hook, shared by the Notification and Stop events.
# Emits a tmux-passthrough OSC 777 (macOS banner via Ghostty, shown only when
# Ghostty is unfocused) plus a BEL (tmux tab highlight; visual-bell on keeps it
# silent). Requires host tmux: allow-passthrough all.
in=$(cat)
ev=$(printf %s "$in" | jq -r .hook_event_name)
tp=$(printf %s "$in" | jq -r .transcript_path)
ti=${CLAUDE_PROJECT_DIR##*/}

if [ "$ev" = Stop ]; then
  sleep 2 # let the transcript flush
  msg=$(tail -n 200 "$tp" 2>/dev/null | jq -rs '[.[] | select(.type=="assistant").message.content[]? | select(.type=="text").text] | (last // "Claude finished responding") | gsub("\n";" ") | .[0:160]')
else
  msg=$(printf %s "$in" | jq -r .message)
  [ "$msg" = "Claude is waiting for your input" ] && exit 0
  case $msg in
  *"permission to use "*)
    tool=${msg##*permission to use }
    ti="$ti — ${tool%%[ .]*}"
    cmd=$(tail -n 100 "$tp" 2>/dev/null | jq -rs '[.[] | select(.type=="assistant").message.content[]? | select(.type=="tool_use")] | last | (.input.command // .input.file_path // .input.prompt // .name // "") | tostring | gsub("\n";" ") | .[0:160]')
    [ -n "$cmd" ] && msg=$cmd
    ;;
  esac
fi

# Host: resolve this pane's tty via tmux. Container: no tmux binary, but the
# Claude tty is deterministically /dev/pts/0.
t=$(tmux display-message -pt "$TMUX_PANE" '#{pane_tty}' 2>/dev/null)
[ -c "$t" ] || t=/dev/pts/0
printf '\033Ptmux;\033\033]777;notify;%s;%s\a\033\\\007' "$ti" "$msg" > "$t" 2>/dev/null
