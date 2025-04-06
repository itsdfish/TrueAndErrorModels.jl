"""
    compute_probs(dist::AbstractTrueErrorModel{T})

Computes the joint probability for all 16 response categories
    
# Arguments

- `dist::AbstractTrueErrorModel{T}`: a distribution object for a True and Error Model for two choices sets, each containing
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
function compute_probs(dist::AbstractTrueErrorModel{T}) where {T}
    (; p, ϵ) = dist
    pᵣᵣ, pᵣₛ, pₛᵣ, pₛₛ = p
    ϵₛ₁, ϵₛ₂, ϵᵣ₁, ϵᵣ₂ = ϵ
    θ = zeros(T, 16)

    # RR,RR
    θ[1] =
        pᵣᵣ * (1 - ϵₛ₁) * (1 - ϵₛ₂) * (1 - ϵₛ₁) * (1 - ϵₛ₂) +
        pᵣₛ * (1 - ϵₛ₁) * ϵᵣ₂ * (1 - ϵₛ₁) * ϵᵣ₂ +
        pₛᵣ * ϵᵣ₁ * (1 - ϵₛ₂) * ϵᵣ₁ * (1 - ϵₛ₂) +
        pₛₛ * ϵᵣ₁ * ϵᵣ₂ * ϵᵣ₁ * ϵᵣ₂
    # RR,RS
    θ[2] =
        pᵣᵣ * (1 - ϵₛ₁) * (1 - ϵₛ₂) * (1 - ϵₛ₁) * ϵₛ₂ +
        pᵣₛ * (1 - ϵₛ₁) * ϵᵣ₂ * (1 - ϵₛ₁) * (1 - ϵᵣ₂) +
        pₛᵣ * ϵᵣ₁ * (1 - ϵₛ₂) * ϵᵣ₁ * ϵₛ₂ +
        pₛₛ * ϵᵣ₁ * ϵᵣ₂ * ϵᵣ₁ * (1 - ϵᵣ₂)
    # RR,SR
    θ[3] =
        pᵣᵣ * (1 - ϵₛ₁) * (1 - ϵₛ₂) * ϵₛ₁ * (1 - ϵₛ₂) +
        pᵣₛ * (1 - ϵₛ₁) * ϵᵣ₂ * ϵₛ₁ * ϵᵣ₂ +
        pₛᵣ * ϵᵣ₁ * (1 - ϵₛ₂) * (1 - ϵᵣ₁) * (1 - ϵₛ₂) +
        pₛₛ * ϵᵣ₁ * ϵᵣ₂ * (1 - ϵᵣ₁) * ϵᵣ₂
    # RR,SS
    θ[4] =
        pᵣᵣ * (1 - ϵₛ₁) * (1 - ϵₛ₂) * ϵₛ₁ * ϵₛ₂ +
        pᵣₛ * (1 - ϵₛ₁) * ϵᵣ₂ * ϵₛ₁ * (1 - ϵᵣ₂) +
        pₛᵣ * ϵᵣ₁ * (1 - ϵₛ₂) * (1 - ϵᵣ₁) * ϵₛ₂ +
        pₛₛ * ϵᵣ₁ * ϵᵣ₂ * (1 - ϵᵣ₁) * (1 - ϵᵣ₂)
    # RS,RR
    θ[5] = θ[2]
    # RS,RS
    θ[6] =
        pᵣᵣ * (1 - ϵₛ₁) * ϵₛ₂ * (1 - ϵₛ₁) * ϵₛ₂ +
        pᵣₛ * (1 - ϵₛ₁) * (1 - ϵᵣ₂) * (1 - ϵₛ₁) * (1 - ϵᵣ₂) +
        pₛᵣ * ϵᵣ₁ * ϵₛ₂ * ϵᵣ₁ * ϵₛ₂ +
        pₛₛ * ϵᵣ₁ * (1 - ϵᵣ₂) * ϵᵣ₁ * (1 - ϵᵣ₂)
    # RS,SR
    θ[7] =
        pᵣᵣ * (1 - ϵₛ₁) * ϵₛ₂ * ϵₛ₁ * (1 - ϵₛ₂) +
        pᵣₛ * (1 - ϵₛ₁) * (1 - ϵᵣ₂) * ϵₛ₁ * ϵᵣ₂ +
        pₛᵣ * ϵᵣ₁ * ϵₛ₂ * (1 - ϵᵣ₁) * (1 - ϵₛ₂) +
        pₛₛ * ϵᵣ₁ * (1 - ϵᵣ₂) * (1 - ϵᵣ₁) * ϵᵣ₂
    # RS,SS
    θ[8] =
        pᵣᵣ * (1 - ϵₛ₁) * ϵₛ₂ * ϵₛ₁ * ϵₛ₂ +
        pᵣₛ * (1 - ϵₛ₁) * (1 - ϵᵣ₂) * ϵₛ₁ * (1 - ϵᵣ₂) +
        pₛᵣ * ϵᵣ₁ * ϵₛ₂ * (1 - ϵᵣ₁) * ϵₛ₂ +
        pₛₛ * ϵᵣ₁ * (1 - ϵᵣ₂) * (1 - ϵᵣ₁) * (1 - ϵᵣ₂)
    # SR,RR
    θ[9] = θ[3]
    # SR,RS
    θ[10] = θ[7]
    # SR,SR
    θ[11] =
        pᵣᵣ * ϵₛ₁ * (1 - ϵₛ₂) * ϵₛ₁ * (1 - ϵₛ₂) +
        pᵣₛ * ϵₛ₁ * ϵᵣ₂ * ϵₛ₁ * ϵᵣ₂ +
        pₛᵣ * (1 - ϵᵣ₁) * (1 - ϵₛ₂) * (1 - ϵᵣ₁) * (1 - ϵₛ₂) +
        pₛₛ * (1 - ϵᵣ₁) * ϵᵣ₂ * (1 - ϵᵣ₁) * ϵᵣ₂
    # SR,SS
    θ[12] =
        pᵣᵣ * ϵₛ₁ * (1 - ϵₛ₂) * ϵₛ₁ * ϵₛ₂ +
        pᵣₛ * ϵₛ₁ * ϵᵣ₂ * ϵₛ₁ * (1 - ϵᵣ₂) +
        pₛᵣ * (1 - ϵᵣ₁) * (1 - ϵₛ₂) * (1 - ϵᵣ₁) * ϵₛ₂ +
        pₛₛ * (1 - ϵᵣ₁) * ϵᵣ₂ * (1 - ϵᵣ₁) * (1 - ϵᵣ₂)
    # SS,RR
    θ[13] = θ[4]
    # SS,RS
    θ[14] = θ[8]
    # SS,SR
    θ[15] = θ[12]
    # SS,SS
    θ[16] =
        pᵣᵣ * ϵₛ₁ * ϵₛ₂ * ϵₛ₁ * ϵₛ₂ +
        pᵣₛ * ϵₛ₁ * (1 - ϵᵣ₂) * ϵₛ₁ * (1 - ϵᵣ₂) +
        pₛᵣ * (1 - ϵᵣ₁) * ϵₛ₂ * (1 - ϵᵣ₁) * ϵₛ₂ +
        pₛₛ * (1 - ϵᵣ₁) * (1 - ϵᵣ₂) * (1 - ϵᵣ₁) * (1 - ϵᵣ₂)
    return θ
end

"""
    compute_probs(dist::TEMContextEffect{T})

