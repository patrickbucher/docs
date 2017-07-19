# Boot Order

On a multiboot system, make sure that the Windows Boot Manager is not on the
first position:

    pacman -S efibootmgr
    pacman -o 3,7,0 # 3 is USB stick, 7 internal HDD, 0 Windows Boot Manager
