from lib import assert_eq, v_map, v_string


def gen_case(case):
    sentence = v_string(case["input"]["sentence"])
    return [
        f"expected := {v_map(case['expected'], v_string)}",
        assert_eq(f"count_words({sentence})", "expected"),
    ]
