from lib import assert_eq, v_array, v_map, v_string, v_struct


def v_location(location):
    if location is None:
        return "?WordLocation(none)"
    return v_struct("?WordLocation", location, lambda pair: v_struct("Pair", pair))


def gen_case(case):
    grid = v_array(case["input"]["grid"], v_string)
    words = v_array(case["input"]["wordsToSearchFor"], v_string)
    return [
        f"grid := {grid}",
        f"words_to_search_for := {words}",
        f"expected := {v_map(case['expected'], v_string, v_location)}",
        assert_eq("search(grid, words_to_search_for)", "expected"),
    ]
