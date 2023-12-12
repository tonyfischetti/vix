
// TODO: maybe map the JSON to custom class?
//       https://github.com/nlohmann/json#conversion-from-stl-containers

#include <fstream>
#include <iostream>
#include <cstdio>
#include <filesystem>
#include <unordered_map>
#include <utility>
#include <fmt/core.h>

#include "json.hpp"


using json = nlohmann::json;


struct Color {
    /* we need the default constructor */
    Color() noexcept
        : rgbhex{"#000000"},
          cterm{16} { }
    Color(std::string _rgbhex, int _cterm) noexcept
        : rgbhex{_rgbhex},
          cterm{_cterm} { };
    Color(Color&& _color) noexcept
        : rgbhex{std::move(_color.rgbhex)},
          cterm{_color.cterm} { }
    Color(const Color& _color) noexcept
        : rgbhex{_color.rgbhex},
          cterm{_color.cterm} { }
    std::string rgbhex;
    int cterm;
};
Color make_color(const std::string& rgbhex, int cterm) {
    Color color(rgbhex, cterm);
    return color;
}

std::unordered_map<std::string, Color> COLOR_MAP {};




void output_header(const json& data) {
    fmt::print("\" Vim color file - {}\n", data["name"]);
    fmt::print("\" Designed by {} <{}>\n", data["author"], data["email"]);

    for (const auto& item: data["header"]) {
        fmt::print("{}\n", item);
    }

    fmt::print("\nset background={}\nhi clear\nsyntax reset\n\n",
               data["background"]);

    fmt::print("let g:colors_name = \"{}\"\n\n", data["name"]);
}


void fill_color_map(const json& data) {
    for (const auto& item: data["palette"]) {
        COLOR_MAP.try_emplace(item["name"], item["color"]["rgbhex"],
                                            item["color"]["cterm"]);
    }
}



void output_highlights(const json& data) {
    for (const auto& item: data["highlights"].items()) {
        std::string key {item.key()};
        json value      {item.value()};
        auto fg         {value[0]["fg"]};
        auto bg         {value[0]["bg"]};

        std::cout << "hi " << key << " ";

        if (!fg[0].is_null()) {
            const Color color {COLOR_MAP[fg[0]]};
            std::cout << "ctermfg=" << color.cterm << " " << "guifg=" <<
                         color.rgbhex << " ";
        } else { std::cout << " "; }

        if (!bg[0].is_null()) {
            const Color color {COLOR_MAP[bg[0]]};
            std::cout << "ctermbg=" << color.cterm << " " << "guibg=" <<
                         color.rgbhex << " ";
        } else { std::cout << " "; }

        // TODO: not taking `italics` into account
        if (!value[0]["bold"].is_null() || !value[0]["underline"].is_null()) {
            std::string tcterm {};

            if (!value[0]["bold"].is_null() && value[0]["bold"]) {
                tcterm += "bold";
            }
            if (!value[0]["underline"].is_null() && value[0]["underline"]) {
                if (!tcterm.empty())
                    tcterm += ",";
                tcterm += "underline";
            }
            std::cout << "cterm=" << tcterm << " gui=" << tcterm;
        }
        std::cout << std::endl;
    }
}

int main(int argc, char *argv[]) {

    if (argc == 1) {
        throw std::runtime_error {"must supply an argument"};
    }

    std::ifstream afile {argv[1]};
    auto data = json::parse(afile);

    output_header(data);
    fill_color_map(data);
    output_highlights(data);
}

