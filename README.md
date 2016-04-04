# dotfiles

This repository stores all of my dotfiles. To install:

```
git init
git remote add origin https://github.com/bcarls/dotfiles
git pull origin master
./.setup_dotfiles.sh
```

## Vim Stuff

### Plugins

They are handled by [vim-plug](https://github.com/junegunn/vim-plug). Plugins can trivially installed via the .vimrc. vim-plug will install the plugins on the first install.

### Neomake and makeprg

```makeprg``` is a variable that controls the make command that is called from Neomake. By default, it's set to "make". If using CMake and want to build in a directory (like "build"), do this:

```
:set makeprg=make\ -C\ build
```

There is a fucntion called NeomakeCheckFormakeprg that looks if ```makeprg``` has been changed and calls the appropriate Neomake command. For default ```makeprg```, Neomake is called. If ```makeprg``` has been changed, Neomake! is called.`

## Where does this all come from?

The inspiration comes from this Reddit [post](https://www.reddit.com/r/vim/comments/3cohmv/manage_dotfiles_with_vimplug_and_github/). The guys repo is [here](https://github.com/binaryplease/dotfiles).

