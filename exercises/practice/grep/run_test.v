module main

fn test_one_file_one_match_no_flags() {
	files := ['iliad.txt']
	flags := []string{}
	expected := [
		'Of Atreus, Agamemnon, King of men.',
	]
	assert grep('Agamemnon', flags, files)! == expected
}

fn test_one_file_one_match_print_line_numbers_flag() {
	files := ['paradise-lost.txt']
	flags := ['-n']
	expected := [
		'2:Of that Forbidden Tree, whose mortal tast',
	]
	assert grep('Forbidden', flags, files)! == expected
}

fn test_one_file_one_match_case_insensitive_flag() {
	files := ['paradise-lost.txt']
	flags := ['-i']
	expected := [
		'Of that Forbidden Tree, whose mortal tast',
	]
	assert grep('FORBIDDEN', flags, files)! == expected
}

fn test_one_file_one_match_print_file_names_flag() {
	files := ['paradise-lost.txt']
	flags := ['-l']
	expected := [
		'paradise-lost.txt',
	]
	assert grep('Forbidden', flags, files)! == expected
}

fn test_one_file_one_match_match_entire_lines_flag() {
	files := ['paradise-lost.txt']
	flags := ['-x']
	expected := [
		'With loss of Eden, till one greater Man',
	]
	assert grep('With loss of Eden, till one greater Man', flags, files)! == expected
}

fn test_one_file_one_match_multiple_flags() {
	files := ['iliad.txt']
	flags := ['-n', '-i', '-x']
	expected := [
		'9:Of Atreus, Agamemnon, King of men.',
	]
	assert grep('OF ATREUS, Agamemnon, KIng of MEN.', flags, files)! == expected
}

fn test_one_file_several_matches_no_flags() {
	files := ['midsummer-night.txt']
	flags := []string{}
	expected := [
		'Nor how it may concern my modesty,',
		'But I beseech your grace that I may know',
		'The worst that may befall me in this case,',
	]
	assert grep('may', flags, files)! == expected
}

fn test_one_file_several_matches_print_line_numbers_flag() {
	files := ['midsummer-night.txt']
	flags := ['-n']
	expected := [
		'3:Nor how it may concern my modesty,',
		'5:But I beseech your grace that I may know',
		'6:The worst that may befall me in this case,',
	]
	assert grep('may', flags, files)! == expected
}

fn test_one_file_several_matches_match_entire_lines_flag() {
	files := ['midsummer-night.txt']
	flags := ['-x']
	expected := []string{}
	assert grep('may', flags, files)! == expected
}

fn test_one_file_several_matches_case_insensitive_flag() {
	files := ['iliad.txt']
	flags := ['-i']
	expected := [
		"Achilles sing, O Goddess! Peleus' son;",
		'The noble Chief Achilles from the son',
	]
	assert grep('ACHILLES', flags, files)! == expected
}

fn test_one_file_several_matches_inverted_flag() {
	files := ['paradise-lost.txt']
	flags := ['-v']
	expected := [
		'Brought Death into the World, and all our woe,',
		'With loss of Eden, till one greater Man',
		'Restore us, and regain the blissful Seat,',
		"Sing Heav'nly Muse, that on the secret top",
		'That Shepherd, who first taught the chosen Seed',
	]
	assert grep('Of', flags, files)! == expected
}

fn test_one_file_no_matches_various_flags() {
	files := ['iliad.txt']
	flags := ['-n', '-l', '-x', '-i']
	expected := []string{}
	assert grep('Gandalf', flags, files)! == expected
}

fn test_one_file_one_match_file_flag_takes_precedence_over_line_flag() {
	files := ['iliad.txt']
	flags := ['-n', '-l']
	expected := [
		'iliad.txt',
	]
	assert grep('ten', flags, files)! == expected
}

fn test_one_file_several_matches_inverted_and_match_entire_lines_flags() {
	files := ['iliad.txt']
	flags := ['-x', '-v']
	expected := [
		"Achilles sing, O Goddess! Peleus' son;",
		'His wrath pernicious, who ten thousand woes',
		"Caused to Achaia's host, sent many a soul",
		'And Heroes gave (so stood the will of Jove)',
		'To dogs and to all ravening fowls a prey,',
		'When fierce dispute had separated once',
		'The noble Chief Achilles from the son',
		'Of Atreus, Agamemnon, King of men.',
	]
	assert grep('Illustrious into Ades premature,', flags, files)! == expected
}

fn test_multiple_files_one_match_no_flags() {
	files := ['iliad.txt', 'midsummer-night.txt', 'paradise-lost.txt']
	flags := []string{}
	expected := [
		'iliad.txt:Of Atreus, Agamemnon, King of men.',
	]
	assert grep('Agamemnon', flags, files)! == expected
}

fn test_multiple_files_several_matches_no_flags() {
	files := ['iliad.txt', 'midsummer-night.txt', 'paradise-lost.txt']
	flags := []string{}
	expected := [
		'midsummer-night.txt:Nor how it may concern my modesty,',
		'midsummer-night.txt:But I beseech your grace that I may know',
		'midsummer-night.txt:The worst that may befall me in this case,',
	]
	assert grep('may', flags, files)! == expected
}

