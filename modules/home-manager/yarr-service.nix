{ pkgs, ... }: {
  systemd.user.services.yarr = {
    Unit = {
      Description =
        "RSS / Atom viewer HTTP service, running on localhost port 7070";
    };
    Service = {
      ExecStart = ''
        ${pkgs.yarr}/bin/yarr
      '';
      Restart = "always";
    };
    Install = { WantedBy = [ "default.target" ]; };
  };
}
