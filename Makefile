mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
project_dir := $(patsubst %/,%,$(dir $(mkfile_path)))

clean:
	sudo nix-collect-garbage -d
	nix-collect-garbage -d
	sudo /run/current-system/bin/switch-to-configuration boot

upgrade:
	nix flake update

%:
	sudo cp -R "$(project_dir)"/hosts "$(project_dir)"/modules "$(project_dir)"/flake.nix "$(project_dir)"/flake.lock /etc/nixos
	sudo nixos-rebuild switch --show-trace --upgrade --flake /etc/nixos#$(@:%=%)

.PHONY: purge upgrade
