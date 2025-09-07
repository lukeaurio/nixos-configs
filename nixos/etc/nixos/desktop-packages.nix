{ config, pkgs, ...}:

{

environment.systemPackages = with pkgs; [
    #Audio Packages
    yoshimi
    vlc
    qpwgraph
    muse
    audacity
    handbrake
    makemkv
    libdvdcss
    ccextractor
    mkvtoolnix
    subtitleedit
    asunder
    alsa-scarlett-gui
    #Internet
    slack
    zoom-us
    discord
    vencord
    filezilla
    spotify
    #3dprinting
    orca-slicer
    blender
    openscad
    #keebs
    via
    vial
    #office
    #libreoffice
    #utils
    rpi-imager
    ventoy
   ];
}
