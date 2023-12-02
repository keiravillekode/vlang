module main

type HighScores = []int

// build a new HighScores
pub fn HighScores.new(scores []int) HighScores {
	return scores.clone()
}

pub fn (mut high_scores HighScores) scores() []int {
	return high_scores
}

pub fn (mut high_scores HighScores) latest() int {
	return high_scores.last()
}

pub fn (mut high_scores HighScores) personal_best() int {
	mut result := 0
	for score in high_scores {
		if result < score {
			result = score
		}
	}
	return result
}

pub fn (mut high_scores HighScores) personal_top_three() []int {
	mut sorted := []int{ cap: high_scores.len }
	for score in high_scores {
		sorted << score
	}
	sorted.sort()

	if sorted.len > 3 {
		sorted.drop(sorted.len - 3)
	}
	return sorted.reverse()
}
