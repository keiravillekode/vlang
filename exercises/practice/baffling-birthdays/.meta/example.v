module main

import rand

const days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

const simulations = 10000

fn shared_birthday(birthdates []string) bool {
	mut birthdays := map[string]bool{}
	for birthdate in birthdates {
		birthday := birthdate[5..]
		if birthday in birthdays {
			return true
		}
		birthdays[birthday] = true
	}
	return false
}

// random_birthdate picks one of the 129 non leap years between 1929 and 2099,
// then one of that year's 365 days, so every birthday is equally likely.
fn random_birthdate() string {
	// Non leap years come in runs of three, so integer division by three
	// spreads 0 .. 128 evenly over 1929, 1930, 1931, 1933, 1934, ... 2099.
	index := rand.intn(129) or { 0 }
	year := 1929 + 4 * (index / 3) + index % 3

	mut remaining := rand.intn(365) or { 0 }
	mut month := 1
	for remaining >= days_in_month[month - 1] {
		remaining -= days_in_month[month - 1]
		month++
	}
	day := remaining + 1

	return '${year}-${month:02}-${day:02}'
}

fn random_birthdates(group_size int) []string {
	mut birthdates := []string{cap: group_size}
	for _ in 0 .. group_size {
		birthdates << random_birthdate()
	}
	return birthdates
}

fn estimated_probability_of_shared_birthday(group_size int) f64 {
	mut matches := 0
	for _ in 0 .. simulations {
		if shared_birthday(random_birthdates(group_size)) {
			matches++
		}
	}
	return 100.0 * f64(matches) / f64(simulations)
}
