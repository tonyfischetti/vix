// js, web, fetch, request, GET, binary data, bytes, blobs, write binary file

import * as fs from 'node:fs/promises';


fetch("https://ifconfig.me/all.json").
  then(console.log);        // returns a `Response`

/*
  Response {
    status: 200,
    statusText: 'OK',
    headers: Headers {
      date: 'Fri, 16 Aug 2024 18:46:08 GMT',
      'content-type': 'text/html; charset=utf-8',
      'content-length': '9708',
      'access-control-allow-origin': '*',
      via: '1.1 google',
      'alt-svc': 'h3=":443"; ma=2592000,h3-29=":443"; ma=2592000'
    },
    body: ReadableStream { locked: false, state: 'readable', supportsBYOB: true },
    bodyUsed: false,
    ok: true,
    redirected: false,
    type: 'basic',
    url: 'https://ifconfig.me/'
  }
*/

// TEXT

fetch("https://ifconfig.me").
  then(response => response.text()).
  then(console.log);

// JSON

fetch("https://ifconfig.me/all.json").
  then(response => response.json()).
  then(({ip_addr}) => console.log(ip_addr));


// BLOB / binary data

fetch("https://thepolygram.com/pluto-p.png").
  then(response => response.blob()).        // Blob { size: 243788, type: 'image/png' }
  then(blob => blob.bytes()).
  then(ab => fs.writeFile("pluto-p.png", ab)).
  then(_ => console.log("done"));



fetch("https://ifconfig.me/all.json",
  { method: "GET",
    headers: null,
    body: null,         // for POST
    mode: "cors",       // {cors, no-cors, same-origin, navigate, websocket}
    redirect: "follow", // {follow, error, manual}
    referrer: "",
    // ...
  });

