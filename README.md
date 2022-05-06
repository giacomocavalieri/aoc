# HAOC
Haskell Advent of Code

### Setup of a new year
To auto generate the directory for a given year run `cabal run aoc-cli -- {year}`;
it will automatically generate all the skeleton files for year `{year}` and add a corresponding executable stanza to the `aoc.cabal` file.

### Running a year
After setting up a year with `aoc-cli` you can run a day with `cabal run aoc-{year} -- {day}`;
It will automatically download the input from the aoc website and save it in `<home-directory>/aoc/<year>/<day>.txt`.
In order to do so it needs a file `<home-directory>/aoc/.aoc-cookie` with the aoc website's session cookie value.
