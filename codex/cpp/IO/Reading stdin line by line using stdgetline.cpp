// cpp, reading stdin line by line using getline, getline, chrono, benchmarking, vector, using, stdin

#include <iostream>
#include <string>
#include <vector>

// static std::vector<std::string> 
using StrVec = std::vector<std::string>;
static StrVec allLines {};

int main() {

    std::string currentLine {};
    auto start { std::chrono::high_resolution_clock::now() };

    while (std::getline(std::cin, currentLine)) {
        allLines.push_back(currentLine);
    }

    printf("-- std::getline --\n");
    auto end = std::chrono::high_resolution_clock::now();
    auto duration { std::chrono::duration_cast<std::chrono::milliseconds>(end - start).count() };
    printf("read %zu lines in %lldms \n", allLines.size(), duration);

}


/*
-- std::getline --
read 235976 lines in 50ms

Identifier:      stdgetline
Version:         0
Code Type:       ARM64
Platform:        macOS
Target Type:     live task

OS Version:      macOS 15.5 (24F74)

Physical footprint:         2401K
Physical footprint (peak):  8593K
Idle exit:                  untracked
----

leaks Report Version: 4.0, multi-line stacks
Process 23415: 186 nodes malloced for 19 KB
Process 23415: 0 leaks for 0 total leaked bytes.
*/

