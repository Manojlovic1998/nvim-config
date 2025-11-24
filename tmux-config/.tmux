set -g default-shell /bin/bash





set-window-option -g mode-keys vi

# Enable true color support (24-bit RGB colors)
# CRITICAL: These settings are required for Neovim themes to display correctly
#
# default-terminal "tmux-256color":
#   - Tells tmux to advertise itself as a 256-color capable terminal
#   - Base capability that enables extended color support
#
# terminal-overrides ",xterm-256color:RGB":
#   - Enables TRUE COLOR (16 million colors) support beyond basic 256 colors
#   - Required for modern colorschemes like Catppuccin to render properly
#   - Without this, themes will appear washed out or have wrong colors
#   - Essential for compatibility with modern terminal emulators (Alacritty, Kitty, iTerm2)
#
# Together, these settings ensure Neovim can display full RGB colors inside tmux sessions
set -g default-terminal "tmux-256color"
set -ag terminal-overrides ",xterm-256color:RGB"

set-option -sg escape-time 10
set-option -g focus-events on