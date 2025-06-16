// cpp, reading stdin line by line using fgets, fgets, chrono, benchmarking, vector, using, stdin

#include <chrono>
#include <string>
#include <vector>

/**
 * SEE  PERFORMANCE  BELOW
 */

using StrVec = std::vector<std::string>;

// constexpr uint MAX_LINE_LEN { 1024 };
// constexpr uint MAX_LINE_LEN { 2048 };
constexpr uint MAX_LINE_LEN { 4096 };
static StrVec allLines {};


int main() {

    char buffer[MAX_LINE_LEN] {};
    std::string currentLine {};
    auto start { std::chrono::high_resolution_clock::now() };

    while (fgets(buffer, sizeof(buffer), stdin)) {
        size_t len = strlen(buffer);
        if (len > 0 && buffer[len - 1] == '\n') {
            buffer[len - 1] = '\0';
        } else {
            int ch;
            while ((ch = getchar()) != '\n' && ch != EOF);
        }

        allLines.push_back(std::string(buffer, len));
    }

    printf("-- fgets --\n");
    auto end = std::chrono::high_resolution_clock::now();
    auto duration { std::chrono::duration_cast<std::chrono::milliseconds>(end - start).count() };
    printf("read %zu lines in %lldms \n", allLines.size(), duration);

}

/*
-- fgets --
read 235976 lines in 9ms

Identifier:      fgets
Version:         0
Code Type:       ARM64
Platform:        macOS
Parent Process:  leaks [23447]
Target Type:     live task

OS Version:      macOS 15.5 (24F74)

Physical footprint:         2465K
Physical footprint (peak):  8625K
Idle exit:                  untracked
----

leaks Report Version: 4.0, multi-line stacks
Process 23448: 186 nodes malloced for 19 KB
Process 23448: 0 leaks for 0 total leaked bytes.
*/

