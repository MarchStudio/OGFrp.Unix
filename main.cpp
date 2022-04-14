#include "libArch.h"
#include "libPlatform.h"
#include "work.cpp"

int main() {
    OGFrp ogfrp(getExePath(), Arch, SubPlatform);
    return ogfrp.main();
}