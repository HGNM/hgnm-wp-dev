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

# Parse command line option flags
CLONE_STYLE="ssh"
while [[ $# > 0 ]]; do
  key="$1"
  case $key in
    -h|--https)
    CLONE_STYLE="https"
    shift # past argument
    ;;
    -s|--ssh)
    CLONE_STYLE="ssh"
    shift # past argument
    ;;
    *)
    echo "Unrecognised option $key. Try --https or --ssh."
    ;;
  esac
  shift # past argument or value
done


####################################
# PLUGIN INSTALLATION & ACTIVATION #
####################################

# Advanced Custom Fields Pro
print_color "Installing Advanced Custom Fields Pro plugin..."
wget -O wordpress/wp-content/plugins/acf-pro.zip "http://connect.advancedcustomfields.com/index.php?p=pro&a=download&k=b3JkZXJfaWQ9NjQzMTJ8dHlwZT1kZXZlbG9wZXJ8ZGF0ZT0yMDE1LTA5LTE2IDAzOjE4OjEy"
if [[ -f "wordpress/wp-content/plugins/acf-pro.zip" ]]; then
  wp ssh --host=v plugin install wordpress/wp-content/plugins/acf-pro.zip --activate
  rm wordpress/wp-content/plugins/acf-pro.zip
else
  echo "Can’t find file: wordpress/wp-content/plugins/acf-pro.zip. Fatal error…"
  exit 1
fi

# WordPress Importer
print_color "Installing WordPress Importer plugin..."
wp ssh --host=v plugin install wordpress-importer --activate


###################################
# THEME INSTALLATION & ACTIVATION #
###################################

# Set remote URL
if [[ $CLONE_STYLE == "https" ]]; then
  THEME_REMOTE_URL="https://github.com/HGNM/hgnm-2014.git"
elif [[ $CLONE_STYLE == "ssh" ]]; then
  THEME_REMOTE_URL="git@github.com:HGNM/hgnm-2014.git"
else
  THEME_REMOTE_URL="git@github.com:HGNM/hgnm-2014.git"
fi

# Install & activate hgnm-2014 theme
print_color "Installing hgnm-2014 WordPress theme..."
git clone $THEME_REMOTE_URL wordpress/wp-content/themes/hgnm-2014
if [ -d "wordpress/wp-content/themes/hgnm-2014" ]; then
  wp ssh --host=v theme activate hgnm-2014
else
  echo "Can’t find directory: wordpress/wp-content/themes/hgnm-2014. Fatal error…"
  exit 1
fi


#############################
# POPULATE DATABASE CONTENT #
#############################

# Clean default generated content
print_color "Deleting generic WordPress content..."
wp ssh --host=v post delete 1 --force # Delete ‘Hello world!’ post
wp ssh --host=v post delete 2 --force # Delete sample page
# Import exported XML from hgnm.org
print_color "Importing hgnm.org content..."
if [[ -f "hgnm-export.xml" ]]; then
  wp ssh --host=v import hgnm-export.xml --authors=create
else
  echo "Can’t find file: hgnm-export.xml. Fatal error…"
  exit 1
fi