Computes the joint probability for all 32 response categories
    
# Arguments

- `dist::TEMContextEffect{T}`: a distribution object for a True and Error Model for two choices sets, each containing
a risky option R and a safe option S.

# Output 

- `θ::Vector{T}`: vector of joint response probabilities with the following elements:

1.  ((1, 1), (1, 1)) 
2.  ((1, 1), (1, 2)) 
3.  ((1, 1), (1, 3)) 
4.  ((1, 1), (2, 1)) 
5.  ((1, 1), (2, 2)) 
6.  ((1, 1), (2, 3)) 
7.  ((1, 2), (1, 1)) 
8.  ((1, 2), (1, 2)) 
9.  ((1, 2), (1, 3)) 
10. ((1, 2), (2, 1)) 
11. ((1, 2), (2, 2)) 
12. ((1, 2), (2, 3)) 
13. ((1, 3), (1, 1)) 
14. ((1, 3), (1, 2)) 
15. ((1, 3), (1, 3)) 
16. ((1, 3), (2, 1)) 
17. ((1, 3), (2, 2)) 
18. ((1, 3), (2, 3)) 
19. ((2, 1), (1, 1)) 
20. ((2, 1), (1, 2)) 
21. ((2, 1), (1, 3)) 
22. ((2, 1), (2, 1)) 
23. ((2, 1), (2, 2)) 
24. ((2, 1), (2, 3)) 
25. ((2, 2), (1, 1)) 
26. ((2, 2), (1, 2)) 
27. ((2, 2), (1, 3)) 
28. ((2, 2), (2, 1)) 
29. ((2, 2), (2, 2)) 
30. ((2, 2), (2, 3)) 
31. ((2, 3), (1, 1)) 
32. ((2, 3), (1, 2)) 
33. ((2, 3), (1, 3)) 
34. ((2, 3), (2, 1)) 
35. ((2, 3), (2, 2)) 
36. ((2, 3), (2, 3)) 

