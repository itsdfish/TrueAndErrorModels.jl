module NamedArraysExt

using TrueAndErrorModels
using NamedArrays

import TrueAndErrorModels: to_table

"""
    to_table(x::Vector{<:Real})

Converts a vector of response frequencies or catetory probabilities to a 4X4 table in which the columns
correspond to joint responses on the first replicate and the rows correspond to the joint responses on the second replicate.
Labels `S` correspond to safe option and `R` corresponds to risky option. The position of elements corresponds to choice set. 

# Arguments 

`x::Vector{<:Real}`: a vector of response frequencies or catetory probabilities with the following elements:

1.  RR,RR
2.  RR,RS
3.  RR,SR
4.  RR,SS
5.  RS,RR
6.  RS,RS
7.  RS,SR
8.  RS,SS
9.  SR,RR
10. SR,RS
11. SR,SR
12. SR,SS
13. SS,RR
14. SS,RS
15. SS,SR
16. SS,SS
"""
function to_table(x::Vector{<:Real})
    return NamedArray(
        reshape(x, 4, 4),
        (["RR", "RS", "SR", "SS"], ["RR", "RS", "SR", "SS"]),
        ("2", "1")
    )
end

end
