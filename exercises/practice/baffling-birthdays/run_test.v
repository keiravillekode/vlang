module main

import math

// chi_squared returns the goodness of fit statistic for the observed counts,
// where bin i is expected to hold a share weights[i] of the total.
fn chi_squared(counts []int, weights []int) f64 {
	mut total_count := 0
	for count in counts {
		total_count += count
	}
	mut total_weight := 0
	for weight in weights {
		total_weight += weight
	}
	mut statistic := 0.0
	for index, count in counts {
		expected := f64(total_count) * f64(weights[index]) / f64(total_weight)
		difference := f64(count) - expected
		statistic += difference * difference / expected
	}
	return statistic
}

// tally_random_birthdates makes 516 calls to random_birthdates(365), checks
// that every birthdate is valid, and returns counts of each of the 129 non leap
// years from 1929 to 2099, of each month, and of each day of the month.
fn tally_random_birthdates() ([]int, []int, []int) {
	month_lengths := [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
	mut years := []int{len: 129}
	mut months := []int{len: 12}
	mut days := []int{len: 31}
	for _ in 0 .. 516 {
		birthdates := random_birthdates(365)
		if birthdates.len != 365 {
			assert false, 'random_birthdates(365) returned ${birthdates.len} birthdates'
		}
		for birthdate in birthdates {
			if birthdate.len != 10 || birthdate[4] != `-` || birthdate[7] != `-` {
				assert false, '${birthdate} is not formatted as YYYY-MM-DD'
			}
			year := birthdate[0..4].int()
			month := birthdate[5..7].int()
			day := birthdate[8..10].int()
			if year < 1929 || year > 2099 {
				assert false, '${birthdate} is not between 1929-01-01 and 2099-12-31'
			}
			if year % 4 == 0 {
				assert false, '${birthdate} falls in the leap year ${year}'
			}
			if month < 1 || month > 12 {
				assert false, '${birthdate} does not have a month between 01 and 12'
			}
			if day < 1 || day > month_lengths[month - 1] {
				assert false, '${birthdate} does not have a day within its month'
			}
			elapsed := year - 1929
			years[3 * (elapsed / 4) + elapsed % 4]++
			months[month - 1]++
			days[day - 1]++
		}
	}
	return years, months, days
}

fn assert_probability(actual f64, expected f64, tolerance f64) {
	assert math.abs(actual - expected) <= tolerance, 'expected ${expected} plus or minus ${tolerance}, but got ${actual}'
}

fn test_one_birthdate() {
	assert shared_birthday(['2000-01-01']) == false
}

fn test_two_birthdates_with_same_year_month_and_day() {
	assert shared_birthday(['2000-01-01', '2000-01-01']) == true
}

fn test_two_birthdates_with_same_year_and_month_but_different_day() {
	assert shared_birthday(['2012-05-09', '2012-05-17']) == false
}

fn test_two_birthdates_with_same_month_and_day_but_different_year() {
	assert shared_birthday(['1999-10-23', '1988-10-23']) == true
}

fn test_two_birthdates_with_same_year_but_different_month_and_day() {
	assert shared_birthday(['2007-12-19', '2007-04-27']) == false
}

fn test_two_birthdates_with_different_year_month_and_day() {
	assert shared_birthday(['1997-08-04', '1963-11-23']) == false
}

fn test_multiple_birthdates_without_shared_birthday() {
	assert shared_birthday(['1966-07-29', '1977-02-12', '2001-12-25', '1980-11-10']) == false
}

fn test_multiple_birthdates_with_one_shared_birthday() {
	assert shared_birthday(['1966-07-29', '1977-02-12', '2001-07-29', '1980-11-10']) == true
}

fn test_multiple_birthdates_with_more_than_one_shared_birthday() {
	assert shared_birthday(['1966-07-29', '1977-02-12', '2001-12-25', '1980-07-29', '2019-02-12']) == true
}

fn test_generate_requested_number_of_birthdates() {
	for group_size in 1 .. 101 {
		birthdates := random_birthdates(group_size)
		assert birthdates.len == group_size, 'random_birthdates(${group_size}) returned ${birthdates.len} birthdates'
	}
}

// The chi squared bounds below reject a correct solution with probability
// 0.000001 at each tail. Falling below the lower bound means the birthdates
// are spread too evenly to have been drawn at random.
fn test_years_are_not_leap_years() {
	years, _, _ := tally_random_birthdates()
	statistic := chi_squared(years, []int{len: 129, init: 1})
	assert statistic <= 218.91, 'the 129 non leap years from 1929 to 2099 are not equally likely (chi squared ${statistic}); counts were ${years}'
	assert statistic >= 65.75, 'years are spread far too evenly to be random (chi squared ${statistic}); each birthdate must be drawn independently, rather than dealt out from a shuffled set of dates'
}

fn test_months_are_random() {
	_, months, _ := tally_random_birthdates()
	statistic := chi_squared(months, [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31])
	assert statistic <= 48.87, 'months are not chosen in proportion to the number of days they contain (chi squared ${statistic}); counts were ${months}'
	assert statistic >= 0.47, 'months are spread far too evenly to be random (chi squared ${statistic}); each birthdate must be drawn independently, rather than dealt out from a shuffled set of dates'
}

fn test_days_are_random() {
	_, _, days := tally_random_birthdates()
	// The 29th and 30th occur in eleven months, and the 31st in seven.
	mut weights := []int{len: 31, init: 12}
	weights[28] = 11
	weights[29] = 11
	weights[30] = 7
	statistic := chi_squared(days, weights)
	assert statistic <= 82.05, 'days are not chosen in proportion to the number of months that contain them (chi squared ${statistic}); counts were ${days}'
	assert statistic >= 6.20, 'days are spread far too evenly to be random (chi squared ${statistic}); each birthdate must be drawn independently, rather than dealt out from a shuffled set of dates'
}

fn test_for_one_person() {
	assert_probability(estimated_probability_of_shared_birthday(1), 0.0, 0.1)
}

fn test_among_ten_people() {
	assert_probability(estimated_probability_of_shared_birthday(10), 11.694818, 8.2765)
}

fn test_among_twenty_three_people() {
	assert_probability(estimated_probability_of_shared_birthday(23), 50.729723, 12.88)
}

fn test_among_seventy_people() {
	assert_probability(estimated_probability_of_shared_birthday(70), 99.915958, 0.83)
}
