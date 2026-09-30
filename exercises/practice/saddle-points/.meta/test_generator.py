from lib import assert_eq, v_array, v_inline_array, v_struct


def v_row(row):
    return v_inline_array(row, empty="[]int{}")


def v_point(point):
    return v_struct("Point", point)


def gen_case(case):
    points = sorted(case["expected"], key=lambda p: (p["row"], p["column"]))
    return [
        f"matrix := {v_array(case['input']['matrix'], v_row)}",
        f"expected := {v_array(points, v_point, '[]Point{}')}",
        assert_eq("saddle_points(matrix)", "expected"),
    ]
