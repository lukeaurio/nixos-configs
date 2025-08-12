{ config, pkgs, ...  }: {
   
   boot.initrd.kernelModules = [ "pinctrl_tigerlake" ];

   nixpkgs.overlays = [
      (final: prev: {
    	iio-sensor-proxy = prev.iio-sensor-proxy.overrideAttrs (oldAttrs: {
      	postPatch = oldAttrs.postPatch + ''
      	sed -i -e 's/.*iio-buffer-accel/#&/' data/80-iio-sensor-proxy.rules
      	'';
       });
     })
   ];

   #This is Some Bios Update Nonesense
   #settings for firmware updates
   #services.fwupd.extraRemotes = [ "lvfs-testing" ];
   # Might be necessary once to make the update succeed
   #services.fwupd.uefiCapsuleSettings.DisableCapsuleUpdateOnDisk = true;   

}
