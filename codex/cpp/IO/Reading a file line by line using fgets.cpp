// cpp, reading stdin line by line using fgets, fgets, chrono, benchmarking, vector, using, fopen, fclose, fprintf, command line arguments, file

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


int main(int argc, char *argv[]) {

    if (argc < 2) {
        fprintf(stderr, "no file supplied\n");
        return 1;
    }

    FILE* file = fopen(argv[1], "r");
    if (!file) {
        fprintf(stderr, "could not open file\n");
        return 2;
    }

    char buffer[MAX_LINE_LEN] {};
    std::string currentLine {};
    auto start { std::chrono::high_resolution_clock::now() };

    while (fgets(buffer, sizeof(buffer), file)) {
        size_t len = strlen(buffer);
        if (len > 0 && buffer[len - 1] == '\n') {
            buffer[len - 1] = '\0';
        } else {
            int ch;
            while ((ch = getchar()) != '\n' && ch != EOF);
        }

        allLines.push_back(std::string(buffer, len));
    }

    printf("-- file-fgets --\n");
    auto end = std::chrono::high_resolution_clock::now();
    auto duration { std::chrono::duration_cast<std::chrono::milliseconds>(end - start).count() };
    printf("read %zu lines in %lldms \n", allLines.size(), duration);

    fclose(file);
}

/*
-- file-fgets --
read 235976 lines in 9ms

Identifier:      file-fgets
Version:         0
Code Type:       ARM64
Platform:        macOS

OS Version:      macOS 15.5 (24F74)
Report Version:  7
Analysis Tool:   /usr/bin/leaks

Physical footprint:         2513K
Physical footprint (peak):  8625K
Idle exit:                  untracked
----

leaks Report Version: 4.0, multi-line stacks
Process 51689: 185 nodes malloced for 14 KB
Process 51689: 0 leaks for 0 total leaked bytes.
*/

