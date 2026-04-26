function make_choice_patterns(n_options, n_reps)
    n_choice_sets = length(n_options)
    sub_patterns = collect(Base.product(map(i -> (1:n_options[i]...,), 1:n_choice_sets)...))
    sub_patterns = permutedims(sub_patterns, (n_choice_sets:-1:1))[:]

    patterns = collect(Base.product(fill(sub_patterns, n_reps)...))
    patterns = permutedims(patterns, (n_reps:-1:1))[:]
    return patterns
end

function make_preference_patterns(n_options)
    n_choice_sets = length(n_options)
    patterns = collect(Base.product(map(i -> (1:n_options[i]...,), 1:n_choice_sets)...))
    return permutedims(patterns, (n_choice_sets:-1:1))[:]
end

function make_preference_patterns(n_options::Int)
    return make_preference_patterns(fill(n_options, length(options)))
end

function add_choice_set_index(i; constrain_choice_set)
    return constrain_choice_set ? "" : sub("$i")
end

function add_option_index(i; constrain_option)
    return constrain_option ? "" : sub("$i")
end

function make_preference_parms(preference_patterns)
    return map(i -> "p" * (sub.("$i")...), preference_patterns)
end

function make_error_parms(n_options)
    parms = fill("", sum(n_options))
    i = 1
    for c ∈ 1:length(n_options)
        for s ∈ n_options[c]:-1:1
            parms[i] = "ϵ" * (sub.("$s")...) * (sub.("$c")...)
            i += 1
        end
    end
    return parms
end

function make_error_terms(
    choice_pattern,
    preference_pattern,
    n_options;
    constrain_option,
    constrain_choice_set
)
    error_terms = ""
    n_choice_sets = length(preference_pattern)
    n_reps = length(choice_pattern)
    for r ∈ 1:n_reps
        for i ∈ 1:n_choice_sets
            if preference_pattern[i] == choice_pattern[r][i]
                error_terms *= "(1"
                for c ∈ 1:n_options[i]
                    error_terms *=
                        preference_pattern[i] ≠ c ?
                        " - ϵ" * add_option_index(c; constrain_option) *
                        add_choice_set_index(i; constrain_choice_set) : ""
                end
                error_terms *= ")"
            else
                error_terms *=
                    "ϵ" * add_option_index(choice_pattern[r][i]; constrain_option) *
                    add_choice_set_index(i; constrain_choice_set)
            end
            error_terms *= (r == n_reps) && (i == n_choice_sets) ? "" : " * "
        end
    end
    return error_terms
end

function make_equation_rhs(
    preference_parms,
    preference_patterns,
    choice_pattern,
    n_options;
    constrain_choice_set = false,
    constrain_option = false
)
    n = length(preference_patterns)
    eq = ""
    for i ∈ 1:n
        eq *=
            preference_parms[i] * " * " *
            make_error_terms(
                choice_pattern,
                preference_patterns[i],
                n_options;
                constrain_choice_set,
                constrain_option
            )
        eq *= (i == n) ? "" : " + \n"
    end
    return eq
end

function make_equations(
    n_choice_sets::Int,
    n_options::Int,
    n_reps::Int;
    constrain_choice_set,
    constrain_option
)
    return make_equations(
        fill(n_options, n_choice_sets),
        n_reps;
        constrain_choice_set,
        constrain_option
    )
end

function make_equations(
    n_options::Vector{Int},
    n_reps::Int;
    constrain_choice_set,
    constrain_option
)
    choice_patterns = make_choice_patterns(n_options, n_reps)
    preference_patterns = make_preference_patterns(n_options)
    preference_parms = make_preference_parms(preference_patterns)
    eqs = ""
    i = 1
    for choice_pattern ∈ choice_patterns
        comment = "# choice pattern: $choice_pattern \n"
        eq = make_equation_rhs(
            preference_parms,
            preference_patterns,
            choice_pattern,
            n_options;
            constrain_choice_set,
            constrain_option
        )
        eqs *= comment * "θ[$i] = \n" * eq * " \n"
        i += 1
    end
    return eqs
end

