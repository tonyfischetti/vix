// cpp, date and time, get unix time, chrono, duraction_cast, time_since_epoch, high_resolution_clock

#include <chrono>

int main () {

    auto now    { std::chrono::high_resolution_clock::now() };

    auto msSinceEpoch { std::chrono::duration_cast<std::chrono::milliseconds>(now.time_since_epoch()).count() };
    auto sSinceEpoch  { std::chrono::duration_cast<std::chrono::seconds>(now.time_since_epoch()).count() };

    printf("Now: %lld\n", msSinceEpoch);
    printf("Now: %lld\n", sSinceEpoch);

}
