"""
    compute_probs(dist::TrueErrorModel{T})

Computes the joint probability for all 16 response categories
    
# Arguments

- `dist::TrueErrorModel{T}`: a distribution object for a True and Error Model for two choices sets, each containing
a risky option R and a safe option S.

# Output 

- `θ::Vector{T}`: vector of joint response probabilities with the following elements:

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
function compute_probs(dist::TrueErrorModel{T}) where {T}
    (; p, ϵ) = dist
    pᵣᵣ, pᵣₛ, pₛᵣ, pₛₛ = p
    ϵᵣₛ₁, ϵᵣₛ₂, ϵₛᵣ₁, ϵₛᵣ₂ = ϵ
    θ = zeros(T, 16)

    # RR,RR
    θ[1] =
        pᵣᵣ * (1 - ϵᵣₛ₁) * (1 - ϵᵣₛ₂) * (1 - ϵᵣₛ₁) * (1 - ϵᵣₛ₂) +
        pᵣₛ * (1 - ϵᵣₛ₁) * ϵₛᵣ₂ * (1 - ϵᵣₛ₁) * ϵₛᵣ₂ +
        pₛᵣ * ϵₛᵣ₁ * (1 - ϵᵣₛ₂) * ϵₛᵣ₁ * (1 - ϵᵣₛ₂) +
        pₛₛ * ϵₛᵣ₁ * ϵₛᵣ₂ * ϵₛᵣ₁ * ϵₛᵣ₂
    # RR,RS
    θ[2] =
        pᵣᵣ * (1 - ϵᵣₛ₁) * (1 - ϵᵣₛ₂) * (1 - ϵᵣₛ₁) * ϵᵣₛ₂ +
        pᵣₛ * (1 - ϵᵣₛ₁) * ϵₛᵣ₂ * (1 - ϵᵣₛ₁) * (1 - ϵₛᵣ₂) +
        pₛᵣ * ϵₛᵣ₁ * (1 - ϵᵣₛ₂) * ϵₛᵣ₁ * ϵᵣₛ₂ +
        pₛₛ * ϵₛᵣ₁ * ϵₛᵣ₂ * ϵₛᵣ₁ * (1 - ϵₛᵣ₂)
    # RR,SR
    θ[3] =
        pᵣᵣ * (1 - ϵᵣₛ₁) * (1 - ϵᵣₛ₂) * ϵᵣₛ₁ * (1 - ϵᵣₛ₂) +
        pᵣₛ * (1 - ϵᵣₛ₁) * ϵₛᵣ₂ * ϵᵣₛ₁ * ϵₛᵣ₂ +
        pₛᵣ * ϵₛᵣ₁ * (1 - ϵᵣₛ₂) * (1 - ϵₛᵣ₁) * (1 - ϵᵣₛ₂) +
        pₛₛ * ϵₛᵣ₁ * ϵₛᵣ₂ * (1 - ϵₛᵣ₁) * ϵₛᵣ₂
    # RR,SS
    θ[4] =
        pᵣᵣ * (1 - ϵᵣₛ₁) * (1 - ϵᵣₛ₂) * ϵᵣₛ₁ * ϵᵣₛ₂ +
        pᵣₛ * (1 - ϵᵣₛ₁) * ϵₛᵣ₂ * ϵᵣₛ₁ * (1 - ϵₛᵣ₂) +
        pₛᵣ * ϵₛᵣ₁ * (1 - ϵᵣₛ₂) * (1 - ϵₛᵣ₁) * ϵᵣₛ₂ +
        pₛₛ * ϵₛᵣ₁ * ϵₛᵣ₂ * (1 - ϵₛᵣ₁) * (1 - ϵₛᵣ₂)
    # RS,RR
    θ[5] =
        pᵣᵣ * (1 - ϵᵣₛ₁) * ϵᵣₛ₂ * (1 - ϵᵣₛ₁) * (1 - ϵᵣₛ₂) +
        pᵣₛ * (1 - ϵᵣₛ₁) * (1 - ϵₛᵣ₂) * (1 - ϵᵣₛ₁) * ϵₛᵣ₂ +
        pₛᵣ * ϵₛᵣ₁ * ϵᵣₛ₂ * ϵₛᵣ₁ * (1 - ϵᵣₛ₂) +
        pₛₛ * ϵₛᵣ₁ * (1 - ϵₛᵣ₂) * ϵₛᵣ₁ * ϵₛᵣ₂
    # RS,RS
    θ[6] =
        pᵣᵣ * (1 - ϵᵣₛ₁) * ϵᵣₛ₂ * (1 - ϵᵣₛ₁) * ϵᵣₛ₂ +
        pᵣₛ * (1 - ϵᵣₛ₁) * (1 - ϵₛᵣ₂) * (1 - ϵᵣₛ₁) * (1 - ϵₛᵣ₂) +
        pₛᵣ * ϵₛᵣ₁ * ϵᵣₛ₂ * ϵₛᵣ₁ * ϵᵣₛ₂ +
        pₛₛ * ϵₛᵣ₁ * (1 - ϵₛᵣ₂) * ϵₛᵣ₁ * (1 - ϵₛᵣ₂)
    # RS,SR
    θ[7] =
        pᵣᵣ * (1 - ϵᵣₛ₁) * ϵᵣₛ₂ * ϵᵣₛ₁ * (1 - ϵᵣₛ₂) +
        pᵣₛ * (1 - ϵᵣₛ₁) * (1 - ϵₛᵣ₂) * ϵᵣₛ₁ * ϵₛᵣ₂ +
        pₛᵣ * ϵₛᵣ₁ * ϵᵣₛ₂ * (1 - ϵₛᵣ₁) * (1 - ϵᵣₛ₂) +
        pₛₛ * ϵₛᵣ₁ * (1 - ϵₛᵣ₂) * (1 - ϵₛᵣ₁) * ϵₛᵣ₂
    # RS,SS
    θ[8] =
        pᵣᵣ * (1 - ϵᵣₛ₁) * ϵᵣₛ₂ * ϵᵣₛ₁ * ϵᵣₛ₂ +
        pᵣₛ * (1 - ϵᵣₛ₁) * (1 - ϵₛᵣ₂) * ϵᵣₛ₁ * (1 - ϵₛᵣ₂) +
        pₛᵣ * ϵₛᵣ₁ * ϵᵣₛ₂ * (1 - ϵₛᵣ₁) * ϵᵣₛ₂ +
        pₛₛ * ϵₛᵣ₁ * (1 - ϵₛᵣ₂) * (1 - ϵₛᵣ₁) * (1 - ϵₛᵣ₂)
    # SR,RR
    θ[9] =
        pᵣᵣ * ϵᵣₛ₁ * (1 - ϵᵣₛ₂) * (1 - ϵᵣₛ₁) * (1 - ϵᵣₛ₂) +
        pᵣₛ * ϵᵣₛ₁ * ϵₛᵣ₂ * (1 - ϵᵣₛ₁) * ϵₛᵣ₂ +
        pₛᵣ * (1 - ϵₛᵣ₁) * (1 - ϵᵣₛ₂) * ϵₛᵣ₁ * (1 - ϵᵣₛ₂) +
        pₛₛ * (1 - ϵₛᵣ₁) * ϵₛᵣ₂ * ϵₛᵣ₁ * ϵₛᵣ₂
    # SR,RS
    θ[10] =
        pᵣᵣ * ϵᵣₛ₁ * (1 - ϵᵣₛ₂) * (1 - ϵᵣₛ₁) * ϵᵣₛ₂ +
        pᵣₛ * ϵᵣₛ₁ * ϵₛᵣ₂ * (1 - ϵᵣₛ₁) * (1 - ϵₛᵣ₂) +
        pₛᵣ * (1 - ϵₛᵣ₁) * (1 - ϵᵣₛ₂) * ϵₛᵣ₁ * ϵᵣₛ₂ +
        pₛₛ * (1 - ϵₛᵣ₁) * ϵₛᵣ₂ * ϵₛᵣ₁ * (1 - ϵₛᵣ₂)
    # SR,SR
    θ[11] =
        pᵣᵣ * ϵᵣₛ₁ * (1 - ϵᵣₛ₂) * ϵᵣₛ₁ * (1 - ϵᵣₛ₂) +
        pᵣₛ * ϵᵣₛ₁ * ϵₛᵣ₂ * ϵᵣₛ₁ * ϵₛᵣ₂ +
        pₛᵣ * (1 - ϵₛᵣ₁) * (1 - ϵᵣₛ₂) * (1 - ϵₛᵣ₁) * (1 - ϵᵣₛ₂) +
        pₛₛ * (1 - ϵₛᵣ₁) * ϵₛᵣ₂ * (1 - ϵₛᵣ₁) * ϵₛᵣ₂
    # SR,SS
    θ[12] =
        pᵣᵣ * ϵᵣₛ₁ * (1 - ϵᵣₛ₂) * ϵᵣₛ₁ * ϵᵣₛ₂ +
        pᵣₛ * ϵᵣₛ₁ * ϵₛᵣ₂ * ϵᵣₛ₁ * (1 - ϵₛᵣ₂) +
        pₛᵣ * (1 - ϵₛᵣ₁) * (1 - ϵᵣₛ₂) * (1 - ϵₛᵣ₁) * ϵᵣₛ₂ +
        pₛₛ * (1 - ϵₛᵣ₁) * ϵₛᵣ₂ * (1 - ϵₛᵣ₁) * (1 - ϵₛᵣ₂)
    # SS,RR
    θ[13] =
        pᵣᵣ * ϵᵣₛ₁ * ϵᵣₛ₂ * (1 - ϵᵣₛ₁) * (1 - ϵᵣₛ₂) +
        pᵣₛ * ϵᵣₛ₁ * (1 - ϵₛᵣ₂) * (1 - ϵᵣₛ₁) * ϵₛᵣ₂ +
        pₛᵣ * (1 - ϵₛᵣ₁) * ϵᵣₛ₂ * ϵₛᵣ₁ * (1 - ϵᵣₛ₂) +
        pₛₛ * (1 - ϵₛᵣ₁) * (1 - ϵₛᵣ₂) * ϵₛᵣ₁ * ϵₛᵣ₂
    # SS,RS
    θ[14] =
        pᵣᵣ * ϵᵣₛ₁ * ϵᵣₛ₂ * (1 - ϵᵣₛ₁) * ϵᵣₛ₂ +
        pᵣₛ * ϵᵣₛ₁ * (1 - ϵₛᵣ₂) * (1 - ϵᵣₛ₁) * (1 - ϵₛᵣ₂) +
        pₛᵣ * (1 - ϵₛᵣ₁) * ϵᵣₛ₂ * ϵₛᵣ₁ * ϵᵣₛ₂ +
        pₛₛ * (1 - ϵₛᵣ₁) * (1 - ϵₛᵣ₂) * ϵₛᵣ₁ * (1 - ϵₛᵣ₂)
    # SS,SR
    θ[15] =
        pᵣᵣ * ϵᵣₛ₁ * ϵᵣₛ₂ * ϵᵣₛ₁ * (1 - ϵᵣₛ₂) +
        pᵣₛ * ϵᵣₛ₁ * (1 - ϵₛᵣ₂) * ϵᵣₛ₁ * ϵₛᵣ₂ +
        pₛᵣ * (1 - ϵₛᵣ₁) * ϵᵣₛ₂ * (1 - ϵₛᵣ₁) * (1 - ϵᵣₛ₂) +
        pₛₛ * (1 - ϵₛᵣ₁) * (1 - ϵₛᵣ₂) * (1 - ϵₛᵣ₁) * ϵₛᵣ₂
    # SS,SS
    θ[16] =
        pᵣᵣ * ϵᵣₛ₁ * ϵᵣₛ₂ * ϵᵣₛ₁ * ϵᵣₛ₂ +
        pᵣₛ * ϵᵣₛ₁ * (1 - ϵₛᵣ₂) * ϵᵣₛ₁ * (1 - ϵₛᵣ₂) +
        pₛᵣ * (1 - ϵₛᵣ₁) * ϵᵣₛ₂ * (1 - ϵₛᵣ₁) * ϵᵣₛ₂ +
        pₛₛ * (1 - ϵₛᵣ₁) * (1 - ϵₛᵣ₂) * (1 - ϵₛᵣ₁) * (1 - ϵₛᵣ₂)
    return θ
end

"""
    rand(dist::TrueErrorModel, n_trials::Int)

Generate 

- `dist::TrueErrorModel{T}`: a distribution object for a True and Error Model for two choices sets, each containing
a risky option R and a safe option S.
- `n_trials`: the number of simulated trials 

# Output 

- `data::Vector{<:Int}`: vector of joint response frequencies with the following elements:

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
function rand(dist::TrueErrorModel, n_trials::Int)
    probs = compute_probs(dist)
    return rand(Multinomial(n_trials, probs))
end

function logpdf(dist::TrueErrorModel, data::AbstractVector{<:Integer})
    probs = compute_probs(dist)
    return logpdf(Multinomial(sum(data), probs), data)
end

loglikelihood(dist::TrueErrorModel, data::AbstractVector{<:Integer}) = logpdf(dist, data)
