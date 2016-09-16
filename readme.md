# TimeClock

## Overview
TimeClock is a time tracking script that stores punches and associated notes in a CSV file. Users can trigger TimeClock using an alfred keyword and an action ("in", "out", "last", "open", "divider"). Below you will find a brief description of the supported actions.

![timeclock-intro](https://cloud.githubusercontent.com/assets/4949247/18571289/01b89410-7b66-11e6-928c-53da25ed5e4f.gif)

## Actions

**In** - The "in" action writes the current time to a CSV in the "in" column. An optional note can be included as well.

**Out** - The "out" action writes the current time to a CSV in the "out" column. An optional note can be included as well.

**Last** - The "last" action displays the last punch made.

**Divider** - The "divider" action adds a divider to the CSV to help you separate time periods.

**Open** - The "open" action displays the CSV spreadsheet.

## Configuration

1. Download and install Alfred (https://www.alfredapp.com/). The "powerpack" is required to use TimeClock.
2. Clone this repo.
3. Double click the TimeClock.alfredworkflow to install.
4. To use, open your alfred prompt and type keyword "tc" and a supported action.


