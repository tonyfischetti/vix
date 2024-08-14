// js, strings, replace, capture, regex, case-insensitive regex, RegExp


const str = "Hello";

str.replace(/^(.{4}).+$/, "$1");    // 'Hell'
str.replace(new RegExp("^(.{4}).+$"), "$1");
str.replace(/l/, 'L');  // 'HeLlo'
str.replaceAll(/l/g, 'L');  // 'HeLLo' (replaceAll needs global flag)
str.replaceAll(/L/ig, '*');  // 'He**o' (case insensitive)
// named capture groups
str.replace(/(?<doublels>l{2})/g, "_$<doublels>_")
