### Overview:
The scope of this solution is to enable the mass upgrading of the firmware on RT targets. Currently, we have to use NI MAX to upgrade one target at a time. This is not a first-class solution in SystemLink, we still need to install the necessary windows support packages/drivers on a machine (could be the one that has already NI MAX on it) and leverage them to get the firmware file and deploy it to the targets.
So in terms of needed setup, nothing has changed.

### General guidelines:
* This solution is supported only on SL clients (>= 19.0).
* We only recommend upgrading the firmware to the 8.0 version or later. Downgrading the firmware (especially on Arm targets) could be problematic because older firmwares than 8.0.0 are bigger in size so during the firmware 
installation the /boot can get filled up which ends up with a bricked target.
* We recommend restarting the target(s) before doing this operation to clean the tmp filesystem.
* This operation requires a reboot so we strongly recommend to let the "Automatically restart if required" checkbox checked before applying the state.
* All x64 targets share the same firmware bitwise so using the same .cfg file we can upgrade the firmware on different x64 targets. i.e: cRIO-9056_8.0.0.cfg will work on 9054 as well.

### Steps:
1. Install the RT Support packages(i.e. "NI CompactRIO") on a Windows machine(could be the one that has already NI MAX on it). These packages should include the firmwares (".cfg" files) for the currently supported targets.
2. Find the correspondent firmware version for your target(s) under "C:\Program Files (x86)\National Instruments".
Example: 
  - C:\Program Files (x86)\National Instruments\Shared\Firmware\cRIO\76D6\cRIO-9068_8.0.0.cfg
3. Copy the .cfg file to the SystemLink Server machine under the salt file server root path: "C:\ProgramData\National Instruments\salt\srv\salt\FirmwareUpgrade".
5. Import the Upgrade-Firmware state file into the SL Server States Service (make sure you specify your target(s) Architecure - X64 / Arm ).
6. Update the "Deploy_firmware_file" step from the state using the state "Raw View" to match the path of the .cfg file that was copied under the salt file server root path.
7. Deploy the state using the regular software install workflow to the target(s).