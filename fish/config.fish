source /usr/share/cachyos-fish-config/cachyos-config.fish

# ls con iconos (eza), más limpio que el de CachyOS. Colores ANSI → siguen al fondo
set -gx EZA_COLORS "di=1;34:ex=1;32:da=36:sn=35:sb=35"
set -l eza_base --icons=always --group-directories-first --color=always --no-quotes
alias ls="eza $eza_base"
alias la="eza -a $eza_base"
alias ll="eza -l --no-user --no-permissions --time-style=relative --git $eza_base"
alias lt="eza -T -L 2 $eza_base"

# Saludo: fastfetch + una frase aleatoria de ~/.config/fish/frases.txt (formato Nombre|frase)
function fish_greeting
    fastfetch
    set -l lineas (string match -rv '^\s*$' < ~/.config/fish/frases.txt)
    test (count $lineas) -gt 0; or return
    set -l partes (string split -m1 '|' -- $lineas[(random 1 (count $lineas))])
    echo
    _decir $partes[1] $partes[2]
end

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end

thefuck --alias | source

# Prompt Starship (~/.config/starship.toml)
if type -q starship
    starship init fish | source
end
