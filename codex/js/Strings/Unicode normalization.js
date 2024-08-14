// js, strings, unicode normalization, NFD, NFC

const nfd = "Όλοι οι άνθρωποι";

nfd;                    // Όλοι οι άνθρωποι
nfd.normalize("NFC");   // Όλοι οι άνθρωποι

nfd === nfd.normalize("NFC");     // false
