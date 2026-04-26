abstract type AbstractTrueErrorModel{T} <: DiscreteMultivariateDistribution end

function error_parm_count end
function true_parm_count end
function get_n_options end
function get_n_reps end
function compute_probs end

"""
$(TYPEDSIGNATURES)

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
function rand(rng::AbstractRNG, dist::AbstractTrueErrorModel, n_trials::Int)
    probs = compute_probs(dist)
    return rand(rng, Multinomial(n_trials, probs))
end

rand(dist::AbstractTrueErrorModel, n_trials::Int) =
    rand(Random.default_rng(), dist, n_trials)

"""
$(TYPEDSIGNATURES)

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
