abstract type AbstractTrueErrorModel{T} <: DiscreteMultivariateDistribution end

"""
$(TYPEDSIGNATURES)

Computes the response probability for each response pattern. 

# Arguments

- `model::AbstractTrueErrorModel`: a generic true and error model 
"""
function compute_probs(model::AbstractTrueErrorModel) end

"""
$(TYPEDSIGNATURES)

Returns the number of error parameters. 

# Arguments

- `model::AbstractTrueErrorModel`: a generic true and error model 
"""
function get_error_parm_count(model::AbstractTrueErrorModel) end

"""
$(TYPEDSIGNATURES)

Returns the number of error parameters. 

# Arguments

- `::Type{<:AbstractTrueErrorModel}`: a generic true and error model type
"""
function get_error_parm_count(::Type{<:AbstractTrueErrorModel}) end

"""
$(TYPEDSIGNATURES)

Returns a vector of names corresponding to each error parameter.

# Arguments

- `model::AbstractTrueErrorModel`: a generic true and error model 
"""
function get_error_parm_labels(model::AbstractTrueErrorModel) end

"""
$(TYPEDSIGNATURES)

Returns a vector of names corresponding to each error parameter.

# Arguments

- `::Type{<:AbstractTrueErrorModel}`: a generic true and error model type
"""
function get_error_parm_labels(::Type{<:AbstractTrueErrorModel}) end

"""
$(TYPEDSIGNATURES)

Returns all model equations as a string. 

# Arguments

- `model::AbstractTrueErrorModel`: a generic true and error model 
"""
function get_equations(model::AbstractTrueErrorModel) end

"""
$(TYPEDSIGNATURES)

Returns all model equations as a string. 

# Arguments

- `::Type{<:AbstractTrueErrorModel}`: a generic true and error model type
"""
function get_equations(::Type{<:AbstractTrueErrorModel}) end

"""
$(TYPEDSIGNATURES)

Returns the number of equations in the model which corresponds to the number of response patterns.

# Arguments

- `model::AbstractTrueErrorModel`: a generic true and error model 
"""
function get_equation_count(model::AbstractTrueErrorModel) end

"""
$(TYPEDSIGNATURES)

Returns the number of equations in the model which corresponds to the number of response patterns.

# Arguments

- `::Type{<:AbstractTrueErrorModel}`: a generic true and error model type
"""
function get_equation_count(::Type{<:AbstractTrueErrorModel}) end

"""
$(TYPEDSIGNATURES) 

Returns a vector where each element corresponds to the number of options in a choice set. 

# Arguments

- `model::AbstractTrueErrorModel`: a generic true and error model 
"""
function get_n_options(model::AbstractTrueErrorModel) end

"""
$(TYPEDSIGNATURES) 

Returns a vector where each element corresponds to the number of options in a choice set. 

# Arguments

- `::Type{<:AbstractTrueErrorModel}`: a generic true and error model type
"""
function get_n_options(::Type{<:AbstractTrueErrorModel}) end

"""
$(TYPEDSIGNATURES)

Returns the number of times the choice sets are presented. 

# Arguments

- `model::AbstractTrueErrorModel`: a generic true and error model 
"""
function get_n_reps(model::AbstractTrueErrorModel) end

"""
$(TYPEDSIGNATURES)

Returns the number of times the choice sets are presented. 

# Arguments

- `::Type{<:AbstractTrueErrorModel}`: a generic true and error model type
"""
function get_n_reps(::Type{<:AbstractTrueErrorModel}) end

"""
$(TYPEDSIGNATURES)

Returns a vector of labels for the response patterns.

# Arguments

- `model::AbstractTrueErrorModel`: a generic true and error model 
"""
function get_response_labels(model::AbstractTrueErrorModel) end

"""
$(TYPEDSIGNATURES)

Returns a vector of labels for the response patterns.

# Arguments

- `::Type{<:AbstractTrueErrorModel}`: a generic true and error model type
"""
function get_response_labels(::Type{<:AbstractTrueErrorModel}) end

"""
$(TYPEDSIGNATURES)

Returns a vector of names corresponding to each true parameter.

# Arguments

- `model::AbstractTrueErrorModel`: a generic true and error model 
"""
function get_true_parm_labels(model::AbstractTrueErrorModel) end

"""
$(TYPEDSIGNATURES)

Returns a vector of names corresponding to each true parameter.

# Arguments

- `::Type{<:AbstractTrueErrorModel}`: a generic true and error model type
"""
function get_true_parm_labels(::Type{<:AbstractTrueErrorModel}) end

"""
$(TYPEDSIGNATURES)

Returns the number of true parameters.

# Arguments

- `model::AbstractTrueErrorModel`: a generic true and error model 
"""
function get_true_parm_count(model::AbstractTrueErrorModel) end

"""
$(TYPEDSIGNATURES)

Returns the number of true parameters.

# Arguments

- `::Type{<:AbstractTrueErrorModel}`: a generic true and error model type
"""
function get_true_parm_count(::Type{<:AbstractTrueErrorModel}) end

"""
$(TYPEDSIGNATURES)

Generates labels for response patterns for a single block.

# Arguments

- `model::AbstractTrueErrorModel`: a generic true and error model 
"""
function get_table_labels(model::AbstractTrueErrorModel) end

"""
$(TYPEDSIGNATURES)

Generates labels for response patterns for a single block.

# Arguments

- `::Type{<:AbstractTrueErrorModel}`: a generic true and error model type
"""
function get_table_labels(::Type{<:AbstractTrueErrorModel}) end

"""
$(TYPEDSIGNATURES)

Displays all model equations. 

# Arguments

- `model::AbstractTrueErrorModel`: a generic true and error model 
"""
function show_equations(model::AbstractTrueErrorModel) end

"""
$(TYPEDSIGNATURES) 

Displays all model equations. 

# Arguments

- `::Type{<:AbstractTrueErrorModel}`: a generic true and error model type
"""
function show_equations(::Type{<:AbstractTrueErrorModel}) end

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

