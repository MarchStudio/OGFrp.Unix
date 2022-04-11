#include "libArch.h"
#include "libPlatform.h"
#include "work.cpp"

int main() {
    OGFrp ogfrp(get_cur_executable_path_(), Arch, SubPlatform);
    return ogfrp.main();
}