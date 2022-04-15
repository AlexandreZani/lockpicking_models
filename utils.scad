// Computes the number of fragments for a circle of radius r.
// For all r' > r, fragments_num(r') >= fragments_num(r).
// For all values, fragments_num > 3.
function fragments_num(r, fn, fs, fa) =
    let (
        fa_num = ceil(360 / fa),
        fs_num = ceil(r * 2 * PI / fs)
    )
    (fn > 0) ? max(fn, 3)
             : max(min(fa_num, fs_num), 5);

// Finds the radius to specify for a circle that has a minimum radius of r.
function find_outer_radius(r, fn=$fn, fs=$fs, fa=$fa) =
    let (
        fragments = fragments_num(r, fn, fs, fa),
        // fragments > 3 => cos(360 / fragments / 2) <= 1
        // => candidate_or >= r
        candidate_or = r / cos(360 / fragments / 2),
        // candidate_or >= r => candidate_fragments >= fragments
        candidate_fragments = fragments_num(candidate_or, fn, fs, fa),
        // candidate_fragments >= fragments => candidate_ir >= r
        candidate_ir = candidate_or * cos(360 / candidate_fragments / 2)
    )
    (candidate_ir >= r) ? candidate_or
    : assert(candidate_ir >= r);