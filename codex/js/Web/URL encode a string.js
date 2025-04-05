// js, web, URL encode, URI encode, encodeURIComponent, encodeURI

const test = "this is not & test";

// when you want to encode a full url
encodeURI(test);            // 'this%20is%20not%20&%20test'
encodeURIComponent(test);   // 'this%20is%20not%20%26%20test'

