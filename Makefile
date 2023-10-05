.PHONY: help
help: # Show help for each of the Makefile recipes.
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  Makefile | sort | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done

.PHONY: install-homebrew deploy, setup
install-homebrew:
	sudo true
	@echo "install-homebrew"
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

.PHONY: uninstall-homebrew uninstall
uninstall-homebrew:
	@echo "uninstall-homebrew"
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall.sh | bash

setup: # Deploy minimal toolchain for build/run project.
ifeq (, $(shell which brew))
setup: install-homebrew
endif
	@brew install carthage 
	@carthage bootstrap --use-xcframeworks --platform iOS

deploy: # Deploy full toolchain for working with project.
ifeq (, $(shell which brew))
deploy: install-homebrew
else
	@brew update
endif

	@# https://github.com/rbenv/rbenv#homebrew
	@brew install rbenv ruby-build 

	@# https://github.com/realm/SwiftLint#installation
	@brew install swiftlint 

	@# https://devcenter.bitrise.io/en/bitrise-cli/installing-and-updating-the-bitrise-cli.html
	@brew install bitrise

	@# https://github.com/Carthage/Carthage#installing-carthage
	@brew install carthage 

	@carthage bootstrap --use-xcframeworks --platform iOS

	@rbenv install --skip-existing

	@# https://bundler.io/
	@bundle install

uninstall: # Uninstall all toolchain deployed.
	@brew uninstall rbenv
	@brew uninstall swiftlint
	@brew uninstall carthage
	@brew uninstall bitrise
uninstall: uninstall-homebrew

update: # Update toolchain and dependencies.
	@brew update
	@brew upgrade
	@brew cleanup
	@carthage update --use-xcframeworks --platform iOS
	@bundle update --bundler
	@bundle update