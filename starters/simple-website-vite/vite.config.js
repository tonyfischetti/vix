
import { defineConfig }       from 'vite';
import { ViteEjsPlugin }      from 'vite-plugin-ejs';
import { resolve }            from 'path'
import { globSync }           from 'glob';
import { fileURLToPath }      from 'node:url';
import { ViteImageOptimizer } from 'vite-plugin-image-optimizer';


const getHTMLPages = () => {
  const pages = [...globSync("*.html"),
                 ...globSync("pages/**/*.html")];
                   // map(fn => relative("pages", fn))];
  return Object.fromEntries(pages.map(fn => [
    fn.replace(/\.html$/, ''),
    fileURLToPath(new URL(fn, import.meta.url))
  ]))
};

const input = {
  main:   resolve(__dirname , 'index.html'),
  about:  resolve(__dirname , 'about.html'),
};

export default defineConfig({

  build: {
    rollupOptions: {
      input: getHTMLPages()
      // input: input,
      // input: {
      //   main:   resolve(__dirname , 'index.html'),
      //   about:  resolve(__dirname , 'about.html'),
      // },
    },
  },

  plugins: [

    ViteEjsPlugin(() => {
      return {
        title: 'INSERT TITLE HERE',
        bannerText: 'This banner was poulated by EJS',
        data: JSON.stringify(input),
        datatwo: JSON.stringify(getHTMLPages()),
        mc: undefined,
        // data: '',
        // datatwo: '',
      };
    }),

    // ViteImageOptimizer()
    ViteImageOptimizer({
      jpeg: { quality: 60 },
      jpg: { quality: 60 }
    }),

  ],

});

