#!/bin/bash

print_color () { tput setab 7; tput setaf 0; echo "$1"; tput sgr0; }

# Check all required CLIs are available
dependencies=( wget wp git unzip )
for dependency in "${dependencies[@]}"; do
  command -v $dependency >/dev/null 2>&1 || { echo >&2 "‘$dependency’ command is required but it’s not installed. Aborting."; exit 1; }
done

# Should be executed after you have run `vagrant up`
if [ ! -d "wordpress" ]; then
  echo "Can’t find directory: wordpress. Have you run “vagrant up” yet?"
  exit 1
fi


####################################
# PLUGIN INSTALLATION & ACTIVATION #
####################################

# Advanced Custom Fields Pro
wget -O wordpress/wp-content/plugins/acf-pro.zip "http://connect.advancedcustomfields.com/index.php?p=pro&a=download&k=b3JkZXJfaWQ9NjQzMTJ8dHlwZT1kZXZlbG9wZXJ8ZGF0ZT0yMDE1LTA5LTE2IDAzOjE4OjEy"
if [[ -f "wordpress/wp-content/plugins/acf-pro.zip" ]]; then
  wp ssh --host=v plugin install wordpress/wp-content/plugins/acf-pro.zip --activate
  rm wordpress/wp-content/plugins/acf-pro.zip
else
  echo "Can’t find file: wordpress/wp-content/plugins/acf-pro.zip. Fatal error…"
  exit 1
fi

# ACF Date/Time Picker Field Plugin
wp ssh --host=v plugin install https://github.com/soderlind/acf-field-date-time-picker/archive/master.zip --activate

# WordPress Importer
wp ssh --host=v plugin install wordpress-importer --activate


###################################
# THEME INSTALLATION & ACTIVATION #
###################################

# Install & activate hgnm-2014 theme
git clone git@github.com:HGNM/hgnm-2014.git wordpress/wp-content/themes/hgnm-2014
if [ -d "wordpress/wp-content/themes/hgnm-2014" ]; then
  wp ssh --host=v theme activate hgnm-2014
else
  echo "Can’t find directory: wordpress/wp-content/themes/hgnm-2014. Fatal error…"
  exit 1
fi

# Get required proprietary fonts for theme
wget -O df.zip "http://chrisswithinbank.net/wp-content/uploads/2016/06/1407-HRGQJV.zip"
if [[ -f "df.zip" ]]; then
  unzip df.zip -d wordpress/wp-content/themes/hgnm-2014/font/
  rm df.zip
else
  echo "Can’t find file: df.zip. Fatal error…"
  exit 1
fi


#############################
# POPULATE DATABASE CONTENT #
#############################

# Clean default generated content
wp ssh --host=v post delete 1 --force # Delete ‘Hello world!’ post
wp ssh --host=v post delete 2 --force # Delete sample page
# Import exported XML from hgnm.org
if [[ -f "hgnm-export.xml" ]]; then
  wp ssh --host=v import hgnm-export.xml --authors=create
else
  echo "Can’t find file: hgnm-export.xml. Fatal error…"
  exit 1
fi