"""
$(TYPEDSIGNATURES)

Generate a standard True and Error model based on options per choice set and number of repetitions. 

# Arguments 

- `n_choice_sets::Int`: the number of choice sets
- `n_options::Int`: the number of options per choice set
- `n_reps::Int`: the number of times each choice set is presented

# Keyword 

- `model_type`: the type of model on which `compute_probs` is dispatched
- `constrain_choice_set = false`: constrains `ϵ` parameters based on choice set
- `constrain_option = false`: constrains `ϵ` parameters based on option

# Returns 

Returns a string representation of the compute_probs function

# Example

```julia
using TrueAndErrorModels
model_str = make_compute_probs(3, 2, 2, "MyModel")
```
"""
function make_function_body(
    n_choice_sets::Int,
    n_options::Int,
    n_reps::Int;
    model_type,
    constrain_choice_set = false,
    constrain_option = false
)
    return make_function_body(
        fill(n_options, n_choice_sets),
        n_reps;
        model_type,
        constrain_choice_set,
        constrain_option
    )
end

"""
$(TYPEDSIGNATURES)

Generate a standard True and Error model based on options per choice set and number of repetitions. 

# Arguments 

- `n_options::Vector{Int}`: the number of options in each choice set
- `n_reps::Int`: the number of times each choice set is presented

# Keyword 

- `model_type`: the type of model on which `compute_probs` is dispatched
- `constrain_choice_set = false`: constrains `ϵ` parameters based on choice set
- `constrain_option = false`: constrains `ϵ` parameters based on option

# Returns 

Returns a string representation of the compute_probs function
"""
function make_function_body(
    n_options::Vector{Int},
    n_reps::Int;
    constrain_choice_set = false,
    constrain_option = false
)
    #function_header = "function compute_probs(dist::$model_type{T}) where {T}\n"
    parameter_extraction = "\t(; p, ϵ) = dist\n"
    preference_patterns = make_preference_patterns(n_options)
    preference_parms = make_preference_parms(preference_patterns)
    preference_extraction = "\t" * join(preference_parms, ", ") * " = p\n"

    error_parms = make_error_parms(n_options)
    error_extraction = "\t" * join(error_parms, ", ") * " = ϵ\n"
    theta = "\tθ = zeros(T, $(prod(n_options)^n_reps))\n"
    eqs = make_equations(
        n_options,
        n_reps;
        constrain_choice_set,
        constrain_option
    )
    indented_eqs = join("\t" .* split(eqs, "\n"), "\n")
    str =
        "begin \n" * parameter_extraction * preference_extraction * error_extraction *
        theta * indented_eqs * "return θ \n" * "end"
    return str
end

function make_struct_doc_strings(model_type, n_options, n_reps)
    preference_patterns = make_preference_patterns(n_options)
    preference_parms = make_preference_parms(preference_patterns)
    error_parms = make_error_parms(n_options)
    p = "p = [" * join(preference_parms, ", ") * "]"

    error_parms = make_error_parms(n_options)
    ϵ = "ϵ = [" * join(error_parms, ", ") * "]"
    return str = """
        $model_type{T <: Real} <: AbstractTrueErrorModel{T}

    A True and Error Model (TEM) based on `n_options` = $n_options and `n_reps` = $n_reps. The ith element in `n_options`
    indicates the number of options in the ith choice set. `n_reps` denotes the number of times each choice set is presented 
    in an experiment. Typically, each choice set is presented once per block in a randomized fashion with filler choices interspersed.

    # Fields

    - `p::V`: a vector of true preference state probabilities with elements `$p`, such that pᵢ ≥ 0 ∀i and Σᵢ pᵢ = 1. 
        The parameter `pᵢⱼ` indicates the probability of true prefering option `i` in the first choice set and option `j` in the
        second choice set.    
    - `ϵ::V`: a vector of error probabilities with elements `$ϵ` such that 0 ≤ ϵₖ ≤ .50. 
        The parameter ϵᵢₐ indicates the probability of erroneously selecting option `i` in block `a`. 

    # Example


    """
end

