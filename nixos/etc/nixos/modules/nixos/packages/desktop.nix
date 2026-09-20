{ ... }:
{
  flake.modules.nixos.packages-desktop =
    {
      pkgs,
      ...
    }:
    {
      environment.systemPackages = with pkgs; [
        # Audio and video
        yoshimi
        vlc
        qpwgraph
        muse
        audacity
        asunder
        alsa-scarlett-gui
        handbrake
        makemkv
        libdvdcss
        ccextractor
        mkvtoolnix

        # Desktop applications and peripherals
        zoom-us
        filezilla
        qbittorrent
        orca-slicer
        gimp
        via
        vial
        libreoffice-qt
        hunspell
        hunspellDicts.en_US
        ghostscript
        ventoy
      ];
    };
}