fn test_multiple_files_several_matches_print_line_numbers_flag() {
	files := ['iliad.txt', 'midsummer-night.txt', 'paradise-lost.txt']
	flags := ['-n']
	expected := [
		'midsummer-night.txt:5:But I beseech your grace that I may know',
		'midsummer-night.txt:6:The worst that may befall me in this case,',
		'paradise-lost.txt:2:Of that Forbidden Tree, whose mortal tast',
		"paradise-lost.txt:6:Sing Heav'nly Muse, that on the secret top",
	]
	assert grep('that', flags, files)! == expected
}

fn test_multiple_files_one_match_print_file_names_flag() {
	files := ['iliad.txt', 'midsummer-night.txt', 'paradise-lost.txt']
	flags := ['-l']
	expected := [
		'iliad.txt',
		'paradise-lost.txt',
	]
	assert grep('who', flags, files)! == expected
}

fn test_multiple_files_several_matches_case_insensitive_flag() {
	files := ['iliad.txt', 'midsummer-night.txt', 'paradise-lost.txt']
	flags := ['-i']
	expected := [
		"iliad.txt:Caused to Achaia's host, sent many a soul",
		'iliad.txt:Illustrious into Ades premature,',
		'iliad.txt:And Heroes gave (so stood the will of Jove)',
		'iliad.txt:To dogs and to all ravening fowls a prey,',
		'midsummer-night.txt:I do entreat your grace to pardon me.',
		'midsummer-night.txt:In such a presence here to plead my thoughts;',
		'midsummer-night.txt:If I refuse to wed Demetrius.',
		'paradise-lost.txt:Brought Death into the World, and all our woe,',
		'paradise-lost.txt:Restore us, and regain the blissful Seat,',
		"paradise-lost.txt:Sing Heav'nly Muse, that on the secret top",
	]
	assert grep('TO', flags, files)! == expected
}

fn test_multiple_files_several_matches_inverted_flag() {
	files := ['iliad.txt', 'midsummer-night.txt', 'paradise-lost.txt']
	flags := ['-v']
	expected := [
		"iliad.txt:Achilles sing, O Goddess! Peleus' son;",
		'iliad.txt:The noble Chief Achilles from the son',
		'midsummer-night.txt:If I refuse to wed Demetrius.',
	]
	assert grep('a', flags, files)! == expected
}

fn test_multiple_files_one_match_match_entire_lines_flag() {
	files := ['iliad.txt', 'midsummer-night.txt', 'paradise-lost.txt']
	flags := ['-x']
	expected := [
		'midsummer-night.txt:But I beseech your grace that I may know',
	]
	assert grep('But I beseech your grace that I may know', flags, files)! == expected
}

fn test_multiple_files_one_match_multiple_flags() {
	files := ['iliad.txt', 'midsummer-night.txt', 'paradise-lost.txt']
	flags := ['-n', '-i', '-x']
	expected := [
		'paradise-lost.txt:4:With loss of Eden, till one greater Man',
	]
	assert grep('WITH LOSS OF EDEN, TILL ONE GREATER MAN', flags, files)! == expected
}

fn test_multiple_files_no_matches_various_flags() {
	files := ['iliad.txt', 'midsummer-night.txt', 'paradise-lost.txt']
	flags := ['-n', '-l', '-x', '-i']
	expected := []string{}
	assert grep('Frodo', flags, files)! == expected
}

fn test_multiple_files_several_matches_file_flag_takes_precedence_over_line_number_flag() {
	files := ['iliad.txt', 'midsummer-night.txt', 'paradise-lost.txt']
	flags := ['-n', '-l']
	expected := [
		'iliad.txt',
		'paradise-lost.txt',
	]
	assert grep('who', flags, files)! == expected
}

fn test_multiple_files_several_matches_inverted_and_match_entire_lines_flags() {
	files := ['iliad.txt', 'midsummer-night.txt', 'paradise-lost.txt']
	flags := ['-x', '-v']
	expected := [
		"iliad.txt:Achilles sing, O Goddess! Peleus' son;",
		'iliad.txt:His wrath pernicious, who ten thousand woes',
		"iliad.txt:Caused to Achaia's host, sent many a soul",
		'iliad.txt:And Heroes gave (so stood the will of Jove)',
		'iliad.txt:To dogs and to all ravening fowls a prey,',
		'iliad.txt:When fierce dispute had separated once',
		'iliad.txt:The noble Chief Achilles from the son',
		'iliad.txt:Of Atreus, Agamemnon, King of men.',
		'midsummer-night.txt:I do entreat your grace to pardon me.',
		'midsummer-night.txt:I know not by what power I am made bold,',
		'midsummer-night.txt:Nor how it may concern my modesty,',
		'midsummer-night.txt:In such a presence here to plead my thoughts;',
		'midsummer-night.txt:But I beseech your grace that I may know',
		'midsummer-night.txt:The worst that may befall me in this case,',
		'midsummer-night.txt:If I refuse to wed Demetrius.',
		'paradise-lost.txt:Of Mans First Disobedience, and the Fruit',
		'paradise-lost.txt:Of that Forbidden Tree, whose mortal tast',
		'paradise-lost.txt:Brought Death into the World, and all our woe,',
		'paradise-lost.txt:With loss of Eden, till one greater Man',
		'paradise-lost.txt:Restore us, and regain the blissful Seat,',
		"paradise-lost.txt:Sing Heav'nly Muse, that on the secret top",
		'paradise-lost.txt:Of Oreb, or of Sinai, didst inspire',
		'paradise-lost.txt:That Shepherd, who first taught the chosen Seed',
	]
	assert grep('Illustrious into Ades premature,', flags, files)! == expected
}
