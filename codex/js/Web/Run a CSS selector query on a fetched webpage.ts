// js, cheerio, CSS selectors, querySelector, web scraping, fetch

import * as cheerio from 'cheerio';


const PORTAL_URL = "https://download.cms.gov/nppes/NPI_Files.html"

const getLink = (html: string) => {
  const $ = cheerio.load(html);
  const shortLink = $("a[id='DDSMTH.ZIP.D']").first().attr('href');
  if (!shortLink) throw new Error("couldn't find short link");
  return `${PORTAL_URL.replace(/^(.+\/).+?$/, "$1")}${shortLink.replace(/^\.\//, '')}`;
};

fetch(PORTAL_URL).
  then(response => response.text()).
  then(getLink).
  then(console.log);

