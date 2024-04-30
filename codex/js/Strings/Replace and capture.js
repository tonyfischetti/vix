const str = "Hello";
str.replace(/^(.{4}).+$/, "$1");    // 'Hell'
str.replace(new RegExp("^(.{4}).+$"), "$1");
str.replace(/l/, 'L');  // 'HeLlo'
str.replaceAll(/l/g, 'L');  // 'HeLLo' (replaceAll needs global flag)
str.replaceAll(/L/ig, '*');  // 'He**o' (case insensitive)