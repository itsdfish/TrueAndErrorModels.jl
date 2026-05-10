module NamedArraysExt

using DocStringExtensions
using NamedArrays
using TrueAndErrorModels

import TrueAndErrorModels: to_table

"""
   $(TYPEDSIGNATURES)

Transforms a vector into a joint response table in which each dimension represents choices in the corresponding block.

# Example

```julia
using NamedArrays
using TrueAndErrorModels

n_options = [2, 2]
n_reps = 2
@make_model TestModel n_options n_reps

labels = get_response_labels(TestModel)
table = to_table(TestModel, labels)
```

```julia
4×4 Named Matrix{String}
1 ╲ 2 │         (1,1)          (2,1)          (1,2)          (2,2)
──────┼───────────────────────────────────────────────────────────
(1,1) │ "(1,1),(1,1)"  "(1,1),(2,1)"  "(1,1),(1,2)"  "(1,1),(2,2)"
(2,1) │ "(2,1),(1,1)"  "(2,1),(2,1)"  "(2,1),(1,2)"  "(2,1),(2,2)"
(1,2) │ "(1,2),(1,1)"  "(1,2),(2,1)"  "(1,2),(1,2)"  "(1,2),(2,2)"
(2,2) │ "(2,2),(1,1)"  "(2,2),(2,1)"  "(2,2),(1,2)"  "(2,2),(2,2)"
```
"""
function to_table(
    model::Type{<:AbstractTrueErrorModel},
    x::Vector;
    labels = get_table_labels(model)
)
    n_reps = get_n_reps(model)
    return NamedArray(
        reshape(x, fill(length(labels), n_reps)...),
        (fill(labels, n_reps)...,),
        Tuple(string.(1:n_reps))
    )
end

end
