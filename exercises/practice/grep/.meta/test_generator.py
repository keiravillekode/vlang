from lib import assert_eq, v_array, v_inline_array, v_string


def gen_case(case):
    pattern = v_string(case["input"]["pattern"])
    flags = v_inline_array(case["input"]["flags"], empty="[]string{}")
    files = v_inline_array(case["input"]["files"])
    expected = v_array(case["expected"], empty="[]string{}")
    return [
        f"files := {files}",
        f"flags := {flags}",
        f"expected := {expected}",
        assert_eq(f"grep({pattern}, flags, files)!", "expected"),
    ]
