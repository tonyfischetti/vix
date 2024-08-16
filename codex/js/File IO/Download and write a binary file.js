// js, file io, fs.writeFile, binary, blobs, fetch, GET, web, typed arrays, bytes

fetch("https://thepolygram.com/pluto-p.png").
  then(response => response.blob()).            // Blob { size: 243788, type: 'image/png' }
  then(blob => blob.bytes()).                   // Uint8Array (typed array)
  then(ab => fs.writeFile("pluto-p.png", ab)).
  then(_ => console.log("done"));

