COMPILER="gcc"
ARCH=$(uname -m)
PLATFORM=$(uname)
FRPC_ARCH="null"
FRPC_PLATFORM="null"
DOWNLOADER="wget"

Choose_Compiler(){
    read -p "Please select a compiler[gcc/clang](gcc): " COMPILER;
    if [ "$COMPILER" = 'gcc' ]; then
        echo "Use gcc as compiler."
        COMPILER="gcc"
        elif [ "$COMPILER" = 'clang' ]; then
        echo "Use clang as compiler."
        COMPILER="clang"
    else
        echo "Use gcc as compiler."
        COMPILER="gcc"
    fi
}

Choose_Downloader(){
    read -p "Please select a downloader[curl/wget](curl):" DOWNLOADER;
    if [ "$DOWNLOADER" = 'wget' ]; then
        echo "Use wget as downloader."
        DOWNLOADER="wget"
    else
        echo "Use curl as downloader."
        DOWNLOADER="curl"
    fi
}

Check_Arch(){
    if [ "$ARCH" = 'x86_64' ]; then
        ARCH="amd64"
        elif [ "$ARCH" = 'amd64' ]; then
        ARCH="amd64"
        elif [ "$ARCH" = 'x86' ]; then
        ARCH="x86"
        elif [ "$ARCH" = 'i386' ]; then
        ARCH="x86"
        elif [ "$ARCH" = 'i486' ]; then
        ARCH="x86"
        elif [ "$ARCH" = 'i586' ]; then
        ARCH="x86"
        elif [ "$ARCH" = 'i686' ]; then
        ARCH="x86"
        elif [ "$ARCH" = 'arm64' ]; then
        ARCH="arm64"
        elif [ "$ARCH" = 'aarch64' ]; then
        ARCH="arm64"
        elif [ "$ARCH" = 'arm' ]; then
        ARCH="arm"
        elif [ "$ARCH" = 'armv6' ]; then
        ARCH="arm"
        elif [ "$ARCH" = 'armv7' ]; then
        ARCH="arm"
        elif [ "$ARCH" = 'armv7l' ]; then
        ARCH="arm"
        elif [ "$ARCH" = 'armhf' ]; then
        ARCH="arm"
    else
        printf "[WARN] %s: Invalid architecture.\n" $ARCH
        read -p "Please choose architecture[x86/amd64/arm/arm64]: " ARCH;
        Check_Arch
    fi
}

Check_Platform(){
    if [ "$PLATFORM" = 'Linux' ]; then
        FRPC_PLATFORM="linux"
        elif [ "$PLATFORM" = 'FreeBSD' ]; then
        FRPC_PLATFORM="freebsd"
        elif [ "$PLATFORM" = 'Darwin' ]; then
        FRPC_PLATFORM="darwin"
    else
        printf "[WARN] %s: Invalid platform.\n" $PLATFORM
        read -p "Please choose platform[Linux/Darwin/FreeBSD]: " PLATFORM;
        Check_Platform
    fi
}

Build(){
    Compile
    Deploy
}

Compile(){
    printf "Compiling..."
}

Deploy(){
    printf "Deploying..."
}

Choose_Downloader
Choose_Compiler
Check_Arch
Check_Platform
echo "Building details ------"
printf "System       : %s\n" $PLATFORM
printf "Architecture : %s\n" $ARCH
printf "Compiler     : %s\n" $COMPILER
printf "Downloader   : %s\n" $DOWNLOADER
ConfirmCompile="yes"
read -p "Is this right? [yes/no](yes):" ConfirmCompile;
if [ "$ConfirmCompile" = "yes" ]; then
    Build
    elif [ "$ConfirmCompile" = "" ]; then
    Build
else
    echo "Quit."
fi
