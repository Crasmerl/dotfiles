function sd-fuera --description "Desconecta la tarjeta SD de la VM win10"
    virsh -c qemu:///system detach-disk win10 vdb
end
