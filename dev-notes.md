# Dev Notes

Notes on getting `hgnm-dev` up and running with the HGNM theme and website. Points 2 + 3 below should be automatable.

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

At this point a default WP install is available at <http://hgnm.dev/>. Admin credentials are `admin` & `vagrant`.

## 3. Configure WordPress installation

This whole section should now work by simply running:

```sh
./bootstrap.sh
```

### Install & activate required plugins

```sh
# ACF Date/Time Picker Field Plugin
wp ssh --host=v plugin install https://github.com/soderlind/acf-field-date-time-picker/archive/master.zip
wp ssh --host=v plugin activate acf-field-date-time-picker-master
# Advanced Custom Fields Pro
wget -O wordpress/wp-content/plugins/acf-pro.zip "http://connect.advancedcustomfields.com/index.php?p=pro&a=download&k=b3JkZXJfaWQ9NjQzMTJ8dHlwZT1kZXZlbG9wZXJ8ZGF0ZT0yMDE1LTA5LTE2IDAzOjE4OjEy"
wp ssh --host=v plugin install wordpress/wp-content/plugins/acf-pro.zip
wp ssh --host=v plugin activate advanced-custom-fields-pro
rm wordpress/wp-content/plugins/acf-pro.zip
# WordPress Importer
wp ssh --host=v plugin install wordpress-importer --activate
```

### Install & activate HGNM theme

```sh
git clone git@github.com:HGNM/hgnm-2014.git wordpress/wp-content/themes/hgnm-2014
wp ssh --host=v theme activate hgnm-2014
# Get required proprietary fonts for theme
wget -O df.zip "http://chrisswithinbank.net/wp-content/uploads/2016/06/1407-HRGQJV.zip"
unzip df.zip -d wordpress/wp-content/themes/hgnm-2014/font/
rm df.zip
```

### Populate with Real Content™

```sh
# Clean default generated content
wp ssh --host=v post delete 1 --force # Delete ‘Hello world!’ post
wp ssh --host=v post delete 2 --force # Delete sample page
# Import exported XML from hgnm.org
wp ssh --host=v import hgnm-export.xml --authors=create
```


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
