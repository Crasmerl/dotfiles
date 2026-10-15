function sd-vm --description "Conecta la tarjeta SD a la VM win10"
    virsh -c qemu:///system attach-disk win10 /dev/mmcblk0 vdb --targetbus virtio --cache none
end
