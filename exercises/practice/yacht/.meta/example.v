module main

pub enum Category {
	ones
	twos
	threes
	fours
	fives
	sixes
	full_house
	four_of_a_kind
	little_straight
	big_straight
	choice
	yacht
}

fn score_total(dice []int) int {
	mut total := 0
	for die in dice {
		total += die
	}
	return total
}

fn score_numbers(dice []int, number int) int {
	mut total := 0
	for die in dice {
		if die == number {
			total += number
		}
	}
	return total
}

fn score_ones(dice []int) int {
	return score_numbers(dice, 1)
}

fn score_twos(dice []int) int {
	return score_numbers(dice, 2)
}

fn score_threes(dice []int) int {
	return score_numbers(dice, 3)
}

fn score_fours(dice []int) int {
	return score_numbers(dice, 4)
}

fn score_fives(dice []int) int {
	return score_numbers(dice, 5)
}

fn score_sixes(dice []int) int {
	return score_numbers(dice, 6)
}

fn score_full_house(dice []int) int {
	return if dice[0] != dice[4] && ((dice[0] == dice[2] && dice[3] == dice[4])
		|| (dice[0] == dice[1] && dice[2] == dice[4])) {
		score_total(dice)
	} else {
		0
	}
}

fn score_four_of_a_kind(dice []int) int {
	return if dice[0] == dice[3] || dice[1] == dice[4] { 4 * dice[2] } else { 0 }
}

fn score_little_straight(dice []int) int {
	return if dice == [1, 2, 3, 4, 5] { 30 } else { 0 }
}

fn score_big_straight(dice []int) int {
	return if dice == [2, 3, 4, 5, 6] { 30 } else { 0 }
}

fn score_choice(dice []int) int {
	return score_total(dice)
}

fn score_yacht(dice []int) int {
	return if dice[0] == dice[4] { 50 } else { 0 }
}

fn score(dice []int, category Category) int {
	mut d := dice.clone()
	d.sort()

	return match category {
		.ones { score_ones(d) }
		.twos { score_twos(d) }
		.threes { score_threes(d) }
		.fours { score_fours(d) }
		.fives { score_fives(d) }
		.sixes { score_sixes(d) }
		.full_house { score_full_house(d) }
		.four_of_a_kind { score_four_of_a_kind(d) }
		.little_straight { score_little_straight(d) }
		.big_straight { score_big_straight(d) }
		.choice { score_choice(d) }
		.yacht { score_yacht(d) }
	}
}