where choice pattern ((i,j), (k,m)) represents the selection of option i in the first choice set and j in the second choice set, and k and m
are the choices from the same choicesets in the second repetition. 
"""
function compute_probs(dist::TEMContextEffect{T}) where {T}
    (; p, ϵ) = dist
    p₁₁, p₁₂, p₁₃, p₂₁, p₂₂, p₂₃ = p
    ϵ₂₁, ϵ₁₁, ϵ₂₂, ϵ₃₂, ϵ₁₂ = ϵ
    θ = zeros(T, 36)
    # choice pattern: ((1, 1), (1, 1)) 
    θ[1] =
        p₁₁ * (1 - ϵ₂₁) * (1 - ϵ₂₂ - ϵ₃₂) * (1 - ϵ₂₁) * (1 - ϵ₂₂ - ϵ₃₂) +
        p₁₂ * (1 - ϵ₂₁) * ϵ₁₂ * (1 - ϵ₂₁) * ϵ₁₂ +
        p₁₃ * (1 - ϵ₂₁) * ϵ₁₂ * (1 - ϵ₂₁) * ϵ₁₂ +
        p₂₁ * ϵ₁₁ * (1 - ϵ₂₂ - ϵ₃₂) * ϵ₁₁ * (1 - ϵ₂₂ - ϵ₃₂) +
        p₂₂ * ϵ₁₁ * ϵ₁₂ * ϵ₁₁ * ϵ₁₂ +
        p₂₃ * ϵ₁₁ * ϵ₁₂ * ϵ₁₁ * ϵ₁₂
    # choice pattern: ((1, 1), (1, 2)) 
    θ[2] =
        p₁₁ * (1 - ϵ₂₁) * (1 - ϵ₂₂ - ϵ₃₂) * (1 - ϵ₂₁) * ϵ₂₂ +
        p₁₂ * (1 - ϵ₂₁) * ϵ₁₂ * (1 - ϵ₂₁) * (1 - ϵ₁₂ - ϵ₃₂) +
        p₁₃ * (1 - ϵ₂₁) * ϵ₁₂ * (1 - ϵ₂₁) * ϵ₂₂ +
        p₂₁ * ϵ₁₁ * (1 - ϵ₂₂ - ϵ₃₂) * ϵ₁₁ * ϵ₂₂ +
        p₂₂ * ϵ₁₁ * ϵ₁₂ * ϵ₁₁ * (1 - ϵ₁₂ - ϵ₃₂) +
        p₂₃ * ϵ₁₁ * ϵ₁₂ * ϵ₁₁ * ϵ₂₂
    # choice pattern: ((1, 1), (1, 3)) 
    θ[3] =
        p₁₁ * (1 - ϵ₂₁) * (1 - ϵ₂₂ - ϵ₃₂) * (1 - ϵ₂₁) * ϵ₃₂ +
        p₁₂ * (1 - ϵ₂₁) * ϵ₁₂ * (1 - ϵ₂₁) * ϵ₃₂ +
        p₁₃ * (1 - ϵ₂₁) * ϵ₁₂ * (1 - ϵ₂₁) * (1 - ϵ₁₂ - ϵ₂₂) +
        p₂₁ * ϵ₁₁ * (1 - ϵ₂₂ - ϵ₃₂) * ϵ₁₁ * ϵ₃₂ +
        p₂₂ * ϵ₁₁ * ϵ₁₂ * ϵ₁₁ * ϵ₃₂ +
        p₂₃ * ϵ₁₁ * ϵ₁₂ * ϵ₁₁ * (1 - ϵ₁₂ - ϵ₂₂)
    # choice pattern: ((1, 1), (2, 1)) 
    θ[4] =
        p₁₁ * (1 - ϵ₂₁) * (1 - ϵ₂₂ - ϵ₃₂) * ϵ₂₁ * (1 - ϵ₂₂ - ϵ₃₂) +
        p₁₂ * (1 - ϵ₂₁) * ϵ₁₂ * ϵ₂₁ * ϵ₁₂ +
        p₁₃ * (1 - ϵ₂₁) * ϵ₁₂ * ϵ₂₁ * ϵ₁₂ +
        p₂₁ * ϵ₁₁ * (1 - ϵ₂₂ - ϵ₃₂) * (1 - ϵ₁₁) * (1 - ϵ₂₂ - ϵ₃₂) +
        p₂₂ * ϵ₁₁ * ϵ₁₂ * (1 - ϵ₁₁) * ϵ₁₂ +
        p₂₃ * ϵ₁₁ * ϵ₁₂ * (1 - ϵ₁₁) * ϵ₁₂
    # choice pattern: ((1, 1), (2, 2)) 
    θ[5] =
        p₁₁ * (1 - ϵ₂₁) * (1 - ϵ₂₂ - ϵ₃₂) * ϵ₂₁ * ϵ₂₂ +
        p₁₂ * (1 - ϵ₂₁) * ϵ₁₂ * ϵ₂₁ * (1 - ϵ₁₂ - ϵ₃₂) +
        p₁₃ * (1 - ϵ₂₁) * ϵ₁₂ * ϵ₂₁ * ϵ₂₂ +
        p₂₁ * ϵ₁₁ * (1 - ϵ₂₂ - ϵ₃₂) * (1 - ϵ₁₁) * ϵ₂₂ +
        p₂₂ * ϵ₁₁ * ϵ₁₂ * (1 - ϵ₁₁) * (1 - ϵ₁₂ - ϵ₃₂) +
        p₂₃ * ϵ₁₁ * ϵ₁₂ * (1 - ϵ₁₁) * ϵ₂₂
    # choice pattern: ((1, 1), (2, 3)) 
    θ[6] =
        p₁₁ * (1 - ϵ₂₁) * (1 - ϵ₂₂ - ϵ₃₂) * ϵ₂₁ * ϵ₃₂ +
        p₁₂ * (1 - ϵ₂₁) * ϵ₁₂ * ϵ₂₁ * ϵ₃₂ +
        p₁₃ * (1 - ϵ₂₁) * ϵ₁₂ * ϵ₂₁ * (1 - ϵ₁₂ - ϵ₂₂) +
        p₂₁ * ϵ₁₁ * (1 - ϵ₂₂ - ϵ₃₂) * (1 - ϵ₁₁) * ϵ₃₂ +
        p₂₂ * ϵ₁₁ * ϵ₁₂ * (1 - ϵ₁₁) * ϵ₃₂ +
        p₂₃ * ϵ₁₁ * ϵ₁₂ * (1 - ϵ₁₁) * (1 - ϵ₁₂ - ϵ₂₂)
    # choice pattern: ((1, 2), (1, 1)) 
    θ[7] =
        p₁₁ * (1 - ϵ₂₁) * ϵ₂₂ * (1 - ϵ₂₁) * (1 - ϵ₂₂ - ϵ₃₂) +
        p₁₂ * (1 - ϵ₂₁) * (1 - ϵ₁₂ - ϵ₃₂) * (1 - ϵ₂₁) * ϵ₁₂ +
        p₁₃ * (1 - ϵ₂₁) * ϵ₂₂ * (1 - ϵ₂₁) * ϵ₁₂ +
        p₂₁ * ϵ₁₁ * ϵ₂₂ * ϵ₁₁ * (1 - ϵ₂₂ - ϵ₃₂) +
        p₂₂ * ϵ₁₁ * (1 - ϵ₁₂ - ϵ₃₂) * ϵ₁₁ * ϵ₁₂ +
        p₂₃ * ϵ₁₁ * ϵ₂₂ * ϵ₁₁ * ϵ₁₂
    # choice pattern: ((1, 2), (1, 2)) 
    θ[8] =
        p₁₁ * (1 - ϵ₂₁) * ϵ₂₂ * (1 - ϵ₂₁) * ϵ₂₂ +
        p₁₂ * (1 - ϵ₂₁) * (1 - ϵ₁₂ - ϵ₃₂) * (1 - ϵ₂₁) * (1 - ϵ₁₂ - ϵ₃₂) +
        p₁₃ * (1 - ϵ₂₁) * ϵ₂₂ * (1 - ϵ₂₁) * ϵ₂₂ +
        p₂₁ * ϵ₁₁ * ϵ₂₂ * ϵ₁₁ * ϵ₂₂ +
        p₂₂ * ϵ₁₁ * (1 - ϵ₁₂ - ϵ₃₂) * ϵ₁₁ * (1 - ϵ₁₂ - ϵ₃₂) +
        p₂₃ * ϵ₁₁ * ϵ₂₂ * ϵ₁₁ * ϵ₂₂
    # choice pattern: ((1, 2), (1, 3)) 
    θ[9] =
        p₁₁ * (1 - ϵ₂₁) * ϵ₂₂ * (1 - ϵ₂₁) * ϵ₃₂ +
        p₁₂ * (1 - ϵ₂₁) * (1 - ϵ₁₂ - ϵ₃₂) * (1 - ϵ₂₁) * ϵ₃₂ +
        p₁₃ * (1 - ϵ₂₁) * ϵ₂₂ * (1 - ϵ₂₁) * (1 - ϵ₁₂ - ϵ₂₂) +
        p₂₁ * ϵ₁₁ * ϵ₂₂ * ϵ₁₁ * ϵ₃₂ +
        p₂₂ * ϵ₁₁ * (1 - ϵ₁₂ - ϵ₃₂) * ϵ₁₁ * ϵ₃₂ +
        p₂₃ * ϵ₁₁ * ϵ₂₂ * ϵ₁₁ * (1 - ϵ₁₂ - ϵ₂₂)
    # choice pattern: ((1, 2), (2, 1)) 
    θ[10] =
        p₁₁ * (1 - ϵ₂₁) * ϵ₂₂ * ϵ₂₁ * (1 - ϵ₂₂ - ϵ₃₂) +
        p₁₂ * (1 - ϵ₂₁) * (1 - ϵ₁₂ - ϵ₃₂) * ϵ₂₁ * ϵ₁₂ +
        p₁₃ * (1 - ϵ₂₁) * ϵ₂₂ * ϵ₂₁ * ϵ₁₂ +
        p₂₁ * ϵ₁₁ * ϵ₂₂ * (1 - ϵ₁₁) * (1 - ϵ₂₂ - ϵ₃₂) +
        p₂₂ * ϵ₁₁ * (1 - ϵ₁₂ - ϵ₃₂) * (1 - ϵ₁₁) * ϵ₁₂ +
        p₂₃ * ϵ₁₁ * ϵ₂₂ * (1 - ϵ₁₁) * ϵ₁₂
    # choice pattern: ((1, 2), (2, 2)) 
    θ[11] =
        p₁₁ * (1 - ϵ₂₁) * ϵ₂₂ * ϵ₂₁ * ϵ₂₂ +
        p₁₂ * (1 - ϵ₂₁) * (1 - ϵ₁₂ - ϵ₃₂) * ϵ₂₁ * (1 - ϵ₁₂ - ϵ₃₂) +
        p₁₃ * (1 - ϵ₂₁) * ϵ₂₂ * ϵ₂₁ * ϵ₂₂ +
        p₂₁ * ϵ₁₁ * ϵ₂₂ * (1 - ϵ₁₁) * ϵ₂₂ +
        p₂₂ * ϵ₁₁ * (1 - ϵ₁₂ - ϵ₃₂) * (1 - ϵ₁₁) * (1 - ϵ₁₂ - ϵ₃₂) +
        p₂₃ * ϵ₁₁ * ϵ₂₂ * (1 - ϵ₁₁) * ϵ₂₂
    # choice pattern: ((1, 2), (2, 3)) 
    θ[12] =
        p₁₁ * (1 - ϵ₂₁) * ϵ₂₂ * ϵ₂₁ * ϵ₃₂ +
        p₁₂ * (1 - ϵ₂₁) * (1 - ϵ₁₂ - ϵ₃₂) * ϵ₂₁ * ϵ₃₂ +
        p₁₃ * (1 - ϵ₂₁) * ϵ₂₂ * ϵ₂₁ * (1 - ϵ₁₂ - ϵ₂₂) +
        p₂₁ * ϵ₁₁ * ϵ₂₂ * (1 - ϵ₁₁) * ϵ₃₂ +
        p₂₂ * ϵ₁₁ * (1 - ϵ₁₂ - ϵ₃₂) * (1 - ϵ₁₁) * ϵ₃₂ +
        p₂₃ * ϵ₁₁ * ϵ₂₂ * (1 - ϵ₁₁) * (1 - ϵ₁₂ - ϵ₂₂)
    # choice pattern: ((1, 3), (1, 1)) 
    θ[13] =
        p₁₁ * (1 - ϵ₂₁) * ϵ₃₂ * (1 - ϵ₂₁) * (1 - ϵ₂₂ - ϵ₃₂) +
        p₁₂ * (1 - ϵ₂₁) * ϵ₃₂ * (1 - ϵ₂₁) * ϵ₁₂ +
        p₁₃ * (1 - ϵ₂₁) * (1 - ϵ₁₂ - ϵ₂₂) * (1 - ϵ₂₁) * ϵ₁₂ +
        p₂₁ * ϵ₁₁ * ϵ₃₂ * ϵ₁₁ * (1 - ϵ₂₂ - ϵ₃₂) +
        p₂₂ * ϵ₁₁ * ϵ₃₂ * ϵ₁₁ * ϵ₁₂ +
        p₂₃ * ϵ₁₁ * (1 - ϵ₁₂ - ϵ₂₂) * ϵ₁₁ * ϵ₁₂
    # choice pattern: ((1, 3), (1, 2)) 
    θ[14] =
        p₁₁ * (1 - ϵ₂₁) * ϵ₃₂ * (1 - ϵ₂₁) * ϵ₂₂ +
        p₁₂ * (1 - ϵ₂₁) * ϵ₃₂ * (1 - ϵ₂₁) * (1 - ϵ₁₂ - ϵ₃₂) +
        p₁₃ * (1 - ϵ₂₁) * (1 - ϵ₁₂ - ϵ₂₂) * (1 - ϵ₂₁) * ϵ₂₂ +
        p₂₁ * ϵ₁₁ * ϵ₃₂ * ϵ₁₁ * ϵ₂₂ +
        p₂₂ * ϵ₁₁ * ϵ₃₂ * ϵ₁₁ * (1 - ϵ₁₂ - ϵ₃₂) +
        p₂₃ * ϵ₁₁ * (1 - ϵ₁₂ - ϵ₂₂) * ϵ₁₁ * ϵ₂₂
    # choice pattern: ((1, 3), (1, 3)) 
    θ[15] =
        p₁₁ * (1 - ϵ₂₁) * ϵ₃₂ * (1 - ϵ₂₁) * ϵ₃₂ +
        p₁₂ * (1 - ϵ₂₁) * ϵ₃₂ * (1 - ϵ₂₁) * ϵ₃₂ +
        p₁₃ * (1 - ϵ₂₁) * (1 - ϵ₁₂ - ϵ₂₂) * (1 - ϵ₂₁) * (1 - ϵ₁₂ - ϵ₂₂) +
        p₂₁ * ϵ₁₁ * ϵ₃₂ * ϵ₁₁ * ϵ₃₂ +
        p₂₂ * ϵ₁₁ * ϵ₃₂ * ϵ₁₁ * ϵ₃₂ +
        p₂₃ * ϵ₁₁ * (1 - ϵ₁₂ - ϵ₂₂) * ϵ₁₁ * (1 - ϵ₁₂ - ϵ₂₂)
    # choice pattern: ((1, 3), (2, 1)) 
    θ[16] =
        p₁₁ * (1 - ϵ₂₁) * ϵ₃₂ * ϵ₂₁ * (1 - ϵ₂₂ - ϵ₃₂) +
        p₁₂ * (1 - ϵ₂₁) * ϵ₃₂ * ϵ₂₁ * ϵ₁₂ +
        p₁₃ * (1 - ϵ₂₁) * (1 - ϵ₁₂ - ϵ₂₂) * ϵ₂₁ * ϵ₁₂ +
        p₂₁ * ϵ₁₁ * ϵ₃₂ * (1 - ϵ₁₁) * (1 - ϵ₂₂ - ϵ₃₂) +
        p₂₂ * ϵ₁₁ * ϵ₃₂ * (1 - ϵ₁₁) * ϵ₁₂ +
        p₂₃ * ϵ₁₁ * (1 - ϵ₁₂ - ϵ₂₂) * (1 - ϵ₁₁) * ϵ₁₂
    # choice pattern: ((1, 3), (2, 2)) 
    θ[17] =
        p₁₁ * (1 - ϵ₂₁) * ϵ₃₂ * ϵ₂₁ * ϵ₂₂ +
        p₁₂ * (1 - ϵ₂₁) * ϵ₃₂ * ϵ₂₁ * (1 - ϵ₁₂ - ϵ₃₂) +
        p₁₃ * (1 - ϵ₂₁) * (1 - ϵ₁₂ - ϵ₂₂) * ϵ₂₁ * ϵ₂₂ +
        p₂₁ * ϵ₁₁ * ϵ₃₂ * (1 - ϵ₁₁) * ϵ₂₂ +
        p₂₂ * ϵ₁₁ * ϵ₃₂ * (1 - ϵ₁₁) * (1 - ϵ₁₂ - ϵ₃₂) +
        p₂₃ * ϵ₁₁ * (1 - ϵ₁₂ - ϵ₂₂) * (1 - ϵ₁₁) * ϵ₂₂
    # choice pattern: ((1, 3), (2, 3)) 
    θ[18] =
        p₁₁ * (1 - ϵ₂₁) * ϵ₃₂ * ϵ₂₁ * ϵ₃₂ +
        p₁₂ * (1 - ϵ₂₁) * ϵ₃₂ * ϵ₂₁ * ϵ₃₂ +
        p₁₃ * (1 - ϵ₂₁) * (1 - ϵ₁₂ - ϵ₂₂) * ϵ₂₁ * (1 - ϵ₁₂ - ϵ₂₂) +
        p₂₁ * ϵ₁₁ * ϵ₃₂ * (1 - ϵ₁₁) * ϵ₃₂ +
        p₂₂ * ϵ₁₁ * ϵ₃₂ * (1 - ϵ₁₁) * ϵ₃₂ +
        p₂₃ * ϵ₁₁ * (1 - ϵ₁₂ - ϵ₂₂) * (1 - ϵ₁₁) * (1 - ϵ₁₂ - ϵ₂₂)
    # choice pattern: ((2, 1), (1, 1)) 
    θ[19] =
        p₁₁ * ϵ₂₁ * (1 - ϵ₂₂ - ϵ₃₂) * (1 - ϵ₂₁) * (1 - ϵ₂₂ - ϵ₃₂) +
        p₁₂ * ϵ₂₁ * ϵ₁₂ * (1 - ϵ₂₁) * ϵ₁₂ +
        p₁₃ * ϵ₂₁ * ϵ₁₂ * (1 - ϵ₂₁) * ϵ₁₂ +
        p₂₁ * (1 - ϵ₁₁) * (1 - ϵ₂₂ - ϵ₃₂) * ϵ₁₁ * (1 - ϵ₂₂ - ϵ₃₂) +
        p₂₂ * (1 - ϵ₁₁) * ϵ₁₂ * ϵ₁₁ * ϵ₁₂ +
        p₂₃ * (1 - ϵ₁₁) * ϵ₁₂ * ϵ₁₁ * ϵ₁₂
    # choice pattern: ((2, 1), (1, 2)) 
    θ[20] =
        p₁₁ * ϵ₂₁ * (1 - ϵ₂₂ - ϵ₃₂) * (1 - ϵ₂₁) * ϵ₂₂ +
        p₁₂ * ϵ₂₁ * ϵ₁₂ * (1 - ϵ₂₁) * (1 - ϵ₁₂ - ϵ₃₂) +
        p₁₃ * ϵ₂₁ * ϵ₁₂ * (1 - ϵ₂₁) * ϵ₂₂ +
        p₂₁ * (1 - ϵ₁₁) * (1 - ϵ₂₂ - ϵ₃₂) * ϵ₁₁ * ϵ₂₂ +
        p₂₂ * (1 - ϵ₁₁) * ϵ₁₂ * ϵ₁₁ * (1 - ϵ₁₂ - ϵ₃₂) +
        p₂₃ * (1 - ϵ₁₁) * ϵ₁₂ * ϵ₁₁ * ϵ₂₂
    # choice pattern: ((2, 1), (1, 3)) 
    θ[21] =
        p₁₁ * ϵ₂₁ * (1 - ϵ₂₂ - ϵ₃₂) * (1 - ϵ₂₁) * ϵ₃₂ +
        p₁₂ * ϵ₂₁ * ϵ₁₂ * (1 - ϵ₂₁) * ϵ₃₂ +
        p₁₃ * ϵ₂₁ * ϵ₁₂ * (1 - ϵ₂₁) * (1 - ϵ₁₂ - ϵ₂₂) +
        p₂₁ * (1 - ϵ₁₁) * (1 - ϵ₂₂ - ϵ₃₂) * ϵ₁₁ * ϵ₃₂ +
        p₂₂ * (1 - ϵ₁₁) * ϵ₁₂ * ϵ₁₁ * ϵ₃₂ +
        p₂₃ * (1 - ϵ₁₁) * ϵ₁₂ * ϵ₁₁ * (1 - ϵ₁₂ - ϵ₂₂)
    # choice pattern: ((2, 1), (2, 1)) 
    θ[22] =
        p₁₁ * ϵ₂₁ * (1 - ϵ₂₂ - ϵ₃₂) * ϵ₂₁ * (1 - ϵ₂₂ - ϵ₃₂) +
        p₁₂ * ϵ₂₁ * ϵ₁₂ * ϵ₂₁ * ϵ₁₂ +
        p₁₃ * ϵ₂₁ * ϵ₁₂ * ϵ₂₁ * ϵ₁₂ +
        p₂₁ * (1 - ϵ₁₁) * (1 - ϵ₂₂ - ϵ₃₂) * (1 - ϵ₁₁) * (1 - ϵ₂₂ - ϵ₃₂) +
        p₂₂ * (1 - ϵ₁₁) * ϵ₁₂ * (1 - ϵ₁₁) * ϵ₁₂ +
        p₂₃ * (1 - ϵ₁₁) * ϵ₁₂ * (1 - ϵ₁₁) * ϵ₁₂
    # choice pattern: ((2, 1), (2, 2)) 
    θ[23] =
        p₁₁ * ϵ₂₁ * (1 - ϵ₂₂ - ϵ₃₂) * ϵ₂₁ * ϵ₂₂ +
        p₁₂ * ϵ₂₁ * ϵ₁₂ * ϵ₂₁ * (1 - ϵ₁₂ - ϵ₃₂) +
        p₁₃ * ϵ₂₁ * ϵ₁₂ * ϵ₂₁ * ϵ₂₂ +
        p₂₁ * (1 - ϵ₁₁) * (1 - ϵ₂₂ - ϵ₃₂) * (1 - ϵ₁₁) * ϵ₂₂ +
        p₂₂ * (1 - ϵ₁₁) * ϵ₁₂ * (1 - ϵ₁₁) * (1 - ϵ₁₂ - ϵ₃₂) +
        p₂₃ * (1 - ϵ₁₁) * ϵ₁₂ * (1 - ϵ₁₁) * ϵ₂₂
    # choice pattern: ((2, 1), (2, 3)) 
    θ[24] =
        p₁₁ * ϵ₂₁ * (1 - ϵ₂₂ - ϵ₃₂) * ϵ₂₁ * ϵ₃₂ +
        p₁₂ * ϵ₂₁ * ϵ₁₂ * ϵ₂₁ * ϵ₃₂ +
        p₁₃ * ϵ₂₁ * ϵ₁₂ * ϵ₂₁ * (1 - ϵ₁₂ - ϵ₂₂) +
        p₂₁ * (1 - ϵ₁₁) * (1 - ϵ₂₂ - ϵ₃₂) * (1 - ϵ₁₁) * ϵ₃₂ +
        p₂₂ * (1 - ϵ₁₁) * ϵ₁₂ * (1 - ϵ₁₁) * ϵ₃₂ +
        p₂₃ * (1 - ϵ₁₁) * ϵ₁₂ * (1 - ϵ₁₁) * (1 - ϵ₁₂ - ϵ₂₂)
    # choice pattern: ((2, 2), (1, 1)) 
    θ[25] =
        p₁₁ * ϵ₂₁ * ϵ₂₂ * (1 - ϵ₂₁) * (1 - ϵ₂₂ - ϵ₃₂) +
        p₁₂ * ϵ₂₁ * (1 - ϵ₁₂ - ϵ₃₂) * (1 - ϵ₂₁) * ϵ₁₂ +
        p₁₃ * ϵ₂₁ * ϵ₂₂ * (1 - ϵ₂₁) * ϵ₁₂ +
        p₂₁ * (1 - ϵ₁₁) * ϵ₂₂ * ϵ₁₁ * (1 - ϵ₂₂ - ϵ₃₂) +
        p₂₂ * (1 - ϵ₁₁) * (1 - ϵ₁₂ - ϵ₃₂) * ϵ₁₁ * ϵ₁₂ +
        p₂₃ * (1 - ϵ₁₁) * ϵ₂₂ * ϵ₁₁ * ϵ₁₂
    # choice pattern: ((2, 2), (1, 2)) 
    θ[26] =
        p₁₁ * ϵ₂₁ * ϵ₂₂ * (1 - ϵ₂₁) * ϵ₂₂ +
        p₁₂ * ϵ₂₁ * (1 - ϵ₁₂ - ϵ₃₂) * (1 - ϵ₂₁) * (1 - ϵ₁₂ - ϵ₃₂) +
        p₁₃ * ϵ₂₁ * ϵ₂₂ * (1 - ϵ₂₁) * ϵ₂₂ +
        p₂₁ * (1 - ϵ₁₁) * ϵ₂₂ * ϵ₁₁ * ϵ₂₂ +
        p₂₂ * (1 - ϵ₁₁) * (1 - ϵ₁₂ - ϵ₃₂) * ϵ₁₁ * (1 - ϵ₁₂ - ϵ₃₂) +
        p₂₃ * (1 - ϵ₁₁) * ϵ₂₂ * ϵ₁₁ * ϵ₂₂
    # choice pattern: ((2, 2), (1, 3)) 
    θ[27] =
        p₁₁ * ϵ₂₁ * ϵ₂₂ * (1 - ϵ₂₁) * ϵ₃₂ +
        p₁₂ * ϵ₂₁ * (1 - ϵ₁₂ - ϵ₃₂) * (1 - ϵ₂₁) * ϵ₃₂ +
        p₁₃ * ϵ₂₁ * ϵ₂₂ * (1 - ϵ₂₁) * (1 - ϵ₁₂ - ϵ₂₂) +
        p₂₁ * (1 - ϵ₁₁) * ϵ₂₂ * ϵ₁₁ * ϵ₃₂ +
        p₂₂ * (1 - ϵ₁₁) * (1 - ϵ₁₂ - ϵ₃₂) * ϵ₁₁ * ϵ₃₂ +
        p₂₃ * (1 - ϵ₁₁) * ϵ₂₂ * ϵ₁₁ * (1 - ϵ₁₂ - ϵ₂₂)
    # choice pattern: ((2, 2), (2, 1)) 
    θ[28] =
        p₁₁ * ϵ₂₁ * ϵ₂₂ * ϵ₂₁ * (1 - ϵ₂₂ - ϵ₃₂) +
        p₁₂ * ϵ₂₁ * (1 - ϵ₁₂ - ϵ₃₂) * ϵ₂₁ * ϵ₁₂ +
        p₁₃ * ϵ₂₁ * ϵ₂₂ * ϵ₂₁ * ϵ₁₂ +
        p₂₁ * (1 - ϵ₁₁) * ϵ₂₂ * (1 - ϵ₁₁) * (1 - ϵ₂₂ - ϵ₃₂) +
        p₂₂ * (1 - ϵ₁₁) * (1 - ϵ₁₂ - ϵ₃₂) * (1 - ϵ₁₁) * ϵ₁₂ +
        p₂₃ * (1 - ϵ₁₁) * ϵ₂₂ * (1 - ϵ₁₁) * ϵ₁₂
    # choice pattern: ((2, 2), (2, 2)) 
    θ[29] =
        p₁₁ * ϵ₂₁ * ϵ₂₂ * ϵ₂₁ * ϵ₂₂ +
        p₁₂ * ϵ₂₁ * (1 - ϵ₁₂ - ϵ₃₂) * ϵ₂₁ * (1 - ϵ₁₂ - ϵ₃₂) +
        p₁₃ * ϵ₂₁ * ϵ₂₂ * ϵ₂₁ * ϵ₂₂ +
        p₂₁ * (1 - ϵ₁₁) * ϵ₂₂ * (1 - ϵ₁₁) * ϵ₂₂ +
        p₂₂ * (1 - ϵ₁₁) * (1 - ϵ₁₂ - ϵ₃₂) * (1 - ϵ₁₁) * (1 - ϵ₁₂ - ϵ₃₂) +
        p₂₃ * (1 - ϵ₁₁) * ϵ₂₂ * (1 - ϵ₁₁) * ϵ₂₂
    # choice pattern: ((2, 2), (2, 3)) 
    θ[30] =
        p₁₁ * ϵ₂₁ * ϵ₂₂ * ϵ₂₁ * ϵ₃₂ +
        p₁₂ * ϵ₂₁ * (1 - ϵ₁₂ - ϵ₃₂) * ϵ₂₁ * ϵ₃₂ +
        p₁₃ * ϵ₂₁ * ϵ₂₂ * ϵ₂₁ * (1 - ϵ₁₂ - ϵ₂₂) +
        p₂₁ * (1 - ϵ₁₁) * ϵ₂₂ * (1 - ϵ₁₁) * ϵ₃₂ +
        p₂₂ * (1 - ϵ₁₁) * (1 - ϵ₁₂ - ϵ₃₂) * (1 - ϵ₁₁) * ϵ₃₂ +
        p₂₃ * (1 - ϵ₁₁) * ϵ₂₂ * (1 - ϵ₁₁) * (1 - ϵ₁₂ - ϵ₂₂)
    # choice pattern: ((2, 3), (1, 1)) 
    θ[31] =
        p₁₁ * ϵ₂₁ * ϵ₃₂ * (1 - ϵ₂₁) * (1 - ϵ₂₂ - ϵ₃₂) +
        p₁₂ * ϵ₂₁ * ϵ₃₂ * (1 - ϵ₂₁) * ϵ₁₂ +
        p₁₃ * ϵ₂₁ * (1 - ϵ₁₂ - ϵ₂₂) * (1 - ϵ₂₁) * ϵ₁₂ +
        p₂₁ * (1 - ϵ₁₁) * ϵ₃₂ * ϵ₁₁ * (1 - ϵ₂₂ - ϵ₃₂) +
        p₂₂ * (1 - ϵ₁₁) * ϵ₃₂ * ϵ₁₁ * ϵ₁₂ +
        p₂₃ * (1 - ϵ₁₁) * (1 - ϵ₁₂ - ϵ₂₂) * ϵ₁₁ * ϵ₁₂
    # choice pattern: ((2, 3), (1, 2)) 
    θ[32] =
        p₁₁ * ϵ₂₁ * ϵ₃₂ * (1 - ϵ₂₁) * ϵ₂₂ +
        p₁₂ * ϵ₂₁ * ϵ₃₂ * (1 - ϵ₂₁) * (1 - ϵ₁₂ - ϵ₃₂) +
        p₁₃ * ϵ₂₁ * (1 - ϵ₁₂ - ϵ₂₂) * (1 - ϵ₂₁) * ϵ₂₂ +
        p₂₁ * (1 - ϵ₁₁) * ϵ₃₂ * ϵ₁₁ * ϵ₂₂ +
        p₂₂ * (1 - ϵ₁₁) * ϵ₃₂ * ϵ₁₁ * (1 - ϵ₁₂ - ϵ₃₂) +
        p₂₃ * (1 - ϵ₁₁) * (1 - ϵ₁₂ - ϵ₂₂) * ϵ₁₁ * ϵ₂₂
    # choice pattern: ((2, 3), (1, 3)) 
    θ[33] =
        p₁₁ * ϵ₂₁ * ϵ₃₂ * (1 - ϵ₂₁) * ϵ₃₂ +
        p₁₂ * ϵ₂₁ * ϵ₃₂ * (1 - ϵ₂₁) * ϵ₃₂ +
        p₁₃ * ϵ₂₁ * (1 - ϵ₁₂ - ϵ₂₂) * (1 - ϵ₂₁) * (1 - ϵ₁₂ - ϵ₂₂) +
        p₂₁ * (1 - ϵ₁₁) * ϵ₃₂ * ϵ₁₁ * ϵ₃₂ +
        p₂₂ * (1 - ϵ₁₁) * ϵ₃₂ * ϵ₁₁ * ϵ₃₂ +
        p₂₃ * (1 - ϵ₁₁) * (1 - ϵ₁₂ - ϵ₂₂) * ϵ₁₁ * (1 - ϵ₁₂ - ϵ₂₂)
    # choice pattern: ((2, 3), (2, 1)) 
    θ[34] =
        p₁₁ * ϵ₂₁ * ϵ₃₂ * ϵ₂₁ * (1 - ϵ₂₂ - ϵ₃₂) +
        p₁₂ * ϵ₂₁ * ϵ₃₂ * ϵ₂₁ * ϵ₁₂ +
        p₁₃ * ϵ₂₁ * (1 - ϵ₁₂ - ϵ₂₂) * ϵ₂₁ * ϵ₁₂ +
        p₂₁ * (1 - ϵ₁₁) * ϵ₃₂ * (1 - ϵ₁₁) * (1 - ϵ₂₂ - ϵ₃₂) +
        p₂₂ * (1 - ϵ₁₁) * ϵ₃₂ * (1 - ϵ₁₁) * ϵ₁₂ +
        p₂₃ * (1 - ϵ₁₁) * (1 - ϵ₁₂ - ϵ₂₂) * (1 - ϵ₁₁) * ϵ₁₂
    # choice pattern: ((2, 3), (2, 2)) 
    θ[35] =
        p₁₁ * ϵ₂₁ * ϵ₃₂ * ϵ₂₁ * ϵ₂₂ +
        p₁₂ * ϵ₂₁ * ϵ₃₂ * ϵ₂₁ * (1 - ϵ₁₂ - ϵ₃₂) +
        p₁₃ * ϵ₂₁ * (1 - ϵ₁₂ - ϵ₂₂) * ϵ₂₁ * ϵ₂₂ +
        p₂₁ * (1 - ϵ₁₁) * ϵ₃₂ * (1 - ϵ₁₁) * ϵ₂₂ +
        p₂₂ * (1 - ϵ₁₁) * ϵ₃₂ * (1 - ϵ₁₁) * (1 - ϵ₁₂ - ϵ₃₂) +
        p₂₃ * (1 - ϵ₁₁) * (1 - ϵ₁₂ - ϵ₂₂) * (1 - ϵ₁₁) * ϵ₂₂
    # choice pattern: ((2, 3), (2, 3)) 
    θ[36] =
        p₁₁ * ϵ₂₁ * ϵ₃₂ * ϵ₂₁ * ϵ₃₂ +
        p₁₂ * ϵ₂₁ * ϵ₃₂ * ϵ₂₁ * ϵ₃₂ +
        p₁₃ * ϵ₂₁ * (1 - ϵ₁₂ - ϵ₂₂) * ϵ₂₁ * (1 - ϵ₁₂ - ϵ₂₂) +
        p₂₁ * (1 - ϵ₁₁) * ϵ₃₂ * (1 - ϵ₁₁) * ϵ₃₂ +
        p₂₂ * (1 - ϵ₁₁) * ϵ₃₂ * (1 - ϵ₁₁) * ϵ₃₂ +
        p₂₃ * (1 - ϵ₁₁) * (1 - ϵ₁₂ - ϵ₂₂) * (1 - ϵ₁₁) * (1 - ϵ₁₂ - ϵ₂₂)
    return θ
end

"""
    rand(dist::AbstractTrueErrorModel, n_trials::Int)

