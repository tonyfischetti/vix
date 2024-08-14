// cpp, strings, regex, splitting strings, re2, fmt, format, string interpolation, vector, default arguments, FindAndConsume, push_back, empty

#include <fmt/core.h>  // compile with -lfmt
#include <re2/re2.h>   // compile with -lre2

// UN-OPTIMIZED
vector<string> str_split_regex(string astr, string aregex,
                               bool include_empties=false) {
    vector<string> holder {};

    if (!RE2::PartialMatch(astr, aregex)) {
        holder.push_back(astr);
        return holder;
    }

    string theregex {fmt::format("(?s)(.*?){}", aregex)};
    re2::StringPiece str {astr};
    string thematch {};

    while (RE2::FindAndConsume(&str, theregex, &thematch)) {
        if (include_empties || !thematch.empty()) holder.push_back(thematch);
    }
    if (include_empties || !str.empty()) holder.push_back(string(str));

    return holder;
}

string str {"pee pee poo poo"};
str_split_regex(str, "p");      // [ 'ee ', 'ee ', 'oo ', 'oo' ] (4)
str_split_regex(str, "\\s+");   // [ 'pee', 'pee', 'poo', 'poo' ] (4)

string str {"pee pee\nppoooo\t poo"};
str_split_regex(str, "\\s+");
// [ 'pee', 'pee', 'ppoooo', 'poo' ] (4) {matches new-line}

string str {"pee pee ppoooo poop"};
// `include_empties` paramater
str_split_regex(str, "p", true);
// [ '', 'ee ', 'ee ', '', 'oooo ', 'oo', '' ] (7)
