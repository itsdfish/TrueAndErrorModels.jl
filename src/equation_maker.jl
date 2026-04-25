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
    m_name = esc(model_type)
    # 2. Convert the string to a Julia Expression (Expr) once
    function_expr = Meta.parse(function_body)

    struct_doc = """
    $model_type{T <: Real} <: AbstractTrueErrorModel{T}

    This is a custom model of type `$model_type` with $val_n_options options and $val_n_reps reps.
    """
    func_doc = "Computes probabilities for the `$model_type` model."

    # We escape these symbols once here for readability
    T = esc(:T)
    V = esc(:V)
    dist = esc(:dist)
    m_name = esc(model_type)
    comp_probs = esc(:compute_probs)

    quote
        using ArgCheck
        import TrueAndErrorModels: compute_probs

        #@doc $struct_doc
        struct $m_name{$T <: Real, $V <: AbstractVector{$T}} <: AbstractTrueErrorModel{$T}
            p::$V
            ϵ::$V

            function $m_name(p::$V, ϵ::$V) where {$T <: Real, $V <: AbstractVector{$T}}
                @argcheck all(p .≥ 0)
                @argcheck sum(p) ≈ 1
                @argcheck all((ϵ .≥ 0) .&& (ϵ .≤ 0.5))
                return new{$T, $V}(p, ϵ)
            end
        end

        function $m_name(p, ϵ)
            return $m_name(promote(p, ϵ)...)
        end

        function $m_name(; p, ϵ)
            return $m_name(p, ϵ)
        end

        #@doc $func_doc
        function $comp_probs($dist::$m_name{$T, $V}) where {$T, $V}
            println("dfkk")
            $(esc(function_expr))
        end
    end
end
