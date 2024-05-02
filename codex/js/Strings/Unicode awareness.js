let nfc = "Όλοι οι άνθρωποι";
let nfd = "Όλοι οι άνθρωποι";

nfc.length;         // 16
nfd.length;         // 18

nfc = nfc.split(/\s+/)[0];    // Όλοι
nfd = nfd.split(/\s+/)[0];    // Όλοι

nfc.length;         // 4
nfd.length;         // 5

Array.from(nfc);     // [ "Ό", "λ", "ο", "ι" ]
Array.from(nfd);     // [ "Ο", "́", "λ", "ο", "ι" ]

nfc.split(/λ/)      // [ "Ό", "οι" ]
