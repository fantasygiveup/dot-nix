mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
project_dir := $(patsubst %/,%,$(dir $(mkfile_path)))

purge:
	sudo nix-collect-garbage -d
	nix-collect-garbage -d
	sudo /run/current-system/bin/switch-to-configuration boot

%:
	sudo cp -R "$(project_dir)"/hosts "$(project_dir)"/modules "$(project_dir)"/flake.nix /etc/nixos
	sudo nixos-rebuild switch --show-trace --upgrade --flake /etc/nixos#$(@:%=%)

.PHONY: purge
