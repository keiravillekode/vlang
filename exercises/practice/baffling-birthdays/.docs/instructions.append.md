# Instructions append

## Track specific instructions

Implement three functions:

- `shared_birthday(birthdates []string) bool`
- `random_birthdates(group_size int) []string`
- `estimated_probability_of_shared_birthday(group_size int) f64`

### Birthdates

A birthdate is a string formatted as `YYYY-MM-DD`, with the month and the day padded to two digits, for example `2001-04-09`.

Every birthdate returned by `random_birthdates` must fall between 1901-01-01 and 2099-12-31, in one of the 150 years in that range that is not a leap year, so that 29 February never occurs.

Each of those 150 years must be equally likely, and each of the 365 days of the year must be equally likely.
Note that this makes months unequally likely: a birthday is more likely to fall in January than in April, and the 31st of a month is much rarer than the 3rd.

Draw each birthdate independently, so that the same birthday can occur more than once within a group.
Do not deal birthdates out of a shuffled collection of distinct dates: the tests reject a distribution that is too even just as they reject one that is too uneven.

### Estimating the probability

`estimated_probability_of_shared_birthday` returns a percentage between `0.0` and `100.0`, rather than a fraction between `0.0` and `1.0`.

Estimate it by simulation, using at least 600 randomly generated groups.
The tests allow a tolerance of 0.1 for a group of one person, 8.2765 for ten people, 12.88 for twenty-three people, and 0.83 for seventy people.
At 600 groups a correct solution is expected to fail about once in a billion runs; simulating more groups makes it more reliable still.

### Reserved names

The tests are compiled together with your solution, so do not define anything named `chi_squared`, `tally` or `assert_probability`.
