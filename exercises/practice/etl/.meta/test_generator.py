from lib import assert_eq, v_inline_array, v_int, v_map


def v_rune(value):
    return f"`{value}`"


def gen_case(case):
    legacy = v_map(case["input"]["legacy"], v_int, lambda v: v_inline_array(v, v_rune))
    return [
        f"legacy := {legacy}",
        f"expected := {v_map(case['expected'], v_rune, v_int)}",
        assert_eq("transform(legacy)", "expected"),
    ]
