# TimeClock

## Overview
TimeClock is a simple ruby based time tracking script that stores punches and associated notes in a CSV file. The ruby script serves as a core component of a custom Alfred Workflow (https://www.alfredapp.com/) for time tracking. Users can trigger TimeClock using an alfred keyword and an action ("in", "out", "last", "open"). Below you will find a brief description of the supported actions.

## Actions

**In**
The "in" action writes the current time to a CSV in the "in" column. An optional note can be included as well.

**Out**
The "out" action writes the current time to a CSV in the "out" column. An optional note can be included as well.

**Last**
The "last" action displays the last punch made.

**Open**
The "open" action displays the CSV spreadsheet.

## Configuration

1. Download and install Alfred 2.0 (https://www.alfredapp.com/). The "powerpack" is required to use TimeClock.
2. Clone this repo.
3. Double click the TimeClock.alfredworkflow to install.
4. To use, open your alfred prompt and type keyword "tc" and a supported action.


