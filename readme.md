# TimeClock

TimeClock is a simple ruby based time tracking script that stores punches and associated notes in a CSV file. The ruby script serves as a core component of a custom Alfred Workflow (https://www.alfredapp.com/) for time tracking. Users can trigger TimeClock using an alfred keyword and an action ("in", "out", "last", "open"). Here is a brief description of the supported actions:

**In**
* The "in" action writes the current military time to a CSV in the "in" column. An optional note can be included as well.

**Out**
* The "out" action writes the current military time to a CSV in the "out" column. An optional note can be included as well.

**Last**
* The "last" action displays the last punch made.

**Open**
* The "open" action displays the CSV spreadsheet.
