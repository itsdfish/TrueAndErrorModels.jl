"""
$(TYPEDSIGNATURES)

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
function compute_probs(dist::TrueErrorModel{T}) where {T}
    (; p, ϵ) = dist
    pᵣᵣ, pᵣₛ, pₛᵣ, pₛₛ = p
    ϵₛ₁, ϵᵣ₁, ϵₛ₂, ϵᵣ₂ = ϵ
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

length(d::TrueErrorModel) = 16
