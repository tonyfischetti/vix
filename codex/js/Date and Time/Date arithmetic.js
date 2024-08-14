// js, date and time, date arithmetic, luxon, date difference, sgt peppers, revolver, relative dates, date diff

const revolver = new Date(1966, 7, 5);
// Fri Aug 05 1966 00:00:00 GMT-0400 (Eastern Daylight Time)

const sgtpeppers = new Date(1967, 4, 26);
// Fri May 26 1967 00:00:00 GMT-0400 (Eastern Daylight Time)

sgtpeppers-revolver;    // 25401600000

// or

const { DateTime } = require("luxon");

DateTime.fromJSDate(sgtpeppers).diff(DateTime.fromJSDate(revolver))
// Duration { values: {"milliseconds":25401600000} }

DateTime.fromJSDate(sgtpeppers)
  .diff(DateTime.fromJSDate(revolver),
        ['years', 'months', 'days']);
// Duration { values: {"years":0,"months":9,"days":21} }

DateTime.now().minus({ days: 1 });
DateTime.now().plus({ weeks: 1 });
DateTime.now().plus({ days: 1 }).toRelativeCalendar();   // tomorrow
DateTime.now().minus({ weeks: 3 }).toRelativeCalendar(); // last month

// future > past;   // true

const datetimeIsEqualP = (dt1, dt2) => {
  return dt1.getTime() === dt2.getTime();
};
