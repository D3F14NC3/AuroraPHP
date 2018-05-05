clear
echo "
            █████╗ ██╗   ██╗██████╗  ██████╗ ██████╗  █████╗     
	       ██╔══██╗██║   ██║██╔══██╗██╔═══██╗██╔══██╗██╔══██╗   
           ███████║██║   ██║██████╔╝██║   ██║██████╔╝███████║   
           ██╔══██║██║   ██║██╔══██╗██║   ██║██╔══██╗██╔══██║   
           ██║  ██║╚██████╔╝██║  ██║╚██████╔╝██║  ██║██║  ██║    
           ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝     

██╗███╗   ██╗███████╗████████╗ █████╗ ██╗     ██╗     ███████╗██████╗
██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██║     ██╔════╝██╔══██╗
██║██╔██╗ ██║███████╗   ██║   ███████║██║     ██║     █████╗  ██████╔╝
██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██║     ██╔══╝  ██╔══██╗
██║██║ ╚████║███████║   ██║   ██║  ██║███████╗███████╗███████╗██║  ██║
╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝
";

if [ "$PREFIX" = "/data/data/com.termux/files/usr" ]; then
    INSTALL_DIR="$PREFIX/usr/share/doc/Aurora"
    BIN_DIR="$PREFIX/bin/"
    BASH_PATH="$PREFIX/bin/bash"
    TERMUX=true

    pkg install -y git python2
elif [ "$(uname)" = "Darwin" ]; then
    INSTALL_DIR="/usr/local/Aurora"
    BIN_DIR="/usr/local/bin/"
    BASH_PATH="/bin/bash"
    TERMUX=false
else
    INSTALL_DIR="$HOME/.Aurora"
    BIN_DIR="/usr/local/bin/"
    BASH_PATH="/bin/bash"
    TERMUX=false

    sudo apt-get install -y git python2.7
fi

echo "[✔] Checking directories...";
if [ -d "$INSTALL_DIR" ]; then
    echo "[◉] A directory Aurora was found! Do you want to replace it? [Y/n]:" ;
    read mama
    if [ "$mama" = "y" ]; then
        if [ "$TERMUX" = true ]; then
            rm -rf "$INSTALL_DIR"
            rm "$BIN_DIR/Aurora*"
        else
            sudo rm -rf "$INSTALL_DIR"
            sudo rm "$BIN_DIR/Aurora*"
        fi
    else
        echo "[✘] If you want to install you must remove previous installations [✘] ";
        echo "[✘] Installation failed! [✘] ";
        exit
    fi
fi
echo "[✔] Cleaning up old directories...";
if [ -d "$ETC_DIR/Aurora" ]; then
    echo "$DIR_FOUND_TEXT"
    if [ "$TERMUX" = true ]; then
        rm -rf "$ETC_DIR/Aurora"
    else
        sudo rm -rf "$ETC_DIR/Aurora"
    fi
fi

echo "[✔] Installing ...";
echo "";
git clone --depth=1 https://github.com/Aurora/Aurora "$INSTALL_DIR";
echo "#!$BASH_PATH
python $INSTALL_DIR/Aurora.py" '${1+"$@"}' > "$INSTALL_DIR/Aurora";
chmod +x "$INSTALL_DIR/Aurora";
if [ "$TERMUX" = true ]; then
    cp "$INSTALL_DIR/Aurora" "$BIN_DIR"
    cp "$INSTALL_DIR/Aurora.cfg" "$BIN_DIR"
else
    sudo cp "$INSTALL_DIR/Aurora" "$BIN_DIR"
    sudo cp "$INSTALL_DIR/Aurora.cfg" "$BIN_DIR"
fi
rm "$INSTALL_DIR/Aurora";


if [ -d "$INSTALL_DIR" ] ;
then
    echo "";
    echo "[✔] Tool installed successfully! [✔]";
    echo "";
    echo "[✔]====================================================================[✔]";
    echo "[✔]      All is done!! You can execute tool by typing Aurora !       [✔]";
    echo "[✔]====================================================================[✔]";
    echo "";
else
    echo "[✘] Installation failed! [✘] ";
    exit
fi
