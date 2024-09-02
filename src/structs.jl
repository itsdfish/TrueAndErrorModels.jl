abstract type AbstractTrueErrorModel <: DiscreteMultivariateDistribution end

"""
    TrueErrorModel{T <: Real} <: AbstractTrueErrorModel

A model object for a True and Error Model of Allias Paradox. Two choice sets are presented twice during two sessions, 
meaning 8 choices are made in total. Subscript r represents risky, subscript s represents safe, and subscripts 1 and 2
represent choice set. For example, `pᵣᵣ` represents the probability of truely prefering the risky option in both choice sets
and `ϵᵣₛ₁` represents the error probability of choosing safe given a true preference for risky in first choice set. 

    # Fields 

- `p::AbstractVector{T}`: a vector of true preference state probabilities with elements `p = [pᵣᵣ, pᵣₛ, pₛᵣ, pₛₛ]`, such that sum(p) = 1. 
- `p::AbstractVector{T}`: a vector of error probabilities with elements `[ϵᵣₛ₁, ϵᵣₛ₂, ϵₛᵣ₁, ϵₛᵣ₂]`.

"""
struct TrueErrorModel{T <: Real} <: AbstractTrueErrorModel
    p::AbstractVector{T}
    ϵ::AbstractVector{T}
end

function TrueErrorModel(; p, ϵ)
    return TrueErrorModel(p, ϵ)
end
