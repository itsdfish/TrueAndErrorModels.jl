module TuringExt

using TrueAndErrorModels
using Turing
import TrueAndErrorModels: tet1_model
import TrueAndErrorModels: tet2_model
import TrueAndErrorModels: tet4_model
import TrueAndErrorModels: eut1_model
import TrueAndErrorModels: eut2_model
import TrueAndErrorModels: eut4_model

import DynamicPPL: reconstruct
import DynamicPPL: vectorize
import TrueAndErrorModels: predict_distribution
using Turing: @model
using Turing: @submodel

"""
    tet1_model(data::Vector{<:Integer})

A True and Error Theory model with one error parameter: ϵₛ₁ = ϵₛ₂ = ϵᵣ₁ = ϵᵣ₂

# Arguments

- `data::Vector{<:Integer}`: a vector of response frequencies in which elements corrspond to the following response patterns:

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

where S corresponds to choosing the safe option, R corresponds to choosing the risky option, each pair (XX)
is the joint choice for choice sets 1 and two, respectively for a given replication. The first pair corresponds to 
the first replication, and the second pair corresponds to the second replication. For example, SR,RS indicates the selection 
of the safe option for choice set 1 followed by the risky option for choice set 2 during the first replication, and the 
reversal of choices for the second replication. 
"""
@model function tet1_model(data::Vector{<:Integer})
    p ~ Dirichlet(fill(1, 4))
    ϵ ~ Uniform(0, 0.5)
    ϵ′ = fill(ϵ, 4)
    data ~ TrueErrorModel(; p, ϵ = ϵ′)
    return (; p, ϵ = ϵ′)
end

"""
    tet2_model(data::Vector{<:Integer})

A True and Error Theory model with two error parameters: ϵₛ₁ = ϵᵣ₁, ϵₛ₂ = ϵᵣ₂

# Arguments

- `data::Vector{<:Integer}`: a vector of response frequencies in which elements corrspond to the following response patterns:

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

where S corresponds to choosing the safe option, R corresponds to choosing the risky option, each pair (XX)
is the joint choice for choice sets 1 and two, respectively for a given replication. The first pair corresponds to 
the first replication, and the second pair corresponds to the second replication. For example, SR,RS indicates the selection 
of the safe option for choice set 1 followed by the risky option for choice set 2 during the first replication, and the 
reversal of choices for the second replication. 
"""
@model function tet2_model(data::Vector{<:Integer})
    p ~ Dirichlet(fill(1, 4))
    ϵ ~ filldist(Uniform(0, 0.5), 2)
    ϵ′ = [ϵ[1], ϵ[2], ϵ[1], ϵ[2]]
    # ϵₛ₁, ϵₛ₂, ϵᵣ₁, ϵᵣ₂
    data ~ TrueErrorModel(; p, ϵ = ϵ′)
    return (; p, ϵ = ϵ′)
end

"""
    tet4_model(data::Vector{<:Integer})

A True and Error Theory model with four error parameters: ϵₛ₁, ϵᵣ₁, ϵₛ₂, ϵᵣ₂

# Arguments

- `data::Vector{<:Integer}::Vector{<:Integer}`: a vector of response frequencies in which elements corrspond to the following response patterns:

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

where S corresponds to choosing the safe option, R corresponds to choosing the risky option, each pair (XX)
is the joint choice for choice sets 1 and two, respectively for a given replication. The first pair corresponds to 
the first replication, and the second pair corresponds to the second replication. For example, SR,RS indicates the selection 
of the safe option for choice set 1 followed by the risky option for choice set 2 during the first replication, and the 
reversal of choices for the second replication. 
"""
@model function tet4_model(data::Vector{<:Integer})
    p ~ Dirichlet(fill(1, 4))
    ϵ ~ filldist(Uniform(0, 0.5), 4)
    data ~ TrueErrorModel(p, ϵ)
    return (; p, ϵ)
end