Generate a vector of simulated response frequencies based on the provided True and Error Model.

- `dist::AbstractTrueErrorModel{T}`: a distribution object for a True and Error Model for two choices sets, each containing
a risky option R and a safe option S.
- `n_trials`: the number of simulated trials 

# Output 

- `data::Vector{<:Integer}`: vector of joint response frequencies with the following elements:

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
function rand(dist::AbstractTrueErrorModel, n_trials::Int)
    probs = compute_probs(dist)
    return rand(Multinomial(n_trials, probs))
end

"""
    logpdf(dist::AbstractTrueErrorModel, data::AbstractVector{<:Integer})

Computes the log loglikelihood of the data for a True and Error Model. 

# Arguments

- `dist::AbstractTrueErrorModel{T}`: a distribution object for a True and Error Model for two choices sets, each containing
    a risky option R and a safe option S.
- `data::AbstractVector{<:Integer}`: a vector of response pattern frequencies. The elements of this vector are 
    ordered as follows:

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
function logpdf(dist::AbstractTrueErrorModel, data::AbstractVector{<:Integer})
    probs = compute_probs(dist)
    return logpdf(Multinomial(sum(data), probs), data)
end

loglikelihood(dist::AbstractTrueErrorModel, data::AbstractVector{<:Integer}) =
    logpdf(dist, data)

"""
    get_response_labels()

Returns a vector of response pattern labels.
"""
function get_response_labels()
    labels = [
        "RR,RR",
        "RR,RS",
        "RR,SR",
        "RR,SS",
        "RS,RR",
        "RS,RS",
        "RS,SR",
        "RS,SS",
        "SR,RR",
        "SR,RS",
        "SR,SR",
        "SR,SS",
        "SS,RR",
        "SS,RS",
        "SS,SR",
        "SS,SS"
    ]
end
