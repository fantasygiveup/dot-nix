let pkgs = import <nixpkgs> { };
in with pkgs; rec {
  erlang_26 = erlangR26.override {
    version = "26.1.2";
    # nix-prefetch-url --unpack https://github.com/erlang/otp/archive/OTP-26.1.2.tar.gz
    sha256 = "0h7v9py78c66nn56b7xrs7lcah21vixxyw6d4f4p5z7k1rvcn4kv";
  };

  beamPkg = beam.packagesWith erlang_26;

  elixir_1_16 = beamPkg.elixir.override {
    version = "1.16.0";
    # nix-prefetch-url --unpack https://github.com/elixir-lang/elixir/archive/refs/tags/v1.16.0.tar.gz
    sha256 = "01sdmnbyz2r780437h160ka7zb605b08w9ar031xikbwgnjx7kcw";
  };

  elixir_ls = beamPkg.elixir-ls.override {
    lib = lib // {
      importJSON = _: {
        # nix-prefetch-url --unpack https://github.com/elixir-lsp/elixir-ls/archive/refs/tags/v0.26.4.tar.gz
        version = "0.26.4";
        sha256 = "08f6gr3ivrcs4k0hhvdb63szjvxyvlw2l9xv9615ryaywjm6jbf1";
      };
    };
    elixir = elixir_1_16;
    mixRelease = beamPkg.mixRelease.override { elixir = elixir_1_16; };
  };
}
