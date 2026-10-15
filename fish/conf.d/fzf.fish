# Aspecto de fzf (Ctrl+R historial, Ctrl+T archivos, Alt+C carpetas)
# Colores con nombres ANSI para que sigan a colores-fondo

set -gx FZF_DEFAULT_OPTS "\
--height=60% --layout=reverse --border=rounded --margin=0,1 --padding=0,1 \
--prompt='❯ ' --pointer='▶' --marker='✓' --separator='─' --scrollbar='│' \
--info=inline-right --highlight-line \
--color=fg:-1,bg:-1,gutter:-1,hl:cyan:bold,fg+:-1:bold,bg+:black,hl+:cyan:bold \
--color=prompt:blue:bold,pointer:magenta,marker:green,border:blue,label:cyan:bold \
--color=info:yellow,spinner:magenta,header:blue,separator:blue,scrollbar:blue,query:-1:bold"

# Historial: sin la fecha, solo el comando
set -gx FZF_CTRL_R_OPTS "--with-nth=3.. --border-label=' Historial '"

# Archivos: vista previa con bat (o árbol si es carpeta)
set -gx FZF_CTRL_T_OPTS "--border-label=' Archivos ' \
--preview='if test -d {}; eza --tree -L 2 --icons --color=always {}; else; bat --color=always --style=numbers --line-range=:200 {}; end' \
--preview-window='right,55%,border-left'"

# Carpetas: vista previa en árbol
set -gx FZF_ALT_C_OPTS "--border-label=' Carpetas ' \
--preview='eza --tree -L 2 --icons --color=always {}' \
--preview-window='right,55%,border-left'"

# Activar los atajos de fzf (Ctrl+R, Ctrl+T, Alt+C)
if status is-interactive
    fzf --fish | source
end

# Buscar con fd: se salta carpetas ocultas (.wine, .cache...) y lo de .gitignore
set -gx FZF_CTRL_T_COMMAND "fd --type f --type d --follow"
set -gx FZF_ALT_C_COMMAND "fd --type d --follow"
