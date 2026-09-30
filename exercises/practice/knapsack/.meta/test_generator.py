from lib import assert_eq, v_array, v_int, v_struct


def gen_case(case):
    items = case["input"]["items"]
    maximum_weight = v_int(case["input"]["maximumWeight"])
    return [
        f"items := {v_array(items, lambda item: v_struct('Item', item), '[]Item{}')}",
        assert_eq(f"maximum_value({maximum_weight}, items)", v_int(case["expected"])),
    ]
