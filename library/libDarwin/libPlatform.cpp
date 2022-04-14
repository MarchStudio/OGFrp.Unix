#pragma once

#include <iostream>
#include <unistd.h>

std::string getExePath() {
	std::string result;
    const int MAXPATH = 2500;
    char buffer[MAXPATH];
    getcwd(buffer, MAXPATH);
    result = buffer;
    return result;
}