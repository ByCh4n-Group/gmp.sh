# Get My Package - gmp.sh (version 1)
![gmp](https://lh3.googleusercontent.com/proxy/ATXim4MEx1UUUWEr2BbiHTkAeL2nVFgKXBLE6rK1sBr2CG0GCiRTYfrwtDMNo8ktTUPBVzWQwz8jhlIJUCeJqUYzpc6332gckBf3WVKDtH_j4nY)
<br>
Get My Package alternative package management script for https://github.com/ByCh4n-Group/bych4n_x86_64_main
## how to install
```bash
git clone https://github.com/ByCh4n-Group/gmp.sh
cd gmp.sh && sudo bash ./install.sh -i
# easy peasy
```

## how to uninstall
```bash
cd /path/to/gmpt.sh
sudo bash ./install.sh -ui
# easy peasy x2
```
## help argument output
```bash
# ~$ gmp.sh --help
flags: --list, --check, --install, --uninstall, --get, --version, --help

--list: This argument is used simply and what it does is bring the 
    index.sh file and show the content to the user.

--check: To use the check argument, enter the name of the package
    you want to search in the next parameter. Optionally, you can specify the 3rd argument
    for other distributions. You can control up to 1 package and 1 system base at a time.

/usr/bin/gmp.sh --check mypackage --rpm

--install: After the install argument, specify which package you want to install
    as a parameter. The package will be automatically downloaded and directed to the
    installation according to your system infrastructure.

/usr/bin/gmp.sh --install mypackage

--uninstall: Specify the package you want to delete as the parameter after the
    uninstall argument, your system will automatically be detected and you will be automatically
    directed to delete the package.

/usr/bin/gmp.sh --uninstall mypackage

--get: It is used with a parameter next to the get argument.
    You must enter which package you want to download in this parameter.
    You can bring a maximum of 1 package
    each time.You can download a custom package as 3 arguments.
    Normally, it is automatically detected that you do not use this argument.

/usr/bin/gmp.sh --get mypackage --pkg.tar.zst

--version: shows version, maintainer and main repository.

--help: this shows the help menu.

Get My Package is not a package manager, it does not store metadata files,
it pulls all the data from the config files manually assigned in the git repository
and asks the package manager to install or remove the retrieved package that is compatible
with your system. This GMP has super unicorn powers.
```
also this unicorn emphasizes:
<br>
![alicorn](https://github.com/ByCh4n-Group/items/raw/main/unicorn.png)
