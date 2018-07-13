# log-cache-dotfiles

## Getting Started

This install script assumes that you're setting up a Linux workstation with a
GNOME-based desktop environment. This has been test against the following
distros:

* Ubuntu 18.04 LTS
* Mint 18.2

## Prerequisites

You'll want to make sure you have an SSH key added that has access to all of
the team repos.

## Installation

To link the dotfiles and install system-level packages, just run:

```
./install.sh
```

Once that's complete, you can run the following to clone all of the team
packages into `~/workspace`:

```
./clone-repos.sh
```
