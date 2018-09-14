# hgnm-wp-dev

> Scripts to help you get set up with a local WordPress install and work on the [`hgnm-2014`][hgnm2014] theme, using [Local by Flywheel][local].

  [hgnm2014]: https://github.com/HGNM/hgnm-2014
  [local]: https://local.getflywheel.com/ "Local"

## Set-up

The scripts included here will install & activate required WordPress plugins, populate WordPress with real content from [hgnm.org](http://hgnm.org), and install & activate the `hgnm-2014` WordPress theme as a development repository.

### 1. Install & set-up Local

We are going to use [Local][local], a free desktop app that allows you to run local WordPress instances.

1. **[Download Local for macOS →](https://local-by-flywheel-flywheel.netdna-ssl.com/releases/2-2-4/local-by-flywheel-2-2-4-mac.zip)**

2. Once the download has finished, run the installer and open Local
  
3. Create a new site using the dialog displayed or **File** > **Add New Site** (<kbd>⌘ N</kbd>)

    The settings are not very important, but for the rest of this guide we will assume you enter `hgnm` as the site name
    
4. Click through as Local sets up your site, making a note of the username and password you enter in the “Setup WordPress” panel

### 2. Configure the site for HGNM development

1. Open a **Terminal** window and move to the site directory:

    ```sh
    cd ~/Local\ Sites/hgnm
    ```
    
2. Clone this repository:

    ```sh
    git clone https://github.com/HGNM/hgnm-wp-dev.git
    ```
    
3. Run the first bootstrapping script:

    ```sh
    ./hgnm-wp-dev/one
    ```

4. Return to the Local app, right-click on your site and select **Open Site SSH**

    ![Screenshot of the Local app showing the menu to click on](.github/local-ssh.png)
    
5. A new Terminal window will open. This process is running inside Local’s virtual machine. Run the second bootstrapping script:

    ```sh
    ./app/two
    ```
    
    You can now close the new Terminal window.


### 3. Enjoy!

At this point a default WP install is available at <http://hgnm.local/> (unless you chose a different local address in step 1).

Head over to [the `hgnm-2014` repository](https://github.com/HGNM/hgnm-2014#development) for notes on how to develop the theme.

You can move to the theme directory using the following command:

```sh
cd ~/Local\ Sites/hgnm/app/public/wp-content/themes/hgnm-2014
```

## Usage

Once you have followed the steps above, closing Local will close the local server and opening Local will start it again.

If you would like to use WP-CLI to accomplish some tasks, it is available as `wp` on the virtual machine, which can be opened using **Open Site SSH** as in step 2.4 above.
