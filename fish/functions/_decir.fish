# _decir Personaje "mensaje" → "  ✦ Personaje · mensaje" con el color característico
function _decir
    # Colores característicos (Miku/Rin/Len/Luka/MEIKO/KAITO: los oficiales de Project Sekai)
    set -l color purple
    switch $argv[1]
        case Miku; set color 33CCBB
        case Teto; set color E8344E
        case Rin; set color FFCC11
        case Len; set color FFEE11
        case Luka; set color FFBBCC
        case MEIKO Meiko; set color DD4444
        case KAITO Kaito; set color 3366CC
        case 'Adachi Rei' Rei; set color F9A042
    end
    echo (set_color --bold $color)"  ✦ $argv[1]"(set_color normal)(set_color brblack)" · "(set_color normal)(set_color --italics brwhite)"$argv[2]"(set_color normal)
end
