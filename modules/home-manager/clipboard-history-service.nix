{ pkgs, ... }: {
  systemd.user.services.clipboard-history = {
    Unit = {
      Description =
        "X11 service. Listen to clipboard events and pipe them to cliphist.";
    };
    Service = {
      ExecStart = ''
        ${pkgs.bash}/bin/bash -c 'while ${pkgs.clipnotify}/bin/clipnotify; do ${pkgs.xclip}/bin/xclip -o -selection c | ${pkgs.cliphist}/bin/cliphist store; done'
      '';
      Restart = "always";
      TimeoutSec = 3;
      RestartSec = 3;
    };
    Install = { WantedBy = [ "default.target" ]; };
  };
}
