from lib import assert_eq, assert_error, is_error, v_int, v_struct, v_value


def v_field(value):
    return "none" if value is None else v_value(value)


def gen_case(case):
    prop = case["property"]
    expected = case["expected"]
    call = f"{prop}({v_int(case['input']['min'])}, {v_int(case['input']['max'])})"
    if is_error(expected):
        return assert_error(call, case, f"if min more than max, {prop}")
    return [
        f"expected := {v_struct('Palindrome', expected, v_field)}",
        assert_eq(f"{call}!", "expected"),
    ]
