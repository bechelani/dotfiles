# bechelani does dotfiles - forked from jldeen's repo

### Azure Cloud Shell Configuration
Run the following to configure Azure Cloud Shell from scratch...
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/bechelani/dotfiles/azshell/configure.sh)"
```

### Notes
Your dotfiles are how you personalize your system. These are mine.

## topical

Everything's built around topic areas. If you're adding a new area to your
forked dotfiles — say, "Java" — you can simply add a `java` directory and put
files in there. Anything with an extension of `.zsh` will get automatically
included into your shell. Anything with an extension of `.symlink` will get
symlinked without extension into `$HOME` when you run `script/bootstrap`.

## what's inside

A lot of stuff. Seriously, a lot of stuff. Check them out in the file browser
above and see what components may mesh up with you.
[Fork holman's](https://github.com/holman/dotfiles/fork) or [Fork mine](htps://github.com/jldeen/dotfiles/fork), remove what you don't
use, and build on what you do use.

## components

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **Brewfile**: This is a list of applications for [Homebrew Cask](https://caskroom.github.io) to install: things like Chrome and 1Password and Adium and stuff. Might want to edit this file before running any initial setup.
- **topic/\*.zsh**: Any files ending in `.zsh` get loaded into your
  environment.
- **topic/path.zsh**: Any file named `path.zsh` is loaded first and is
  expected to setup `$PATH` or similar.
- **topic/completion.zsh**: Any file named `completion.zsh` is loaded
  last and is expected to setup autocomplete.
- **topic/install.sh**: Any file named `install.sh` is executed when you run `script/install`. To avoid being loaded automatically, its extension is `.sh`, not `.zsh`.
- **topic/\*.symlink**: Any file ending in `*.symlink` gets symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `script/bootstrap`.

## Reset Cloud Shell

One last question I had is if I could blow my cloud shell environment away (or even just detach from it like I would a tmux session) in the event I wanted to start fresh. Yes! You can. This [Microsoft Docs](https://docs.microsoft.com/en-us/azure/cloud-shell/persisting-shell-storage) page has some helpful details, but I figured I'd include the 2 commands here:

To unmount current clouddrive: `clouddrive unmount`

To mount existing clouddrive: `clouddrive mount`

[Reference](https://jessicadeen.com/dotfiles-azure-cloud-shell/)
