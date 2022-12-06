# bechelani does dotfiles - forked from jldeen's repo

## Windows Configuration

Run the following to configure Windows 10/11 from scratch...

```pwsh
Set-ExecutionPolicy Bypass; irm 'https://raw.githubusercontent.com/bechelani/dotfiles/windows/configure.ps1' | iex;
```

## macOS Configuration

Run the following to configure macOS from scratch...

``` sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/bechelani/dotfiles/mac/configure.sh)"
```

## WSL Configuration

Run the following to configure WSL from scratch...

``` sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/bechelani/dotfiles/wsl/configure.sh)"
```

## install

There are several "master" branches here: Win, WSL and MacOS;
there are several "dev" branches here win-dev, wsl-dev and mac-dev.

Check each master branch's README to see how to install for each of those environments.

## notes

Your dotfiles are how you personalize your system. These are mine.

I was a little tired of having long alias files and everything strewn about
(which is extremely common on other dotfiles projects, too). That led to this
project being much more topic-centric. I realized I could split a lot of things
up into the main areas I used (git, frameworks, system libraries, and so on), so I
structured the project accordingly. I also created branches for Windows, WSL and MacOS since those are my main environments.

If you're interested in the philosophy behind why projects like these are
awesome, you might want to [read Holman's post on the
subject](http://zachholman.com/2010/08/dotfiles-are-meant-to-be-forked/).

## topical

Everything's built around topic areas. If you're adding a new area to your
forked dotfiles — say, "Java" — you can simply add a `java` directory and put
files in there. Anything with an extension of `.zsh` will get automatically
included into your shell. Anything with an extension of `.symlink` will get
symlinked without extension into `$HOME` when you run `script/bootstrap`.

## what's inside

A lot of stuff. Seriously, a lot of stuff. Check them out in the file browser
above and see what components may mesh up with you.
[Fork holman's](https://github.com/holman/dotfiles/fork) or [Fork Jldeen's](htps://github.com/jldeen/dotfiles/fork), remove what you don't
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

## bugs

I want this to work for everyone; that means when you clone it down it should
work for you even though you may not have `rbenv` installed, for example. That
said, I do use this as *my* dotfiles, so there's a good chance I may break
something if I forget to make a check for a dependency.

If you're brand-new to the project and run into any blockers, please
[open an issue](https://github.com/jldeen/dotfiles/issues) on this repository
and I'd love to get it fixed for you!

## thanks

Holman forked [Ryan Bates](http://github.com/ryanb)' excellent
[dotfiles](http://github.com/ryanb/dotfiles) for a couple years before the
weight of his changes and tweaks inspired him to finally roll his own. But Ryan's
dotfiles were an easy way to get into bash customization, and then to jump ship
to zsh a bit later. A decent amount of the code in these dotfiles stem or are
inspired from Ryan's original project.
