// cpp, reading from a file line by line using getline, getline, command line arguments, chrono, benchmarking, vector, using, ifstream, fstream, file

#include <iostream>
#include <fstream>
#include <string>
#include <vector>

/**
 * SEE  PERFORMANCE  BELOW
 */

// static std::vector<std::string> 
using StrVec = std::vector<std::string>;
static StrVec allLines {};

int main(int argc, char *argv[]) {

    if (argc < 2) {
        std::cerr << "no file supplied\n";
        return 1;
    }

    std::string currentLine {};
    auto start { std::chrono::high_resolution_clock::now() };

    std::ifstream file { argv[1] };
    if (!file) {
        std::cerr << "Failed to open file\n";
        return 1;
    }

    while (std::getline(file, currentLine)) {
        allLines.push_back(currentLine);
    }

    printf("-- std::getline --\n");
    auto end = std::chrono::high_resolution_clock::now();
    auto duration { std::chrono::duration_cast<std::chrono::milliseconds>(end - start).count() };
    printf("read %zu lines in %lldms \n", allLines.size(), duration);

}


/*
-- file-getline --
read 235976 lines in 10ms
Identifier:      file-stdgetline
Version:         0
Code Type:       ARM64
Platform:        macOS
Target Type:     live task

OS Version:      macOS 15.5 (24F74)

Physical footprint:         4177K
Physical footprint (peak):  10.0M
Idle exit:                  untracked
----

leaks Report Version: 4.0, multi-line stacks
Process 27653: 185 nodes malloced for 14 KB
Process 27653: 0 leaks for 0 total leaked bytes.
*/

