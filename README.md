# mech

![Python package](https://github.com/mkinney/mech/workflows/Python%20package/badge.svg)
[![codecov](https://codecov.io/gh/mkinney/mech/branch/master/graph/badge.svg)](https://codecov.io/gh/mkinney/mech)

One of the authors made this because they don't like VirtualBox and wanted to use vagrant
with VMmare Fusion but was too cheap to buy the Vagrant plugin.

https://blog.kchung.co/mech-vagrant-with-vmware-integration-for-free/

Usage is pretty straightforward:

```
Usage: mech [options] <command> [<args>...]

Options:
    -v, --version                    Print the version and exit.
    -h, --help                       Print this help.
    --debug                          Show debug messages.

Common commands:
        box               manages boxes: add, list remove, etc.
        destroy           stops and deletes all traces of the instances
        (down|stop|halt)  stops the instances
        global-status     outputs status of all virutal machines on this host
        init              initializes a new Mech environment by creating a Mechfile
        ip                outputs ip of an instance
        (list|ls)         lists all available boxes
        pause             pauses the instances
        port              displays information about guest port mappings
        provision         provisions the Mech machine
        ps                list running processes for an instance
        reload            restarts Mech machine, loads new Mechfile configuration
        resume            resume a paused/suspended Mech machine
        scp               copies files to/from the machine via SCP
        snapshot          manages snapshots: save, list, remove, etc.
        ssh               connects to an instance via SSH
        ssh-config        outputs OpenSSH valid configuration to connect to the instances
        status            outputs status of the instances
        suspend           suspends the instances
        (up|start)        starts instances (aka virtual machines)
        upgrade           upgrade the instances

For help on any individual command run `mech <command> -h`

Example:

    mech up --help

% mech up --help
Starts and provisions the mech environment.

Usage: mech up [options] [<instance>]

Options:
	--disable-provisioning       Do not provision
	--disable-shared-folders     Do not share folders with VM
	--gui                        Start GUI
	--memsize 1024               Specify the size of memory for VM
	--no-cache                   Do not save the downloaded box
	--no-nat                     Do not use NAT network (i.e., bridged)
	--numvcpus 1                 Specify the number of vcpus for VM
    -h, --help                       Print this help
    -r, --remove-vagrant             Remove vagrant user

Example using mech:


Initializing and using a machine from HashiCorp's Vagrant Cloud:

    mech init bento/ubuntu-18.04
    mech up
    mech ssh
```

`mech init` can be used to pull a box file which will be installed and
generate a Mechfile in the current directory. You can also pull boxes
from Vagrant Cloud with `mech init freebsd/FreeBSD-11.1-RELEASE`.
See the `mech up -h` page for more information.

# Install

`pip install -U mikemech`

or for the latest:

`pip install -U git+https://github.com/mkinney/mech.git`

# Shared Folders

If the box you init was created properly, you will be able to access
the host's current working directory in `/mnt/hgfs/mech`. If you are
having trouble try running:

```bash
sudo apt-get update
sudo apt-get install linux-headers-$(uname -r) open-vm-tools
```

followed by

```bash
sudo vmware-config-tools.pl
```

or

```bash
vmhgfs-fuse .host:/mech /mnt/hgfs
```

# Changing vcpus and/or memory size

If you do not specify how many vcpus or memory, then the values
in the .box file will be used. To override, use appropriate settings:

`mech up --numvcpus 2 --memsize 1024`


# Want zsh completion for commands/options (aka "tab completion")?
1. add these lines to ~/.zshrc

```bash
# folder of all of your autocomplete functions
fpath=($HOME/.zsh-completions $fpath)
# enable autocomplete function
autoload -U compinit
compinit
```

2. Copy script to something in fpath (Note: Run `echo $fpath` to show value.)

```bash
cp _mech ~/.zsh-completions/
```

3. Reload zsh

```bash
exec zsh
```

4. Try it out by typing `mech <tab>`. It should show the options available.

# Want bash completion for commands/options (aka "tab completion")?
1. add these lines to ~/.bash_profile

```bash
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
```

2. Copy script to path above

```bash
cp mech_completion.sh /usr/local/etc/bash_completion/
```

3. Reload .bash_profile

```bash
source ~/.bash_profile
```

4. Try it out by typing `mech <tab>`. It should show the options available.
