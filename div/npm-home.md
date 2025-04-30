# Install `npm` Packages in `$HOME`

Install `npm`:

	# pacman -S npm

Create global package directory in `$HOME`:

	$ mkdir $HOME/.npm-packages

Set `npm` prefix to folder just created:

	$ npm config set prefix "$HOME/.npm-packages"

Extend `$PATH` to find installed binaries (e.g. `tsc`, `ng`) in `$HOME/.bash_profile`:

	export NPM_PACKAGES="$HOME/.npm-packages/bin"
	export PATH="$PATH:$NPM_PACKAGES"

Test new configuration:

	$ npm install -g typescript # NOTE: not as root!
	$ tsc -v
