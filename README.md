# vim-elhiv [![Join the chat at https://gitter.im/still-dreaming-1/vim-elhiv](https://badges.gitter.im/still-dreaming-1/vim-elhiv.svg)](https://gitter.im/still-dreaming-1/vim-elhiv?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

This is a library written in VimL.

elhiv stands for extreme language hacking in VimL. Extreme language hacking is my programming style, but this is actually just a VimL library used by my [vim-project-tags](https://github.com/still-dreaming-1/vim-project-tags) plugin.

**Installation**

First install it the normal way using your favorite plugin manager. I am currently using [vim-plug](https://github.com/junegunn/vim-plug). Then, from your config file, source elhiv.vim. This line will work inside most Neovim config files if you are using the [vim-plug](https://github.com/junegunn/vim-plug) plugin manager:

`source $HOME/.config/nvim/plugged/vim-elhiv/elhiv.vim`

**Branches**

My repositories contain a master branch and a develop branch. The master branches are the stable branches. The develop branches are where new code appears between releases. The latest commit on the master branch of one repository is compatible with the latest commit on the master branch of another repository (assuming one depends on the other). Likewise, the latest commit on the develop branch of one repository is compatible with the latest commit on the develop branch of another repository.
