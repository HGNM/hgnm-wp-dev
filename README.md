# README

This is a WordPress development environment, forked from [`VagrantPress`](https://github.com/vagrantpress/vagrantpress), that will allow you to get set up with a local WordPress install and work on the [`hgnm-2014`](https://github.com/HGNM/hgnm-2014) theme.


## 1. Install prerequisites

The following command line tools are required:
- [wget](https://www.gnu.org/software/wget/)
- [WP-CLI](https://wp-cli.org/)
- [Virtual Box](https://www.virtualbox.org/)
- [Vagrant](https://www.vagrantup.com/)
- [Vagrant Hostsupdater](https://github.com/cogitatio/vagrant-hostsupdater) plugin

You can install all of these with [Homebrew](http://brew.sh/), plus Vagrant’s package manager:

```sh
brew update # make sure we have an up-to-date formula list
brew install wget
brew install homebrew/php/wp-cli
brew cask install virtualbox
brew cask install vagrant
vagrant plugin install vagrant-hostsupdater
```


## 2. Clone dev environment

Do this somewhere sensible, such as your `Sites` folder or wherever you like to keep your development repos.

```sh
git clone git@github.com:HGNM/hgnm-wp-dev.git; cd hgnm-wp-dev; vagrant up
```

Downloading and installing dependencies will take some time. Go make a cup of tea or reply to some e-mails.

Any password prompts at this point require OS X admin passwords.


## 3. Configure WordPress installation

```sh
./bootstrap.sh
```

This bootstrap script will install & activate required WordPress plugins, populate WordPress with real content from [hgnm.org](http://hgnm.org), and install & activate the `hgnm-2014` WordPress theme, including downloading fonts stored separately.


## 4. Enjoy!

At this point a default WP install is available at <http://hgnm.dev/>.

Admin credentials are `admin` & `vagrant`.


## Useful commands

### Turn off the virtual machine running WP

```sh
vagrant halt
```

### Restart the virtual machine

```sh
vagrant up
```

### Clean up and prepare for a fresh install

```sh
vagrant destroy
```
