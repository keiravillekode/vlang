from lib import assert_eq, assert_error, is_error, v_struct


def gen_case(case):
    expected = case["expected"]
    lines = [f"puzzle := {v_struct('PartialInformation', case['input'])}"]
    if is_error(expected):
        lines.append(assert_error("jigsaw_data(puzzle)", case))
    else:
        lines.append(f"expect := {v_struct('FullInformation', expected)}")
        lines.append(assert_eq("jigsaw_data(puzzle)!", "expect"))
    return lines
