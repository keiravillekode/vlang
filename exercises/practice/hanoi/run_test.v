module main

fn test_one_two() {
	assert moves(1, 2) == 1
}

fn test_nine_three() {
	assert moves(9, 3) == 511
}

fn test_nine_four() {
	assert moves(9, 4) == 41
}

fn test_fifteen_four() {
	assert moves(15, 4) == 129
}

fn test_nine_five() {
	assert moves(9, 5) == 27
}

fn test_twenty_five() {
	assert moves(20, 5) == 111
}

fn test_nine_six() {
	assert moves(9, 6) == 25
}

fn test_thirty_six() {
	assert moves(30, 6) == 169
}

fn test_nine_seven() {
	assert moves(9, 7) == 23
}

fn test_thirty_seven() {
	assert moves(30, 7) == 143
}

fn test_nine_eight() {
	assert moves(9, 8) == 21
}

fn test_thirty_eight() {
	assert moves(30, 8) == 113
}

fn test_one_nine() {
	assert moves(1, 9) == 1
}

fn test_two_nine() {
	assert moves(2, 9) == 3
}

fn test_nine_nine() {
	assert moves(9, 9) == 19
}

fn test_thirty_nine() {
	assert moves(30, 9) == 103
}
