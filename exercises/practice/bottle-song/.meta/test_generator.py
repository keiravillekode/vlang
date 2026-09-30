from lib import assert_eq, v_int, v_text
from lib import nested_test_name as test_name  # noqa: F401


def gen_case(case):
    start = v_int(case["input"]["startBottles"])
    take_down = v_int(case["input"]["takeDown"])
    return [
        f"expected := {v_text(case['expected'])}",
        assert_eq(f"recite({start}, {take_down})", "expected"),
    ]
