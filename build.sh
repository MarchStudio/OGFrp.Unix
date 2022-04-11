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
        COMPILER="g++"
        elif [ "$COMPILER" = 'clang' ]; then
        echo "Use clang as compiler."
        COMPILER="clang"
    else
        echo "Use gcc as compiler."
        COMPILER="g++"
    fi
}

Choose_Downloader(){
    read -p "Please select a downloader[curl/wget](curl): " DOWNLOADER;
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

GetFrpcArch(){
    if [ "$ARCH" = 'x86' ]; then
        FRPC_ARCH="386"
    else
        FRPC_ARCH=$ARCH
    fi
}

Check_Platform(){
    if [ "$PLATFORM" = 'Linux' ]; then
        FRPC_PLATFORM="linux_"
        elif [ "$PLATFORM" = 'FreeBSD' ]; then
        FRPC_PLATFORM="freebsd_"
        elif [ "$PLATFORM" = 'Darwin' ]; then
        FRPC_PLATFORM="darwin_"
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
    echo "Preparaing..."
    mkdir ./build
    cd ./build
    echo "Fetching source..."
    $DOWNLOADER https://src.ogfrp.cn/Unix/main.cpp -o ./main.cpp
    $DOWNLOADER https://src.ogfrp.cn/Unix/work.cpp -o ./work.cpp
    $DOWNLOADER "https://src.ogfrp.cn/Unix/library/lib$PLATFORM/libPlatform.cpp" -o ./libPlatform.cpp
    $DOWNLOADER "https://src.ogfrp.cn/Unix/library/lib$PLATFORM/libPlatform.h" -o ./libPlatform.h
    $DOWNLOADER "https://src.ogfrp.cn/Unix/library/libArches/$ARCH.h" -o ./libArch.h
    echo "Compiling..."
    $COMPILER ./main.cpp -o ./ogfrp
}

Deploy(){
    echo "Deploying..."
    curl "https://client.ogfrp.cn/frpc/frpc_$FRPC_PLATFORM$FRPC_ARCH" -o ./frpc
    if [ "$PLATFORM" = 'Linux' ]; then
        cp ./ogfrp /usr/bin
        chmod 444 /usr/bin/ogfrp
        cp ./frpc /usr/bin
        chmod 444 /usr/bin/frpc
        elif [ "$PLATFORM" = 'Darwin' ]; then
        mkdir /usr/local/bin
        cp ./ogfrp /usr/local/bin
        chmod 444 /usr/local/bin/ogfrp
        cp ./frpc /usr/local/bin
        chmod 444 /usr/local/bin/frpc
        elif [ "$PLATFORM" = 'FreeBSD' ]; then
        cp ./ogfrp /usr/local/bin
        chmod 444 /usr/local/bin/ogfrp
        cp ./frpc /usr/local/bin
        chmod 444 /usr/local/bin/frpc
    else
        echo "An error occured."
        return
    fi
    echo "Installation completed."
    echo "Type 'ogfrp' "
}

echo "  ____   _____ ______           "
echo " / __ \ / ____|  ____|          "
echo "| |  | | |  __| |__ _ __ _ __   "
echo "| |  | | | |_ |  __| '__| '_ \  "
echo "| |__| | |__| | |  | |  | |_) | "
echo " \____/ \_____|_|  |_|  | .__/  "
echo "                        | |     "
echo "                        |_|     "
printf "\n"
Choose_Downloader
Choose_Compiler
Check_Arch
GetFrpcArch
Check_Platform
echo "Building details ------"
printf "System       : %s\n" $PLATFORM
printf "Architecture : %s\n" $ARCH
printf "Compiler     : %s\n" $COMPILER
printf "Downloader   : %s\n" $DOWNLOADER
echo "-----------------------"
ConfirmCompile="yes"
read -p "Is this correct? [yes/no](yes):" ConfirmCompile;
if [ "$ConfirmCompile" = "yes" ]; then
    Build
    elif [ "$ConfirmCompile" = "" ]; then
    Build
fi
echo "Quit."
