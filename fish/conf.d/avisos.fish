# Avisos con personalidad: comando que no existe y comandos que tardan mucho

# Programas que se quedan abiertos a propósito: no avisar al cerrarlos
set -g _avisos_ignorar nvim vim vi nano ssh htop btop top cava man less more bat claude tmux fish bash zsh python python3 ipython node lua yazi ranger fzf watch journalctl tail mpv

function fish_command_not_found
    set -l c $argv[1]
    set -l frases \
        "Miku|No encuentro «$c» en ningún sitio 🔍" \
        "Teto|¿«$c»? Eso no existe… ¿seguro que no querías decir baguette?" \
        "Rin|«$c» no existe. ¿Te paso la apisonadora por encima?" \
        "Len|«$c»… ni idea de qué es eso, master" \
        "Adachi Rei|ERROR 404: «$c» no está en mi base de datos 🤖"
    set -l p (string split -m1 '|' -- $frases[(random 1 (count $frases))])
    _decir $p[1] $p[2]
end

function _avisar_si_tarda --on-event fish_postexec
    set -l estado $status   # el del comando (se pierde con el siguiente test)
    test $CMD_DURATION -ge 10000; or return
    set -l prog (string split -f1 ' ' -- (string trim -- $argv[1]))
    test "$prog" = sudo; and set prog (string split -f2 ' ' -- (string trim -- $argv[1]))
    contains -- $prog $_avisos_ignorar; and return

    set -l t (math -s0 $CMD_DURATION / 1000)
    set -l dur "$t s"
    test $t -ge 60; and set dur (math -s0 $t / 60)" min "(math $t % 60)" s"
    set -l frases \
        "Miku|¡Terminado! Ha tardado $dur ♪" \
        "Teto|¡Listo! $dur… me ha dado tiempo a comerme una baguette 🥖" \
        "Rin|¡Ya está! $dur, ni una mandarina más 🍊" \
        "Len|Hecho en $dur. ¿Me das un plátano? 🍌" \
        "Adachi Rei|Tarea completada en $dur. Temperatura del núcleo: estable 🤖"
    test $estado -ne 0; and set frases \
        "Miku|Ha tardado $dur… y encima ha fallado 😢" \
        "Teto|$dur esperando para esto… vaya chasco" \
        "Adachi Rei|Proceso terminado en $dur con errores. No he sido yo 🤖"
    set -l p (string split -m1 '|' -- $frases[(random 1 (count $frases))])
    _decir $p[1] $p[2]
end