"""
    make_model model_type n_options n_reps

Generates a struct named `model_type`, constructors and a method for `compute_probs` based on `n_options` and 
`n_reps`. The struct for `model_type` and method for `compute_probs` includes auto-generated documentation.

# Arguments

- `model_type`: the name of the struct representing the model. 
- `n_options::Vector{Int}`: the number of options in each choice set, e.g., `[2,3]` indicates 2 options in 
the first choice set and 3 in the second choice set. 
- `n_reps`: the number of times each choice set is presented. Each repetition occurs in seperate blocks with filler choices.

# Example

```julia
using TrueAndErrorModels

@make_model MyCoolModel [2,2] 3

model = MyCoolModel(; p = [.3, .1, .2, .4], ϵ = [])
```
"""
macro make_model(model_type, n_options, n_reps)
    # Use __module__ to evaluate the arguments in the scope where the macro is called
    val_n_options = Core.eval(__module__, n_options)
    val_n_reps = Core.eval(__module__, n_reps)
    # 1. Generate the string or Expr body BEFORE the quote
    # Note: If n_options/n_reps are literals (like 5, 10), this works perfectly.
    function_body = make_function_body(
        val_n_options,
        val_n_reps;
        constrain_choice_set = false,
        constrain_option = false
    )

    # 2. Convert the string to a Julia Expression (Expr) once
    function_expr = Meta.parse(function_body)

    struct_doc = make_struct_doc_strings(model_type, val_n_options, val_n_reps)
    func_doc = "Computes probabilities for the `$model_type` model."

    # We escape these symbols once here for readability
    T = esc(:T)
    V = esc(:V)
    dist = esc(:dist)

    return esc(quote
        # import TrueAndErrorModels: compute_probs
        # import TrueAndErrorModels: error_parm_count
        const TEM = TrueAndErrorModels

        @doc $struct_doc
        struct $model_type{T <: Real, V <: AbstractVector{T}} <: AbstractTrueErrorModel{T}
            p::V
            ϵ::V

            function $model_type(p::V, ϵ::V) where {T <: Real, V <: AbstractVector{T}}
                local n_error_parms = sum($n_options)
                local n_true_parms = prod($n_options)

                if !all(p .≥ 0)
                    throw(ArgumentError("All elements of p must be ≥ 0"))
                end
                if !(sum(p) ≈ 1)
                    throw(ArgumentError("Sum of p must be approximately 1"))
                end
                if !all((ϵ .≥ 0) .&& (ϵ .≤ 0.5))
                    throw(ArgumentError("All elements of ϵ must be in [0, 0.5]"))
                end
                if length(p) ≠ n_true_parms
                    throw(ArgumentError("The length of p must be in $(n_true_parms)"))
                end
                if length(ϵ) ≠ n_error_parms
                    throw(ArgumentError("The length of ϵ must be in $(n_error_parms)"))
                end
                return new{T, V}(p, ϵ)
            end
        end

        function $model_type(p, ϵ)
            return $model_type(promote(p, ϵ)...)
        end

        function $model_type(; p, ϵ)
            return $model_type(p, ϵ)
        end

        local n_error_parms = sum($n_options)
        function error_parm_count(dist::Type{<:$model_type})
            return n_error_parms
        end

        error_parm_count(dist::$model_type) =
            error_parm_count(typeof(dist))

        local n_true_parms = prod($n_options)
        function true_parm_count(dist::Type{<:$model_type})
            return n_true_parms
        end

        true_parm_count(dist::$model_type) =
            true_parm_count(typeof(dist))

        local _n_options = deepcopy($n_options)
        function TEM.get_n_options(dist::Type{<:$model_type})
            return _n_options
        end
        TEM.get_n_options(dist::$model_type) = TEM.get_n_options(typeof(dist))

        local _n_reps = deepcopy($n_reps)
        function get_n_reps(dist::Type{<:$model_type})
            return _n_reps
        end
        get_n_reps(dist::$model_type) = get_n_reps(typeof(dist))

        @doc $func_doc
        function compute_probs(dist::$model_type{T, V}) where {T, V}
            $function_expr
        end
    end)
end
