function make_choice_patterns(n_options, n_reps)
    n_choice_sets = length(n_options)
    sub_patterns = collect(Base.product(map(i -> (1:n_options[i]...,), 1:n_choice_sets)...))
    sub_patterns = permutedims(sub_patterns, (1:n_choice_sets))[:]

    patterns = collect(Base.product(fill(sub_patterns, n_reps)...))
    patterns = permutedims(patterns, (1:n_reps))[:]
    return patterns
end

function make_preference_patterns(n_options)
    n_choice_sets = length(n_options)
    patterns = collect(Base.product(map(i -> (1:n_options[i]...,), 1:n_choice_sets)...))
    return permutedims(patterns, (1:n_choice_sets))[:]
end

function make_preference_patterns(n_options::Int)
    return make_preference_patterns(fill(n_options, length(options)))
end

function make_numbered_patterns(n_options, n_reps)
    patterns = make_choice_patterns(n_options, n_reps)
    str = ""
    n = length(patterns)
    for i ∈ 1:n
        str *= "$i. $(patterns[i])\n"
    end
    return str
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

count_equations(n_options, n_reps) = prod(n_options)^n_reps

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
        eq *= i > 1 ? "\t" : ""
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
    constrain_choice_set = false,
    constrain_option = false
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
        eqs *= comment * "θ[$i] = " * eq * " \n"
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
    parameter_extraction = "\t(; p, ϵ) = dist\n"
    preference_patterns = make_preference_patterns(n_options)
    preference_parms = make_preference_parms(preference_patterns)
    preference_extraction = "\t" * join(preference_parms, ", ") * " = p\n"

    error_parms = make_error_parms(n_options)
    error_extraction = "\t" * join(error_parms, ", ") * " = ϵ\n"
    theta = "\tθ = zeros(T, $(count_equations(n_options, n_reps)))\n"
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
        $model_type{T <: Real, V <: AbstractVector{T}} <: AbstractTrueErrorModel{T}

    A True and Error Model (TEM) based on an experimental design with $(length(n_options)) choice sets, `n_options` = $n_options per choice set, and `n_reps` = $n_reps presentations of each choice set. The ith element in `n_options`
    indicates the number of options in the ith choice set. `n_reps` denotes the number of times each choice set is presented 
    in an experiment. Typically, each choice set is presented once per block in a randomized fashion with filler choices interspersed.

    # Fields

    - `p::V`: a vector of true preference state probabilities with elements `$p`, such that pᵢ ≥ 0 ∀i and Σᵢ pᵢ = 1. 
        The parameter `pᵢⱼ` indicates the probability of truely prefering option `i` in the first choice set and option `j` in the
        second choice set.    
    - `ϵ::V`: a vector of error probabilities `$ϵ` with elements 0 ≤ ϵⱼ ≤ .50. 
        The parameter ϵᵢₖ indicates the probability of erroneously selecting option `i` in choice set `k`. 


    # Response Patterns

    Response patterns are coded as follows: responses within the same block are grouped by inner parentheses, numbers correspond to the index of the selected option, and position of the number within the parentheses indicates the choice set.
     For example, `((1,1), (1,2))` indicates the first option was chosen in all cases except in the second choice set of the second block where the second option was selected.
    For the experimental design described above, output vectors from `rand` and `compute_probs` correspond to the following
    response patterns:

    $(make_numbered_patterns(n_options, n_reps))

    # Example

    The examples below illustrate basic usage of the API for `TrueAndErrorModels`.

    ```julia
    n_options = [2, 2]
    n_reps = 2
    @make_model $model_type n_options n_reps

    model = $model_type(; p = [0.3, 0.40, 0.3, 0.0], ϵ = [0.4, 0.2, 0.2, 0.1])
    probs = compute_probs(model)
    data = rand(model, 100)
    LL = logpdf(model, data)

    get_error_parm_count(model)
    get_n_options(model)
    get_n_reps(model)
    get_true_parm_count(model)
    get_equations(model)
    ```

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

model = MyCoolModel(; p = [0.3, 0.40, 0.3, 0.0], ϵ = [0.4, 0.2, 0.2, 0.1])
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
        function TEM.get_error_parm_count(dist::Type{<:$model_type})
            return n_error_parms
        end

        TEM.get_error_parm_count(dist::$model_type) =
            TEM.get_error_parm_count(typeof(dist))

        local n_true_parms = prod($n_options)
        function TEM.get_true_parm_count(dist::Type{<:$model_type})
            return n_true_parms
        end

        TEM.get_true_parm_count(dist::$model_type) =
            TEM.get_true_parm_count(typeof(dist))

        local _n_options = deepcopy($n_options)
        function TEM.get_n_options(dist::Type{<:$model_type})
            return _n_options
        end
        TEM.get_n_options(dist::$model_type) = TEM.get_n_options(typeof(dist))

        local _n_reps = deepcopy($n_reps)
        function TEM.get_n_reps(dist::Type{<:$model_type})
            return _n_reps
        end
        TEM.get_n_reps(dist::$model_type) = TEM.get_n_reps(typeof(dist))

        local _n_equations = TEM.count_equations($n_options, $n_reps)
        function TEM.get_equation_count(dist::Type{<:$model_type})
            return _n_equations
        end
        TEM.get_equation_count(dist::$model_type) = TEM.get_equation_count(typeof(dist))

        Base.length(dist::$model_type) = TEM.get_equation_count(dist)

        local eqs = TEM.make_equations($n_options, $n_reps)
        eqs = replace(eqs, "# " => "", "*" => "⋅")
        function TEM.get_equations(dist::Type{<:$model_type})
            return println(eqs)
        end
        TEM.get_equations(dist::$model_type) = TEM.get_equations(typeof(dist))

        @doc $func_doc
        function TEM.compute_probs(dist::$model_type{T, V}) where {T, V}
            $function_expr
        end
    end)
end
