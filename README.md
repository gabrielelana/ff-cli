# What
A command line tool to manage Firefox profiles

# Why
* To programmatically create profiles and install addons for web applications that I wish to run as desktop applications, example:
  ```
  ff github create
  ff github set browser.startup.homepage "https://github.com/gabrielelana"
  ff github addons install vimperator

  alias ff-github='ff github start'
  ```
* To quickly create profiles to try things in a clean and controlled environment
* To easily backup and restore my Firefox setup

# Commands
Be mind that until I publish the gem this is not intended to be used :smile:

## Implemented ...well, sort of...
* `create`
* `destroy`
* `start`
* `about`

## To be implemented
* `set <PREFERENCE_NAME> <PREFERENCE_VALUE>`
* `get [<PREFERENCE_NAME>]`
* `unset <PREFERENCE_NAME>`
* `use-as-default`
* `addons`
  * `install <ADDON>`
  * `uninstall <ADDON>`
  * `update [<ADDON>]`
  * `list`
  * `uninstall-all`
* `save --to/-t <FILENAME>.ffp [--only-configuration]`
* `restore --from/-f <FILENAME>.ffp`
* `list`
