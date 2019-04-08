# log-cache-dotfiles

## Getting Started

This install script assumes that you're setting up a Linux workstation with a
GNOME-based desktop environment. This has been test against the following
distros:

* Ubuntu 18.04 LTS
* Mint 18.2
* OS X Sierra (separate script)

## Prerequisites

You'll want to make sure you have an SSH key added that has access to all of
the team repos (located in `assets/repo-list`).

## Installation

To link the dotfiles and install system-level packages, just run:

```bash
./install.sh
```

On OS X

```bash
./install-on-osx.sh
```

Run `:PlugInstall` in vim

## Contributing

Want to make changes or add new packages? Just push up a branch and open a PR.
