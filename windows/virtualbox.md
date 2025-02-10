Problem:

    $ VBoxManage startvm "arch" --type headless

    VBoxManage.exe: error: The virtual machine 'arch' has terminated unexpectedly during startup with exit code 1 (0x1).  More details may be available in 'C:\Users\Patrick\vms\arch\Logs\VBoxHardening.log'
VBoxManage.exe: error: Details: code E_FAIL (0x80004005), component MachineWrap, interface IMachine

Symptom:

    $ sc.exe query vboxsup

    SERVICE_NAME: vboxsup
            TYPE               : 1  KERNEL_DRIVER
            STATE              : 1  STOPPED
            WIN32_EXIT_CODE    : 1077  (0x435)
            SERVICE_EXIT_CODE  : 0  (0x0)
            CHECKPOINT         : 0x0
            WAIT_HINT          : 0x0

Solution (as Admininstrator):

    $ sc.exe start vboxsup