"""
    eut1_model(data::Vector{<:Integer})


An expected utility theory model with one error parameter: ϵₛ₁ = ϵₛ₂ = ϵᵣ₁ = ϵᵣ₂. The preference states of all 
expected utility theory models are subject to the constraint that pᵣₛ = pₛᵣ = 0.

# Arguments

- `data::Vector{<:Integer}`: a vector of response frequencies in which elements corrspond to the following response patterns:

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

where S corresponds to choosing the safe option, R corresponds to choosing the risky option, each pair (XX)
is the joint choice for choice sets 1 and two, respectively for a given replication. The first pair corresponds to 
the first replication, and the second pair corresponds to the second replication. For example, SR,RS indicates the selection 
of the safe option for choice set 1 followed by the risky option for choice set 2 during the first replication, and the 
reversal of choices for the second replication. 
"""
@model function eut1_model(data::Vector{<:Integer})
    # [pᵣᵣ, pᵣₛ, pₛᵣ, pₛₛ]
    p ~ Dirichlet(fill(1, 2))
    ϵ ~ Uniform(0, 0.5)
    p′ = [p[1], 0, 0, p[2]]
    ϵ′ = fill(ϵ, 4)
    data ~ TrueErrorModel(; p = p′, ϵ = ϵ′)
    return (; p = p′, ϵ = ϵ′)
end

"""
    eut2_model(data::Vector{<:Integer})

An expected utility theory model with two error parameters: ϵₛ₁ = ϵᵣ₁, ϵₛ₂ = ϵᵣ₂. The preference states of all 
expected utility theory models are subject to the constraint that pᵣₛ = pₛᵣ = 0.

# Arguments

- `data::Vector{<:Integer}`: a vector of response frequencies in which elements corrspond to the following response patterns:

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

where S corresponds to choosing the safe option, R corresponds to choosing the risky option, each pair (XX)
is the joint choice for choice sets 1 and two, respectively for a given replication. The first pair corresponds to 
the first replication, and the second pair corresponds to the second replication. For example, SR,RS indicates the selection 
of the safe option for choice set 1 followed by the risky option for choice set 2 during the first replication, and the 
reversal of choices for the second replication. 
"""
@model function eut2_model(data::Vector{<:Integer})
    # [pᵣᵣ, pᵣₛ, pₛᵣ, pₛₛ]
    p ~ Dirichlet(fill(1, 2))
    ϵ ~ filldist(Uniform(0, 0.5), 2)
    p′ = [p[1], 0, 0, p[2]]
    ϵ′ = [ϵ[1], ϵ[2], ϵ[1], ϵ[2]]
    # ϵₛ₁, ϵₛ₂, ϵᵣ₁, ϵᵣ₂
    data ~ TrueErrorModel(; p = p′, ϵ = ϵ′)
    return (; p = p′, ϵ = ϵ′)
end

"""
    eut4_model(data::Vector{<:Integer})

An expected utility theory model with four error parameters: ϵₛ₁, ϵᵣ₁, ϵₛ₂, ϵᵣ₂. The preference states of all 
expected utility theory models are subject to the constraint that pᵣₛ = pₛᵣ = 0.

# Arguments

- `data::Vector{<:Integer}`: a vector of response frequencies in which elements corrspond to the following response patterns:

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

where S corresponds to choosing the safe option, R corresponds to choosing the risky option, each pair (XX)
is the joint choice for choice sets 1 and two, respectively for a given replication. The first pair corresponds to 
the first replication, and the second pair corresponds to the second replication. For example, SR,RS indicates the selection 
of the safe option for choice set 1 followed by the risky option for choice set 2 during the first replication, and the 
reversal of choices for the second replication. 
"""
@model function eut4_model(data::Vector{<:Integer})
    # [pᵣᵣ, pᵣₛ, pₛᵣ, pₛₛ]
    p ~ Dirichlet(fill(1, 2))
    ϵ ~ filldist(Uniform(0, 0.5), 4)
    p′ = [p[1], 0, 0, p[2]]
    data ~ TrueErrorModel(; p = p′, ϵ)
    return (; p = p′, ϵ)
end

"""
    predict_distribution(dist, args...; model, func, n_samples, kwargs...)

Generates a predictive distribution for a statistic defined by `func`.

# Arguments 

- `dist::Distribution`: a distribution type which accepts parameters as keyword arguments 
- `args...` optional positional arguments passed to function `func`

# Keywords

- `model`: a Turing model which returns a `NamedTuple` of parameters 
- `func`: a function which computes a statistic of simulated data. The function signature is `func(data, args...; kwargs...)`
- `n_samples`: the number of observations to sample from `dist`
- `kwargs...`: optional keyword arguments passed to `func`
"""
@model function predict_distribution(
    dist,
    args...;
    model,
    func = (x, args...; kwargs...) -> x,
    n_samples,
    kwargs...
)
    @submodel parms = model
    sim_data = rand(dist(; parms...), n_samples)
    return func(sim_data, args...; kwargs...)
end

#vectorize(d::SSM2D, r::NamedTuple) = [r...]
reconstruct(d::AbstractTrueErrorModel, data::Vector{<:Integer}) = deepcopy(data)

end
