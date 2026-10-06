module main

import os

fn grep(pattern string, flags []string, files []string) ![]string {
	line_numbers := '-n' in flags
	file_names := '-l' in flags
	ignore_case := '-i' in flags
	invert := '-v' in flags
	entire_line := '-x' in flags
	multiple_files := files.len > 1

	wanted := if ignore_case { pattern.to_lower() } else { pattern }
	mut result := []string{}
	for file in files {
		lines := os.read_lines(file)!
		for index, line in lines {
			candidate := if ignore_case { line.to_lower() } else { line }
			found := if entire_line { candidate == wanted } else { candidate.contains(wanted) }
			if found == invert {
				continue
			}
			if file_names {
				result << file
				break
			}
			mut output := line
			if line_numbers {
				output = '${index + 1}:${output}'
			}
			if multiple_files {
				output = '${file}:${output}'
			}
			result << output
		}
	}
	return result
}
