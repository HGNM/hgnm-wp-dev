# Dev Notes

How to get set up with a development environment to allow work on the `hgnm-2014` theme.


## 1. Install prerequisites

To get the dev environment up and running we need [wget](https://www.gnu.org/software/wget/), [WP-CLI](https://wp-cli.org/), [Virtual Box](https://www.virtualbox.org/), [Vagrant](https://www.vagrantup.com/), and the [Vagrant Hostsupdater](https://github.com/cogitatio/vagrant-hostsupdater) plugin.

Simplest is to use [Homebrew](http://brew.sh/) (you can skip any dependencies already installed):

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

On first `vagrant up`, downloading and installing dependencies will take some time (Ruby is slow…). Sit back and wait! Any password requests at this point require OS admin passwords.

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

### Clean up and prepare for a fresh install

***N.B. This gets rid of everything!!!***

```sh
vagrant destroy
cd ../
rm hgnm-dev
```
