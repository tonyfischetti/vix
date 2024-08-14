// js, date and time, get unix time, luxon

const getUnixTime = () => {
  return Math.floor(Date.now()/1000);
};

// or

const { DateTime } = require("luxon");

const getUnixTime2 = () => {
  return DateTime.now().toUnixInteger();
};
