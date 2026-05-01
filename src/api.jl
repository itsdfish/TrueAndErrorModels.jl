abstract type AbstractTrueErrorModel{T} <: DiscreteMultivariateDistribution end

function get_error_parm_count end
function get_true_parm_count end
function get_n_options end
function get_n_reps end
function compute_probs end
function get_equations end
function get_equation_count end

"""
$(TYPEDSIGNATURES)

Generate a vector of simulated response frequencies based on the provided True and Error Model.

- `dist::AbstractTrueErrorModel{T}`: a distribution object for a True and Error Model 
- `n_trials`: the number of simulated trials 

# Output 

- `data::Vector{<:Integer}`: vector of joint response frequencies with the following elements:

# Example

```julia
using TrueAndErrorModels

n_options = [2, 2]
n_reps = 2
@make_model TestModel n_options n_reps

model = TestModel(; p = [0.3, 0.40, 0.3, 0.0], ϵ = [0.4, 0.2, 0.2, 0.1])
data = rand(model, 100)
```
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

- `dist::AbstractTrueErrorModel{T}`: a distribution object for a True and Error Model 
- `data::AbstractVector{<:Integer}`: a vector of response pattern frequencies. 

# Example

```julia
using TrueAndErrorModels

n_options = [2, 2]
n_reps = 2
@make_model TestModel n_options n_reps

model = TestModel(; p = [0.3, 0.40, 0.3, 0.0], ϵ = [0.4, 0.2, 0.2, 0.1])
data = rand(model, 100)
LL = logpdf(model, data)

```
"""
function logpdf(dist::AbstractTrueErrorModel, data::AbstractVector{<:Integer})
    probs = compute_probs(dist)
    return logpdf(Multinomial(sum(data), probs), data)
end

loglikelihood(dist::AbstractTrueErrorModel, data::AbstractVector{<:Integer}) =
    logpdf(dist, data)
