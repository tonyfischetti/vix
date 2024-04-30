const sgtobject = { year: 1967, month: 5, day: 26 };

new Date(1967, 4, 26)             // local (months are 0-indexed)
new Date(Date.UTC(1967, 4, 26))   // utc
new Date("1967-05-26")            // utc
new Date("1967-05-26T00:00:00Z")  // utc
new Date("1967-05-26T00:00:00")   // local (notice no "Z")
// it's recommended _not_ to create Dates by parsing date strings, though


// or

const { DateTime } = require("luxon");

DateTime.local(1967, 5, 26)                      // in local time
DateTime.utc(1967, 5, 26)                        // in UTC
DateTime.fromObject(sgtobject)                   // in local time
DateTime.fromObject(sgtobject, { zone: 'UTC' })  // in UTC

DateTime.fromSeconds(-82166400)
DateTime.fromJSDate(new Date(Date.UTC(1967, 4, 26)))
DateTime.fromRFC2822("Fri, 26 May 1967 00:00:00 +0000");
DateTime.fromHTTP("Friday, 26-May-67 00:00:00 GMT");
DateTime.fromFormat("May 26, 1967", "LLLL dd, yyyy")

DateTime.fromFormat("01/Dec/2023:00:00:01 -0500", "dd/LLL/yyyy:hh:mm:ss ZZZ")