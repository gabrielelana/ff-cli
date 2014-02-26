# What
A command line tool to manage Firefox profiles

# Why
* To programmatically create profiles and install addons for web applications that I wish to run as desktop applications, example:
  ```
  ff-cli create --profile=github
  ff-cli set browser.startup.homepage "https://github.com/gabrielelana" --profile=github
  ff-cli addons install vimperator

  alias ff-github='ff-cli start --profile=github'
  ```
* To quickly create profiles to try things in a clean and controlled environment
* To easily backup and restore my firefox setup

# Commands
Be mind that until I publish the gem this is not intended to be used :smile:

## Implemented ...well, sort of...
* `create [--private] --profile=<NAME>`
* `destroy --profile=<NAME>`
* `start --profile=<NAME>`

## To Be Implemented
* `set <PREFERENCE_NAME> <PREFERENCE_VALUE> --profile=<NAME>`
* `get [<PREFERENCE_NAME>] --profile=<NAME>`
* `unset <PREFERENCE_NAME> --profile=<NAME>`
* `addons`
  * `install <ADDON> --profile=<NAME>`
  * `uninstall <ADDON> --profile=<NAME>`
  * `update [<ADDON>] --profile=<NAME>`
  * `list --profile=<NAME>` lists all the installed addons
  * `uninstall-all --profile=<NAME>`
* `about --profile=<NAME>` detailed informations about the profile
* `save --to/-t <FILENAME>.ffp [--only-configuration] --profile=<NAME>`
* `restore --from/-f <FILENAME>.ffp`
* `list` lists all the available profiles
