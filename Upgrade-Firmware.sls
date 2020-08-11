Deploy_firmware_file:
  file.managed:
    - source: salt://FirmwareUpgrade/9056/cRIO-9056_8.0.0.cfg
    - name: /sl_safemode/sl_safemode.cfg
    - makedirs: True

# Remove cached salt files to avoid filling tmpfs during the firmware installation
Remove_salt_cache_volatile:
  file.absent:
    - name: /var/volatile/cache/salt/minion/files/base/

Install_firmware:
  cmd.run:
    - name: /usr/local/natinst/bin/niinstallsafemode /sl_safemode/sl_safemode.cfg -f
    - require: 
      - Deploy_firmware_file

Remove_firmware_deployed_file:
  file.absent:
    - name: /sl_safemode

Set_Reboot_Required:
  module.run:
    - name: system.set_reboot_required_witnessed
    - require: 
      - Install_firmware