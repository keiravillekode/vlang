module main

import arrays

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
	return arrays.max(high_scores) or { 0 }
//	mut sorted := (*high_scores).clone()
	//sorted.sort()

	//return sorted.last()
}

pub fn (mut high_scores HighScores) personal_top_three() []int {
	mut sorted := [1] // (*high_scores).clone()
	sorted.sort()

	if sorted.len > 3 {
		sorted.drop(sorted.len - 3)
	}
	return sorted.reverse()
}
