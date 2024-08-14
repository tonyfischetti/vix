// js, date and time, luxon, utc, local time, ISO-8601

/*** UTC ***/

const getYYYYMMDD_UTC = () => {
  return new Date().toISOString().split(/T/)[0];
};

// or

const { DateTime } = require("luxon");

const getYYYYMMDD_UTC2 = () => {
  return DateTime.now().toUTC().toISO().split(/T/)[0];
};

/*** LOCAL TIME ***/

const getYYYYMMDD_local = () => {
  const rn = new Date();
  // this returns the number of minutes offset from UTC
  const offset = rn.getTimezoneOffset();
  rn.setMinutes(rn.getMinutes() - offset);
  return rn.toISOString().split(/T/)[0];
};

// or

const { DateTime } = require("luxon");

const getYYYYMMDD_local2 = () => {
  return DateTime.now().toISO().split(/T/)[0];
};
