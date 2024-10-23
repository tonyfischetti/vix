
import { utilsImportTest } from './utils.js';

console.log("JS works...");

document.querySelector<HTMLDivElement>('#footer')!.innerHTML = `
  <span>this element was replaced by js</span>`;

const start = () => {
  console.log("DOMContentLoaded");
  utilsImportTest();
};

window.addEventListener('DOMContentLoaded', start);

