module main

fn moves(discs int, poles int) int {
    mut table := [][]int{len: discs + 1, init: []int{len: poles + 1}}

    if discs == 1 {
        return 1
    }

    for p in 2 .. (poles + 1) {
        table[1][p] = 1
    }

    assert poles >= 3

    for d in 2 .. (discs + 1) {
        table[d][3] = 2 * table[d - 1][3] + table[1][2]

        for p in 4 .. (poles + 1) {
            // Suppose we move to a spare pole all but the largest
            mut best := 2 * table[d - 1][p] + table[1][p - 1]

            for i in 1 .. (d - 1) {
                // move the i smallest discs to a spare pole
                first := table[i][p]

                // move the remaining discs to the destination
                second := table[d - i][p - 1]

                // move the i smallest discs to the destination
                third := first

                total := first + second + third
                if total < best {
                    best = total
                }
            }

            table[d][p] = best
        }
    }

    return table[discs][poles]
}
