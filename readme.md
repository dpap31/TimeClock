# TimeClock

TimeClock is a simple ruby based time tracking script that stores punches and notes in a CSV file. The ruby script serves as a core component of a Alfred Workflow for time tracking. Users can trigger TimeClock using "tc" as an alfred keyword. After the keyword a action ("in", "out", "last", "open") should be provided. Here is a brief description of each action:

* In
The "in" action writes the current military time to a CSV in the "in" column. An optional note can be included as well.
* Out
The "out" action writes the current military time to a CSV in the "out" column. An optional note can be included as well.
* Last
The "last" action displays the last punch made.
* Open
The "open" action displays the CSV spreadsheet.
