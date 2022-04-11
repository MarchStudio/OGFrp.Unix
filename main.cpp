#include "work.cpp"
#include "libPlatform.h"
#include "libArch.h"

OGFrp ogfrp(get_cur_executable_path_(),Arch, SubPlatform);

int main() {
	return ogfrp.main();
}