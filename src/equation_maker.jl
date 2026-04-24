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
"""
function make_compute_probs(
    n_choice_sets::Int,
    n_options::Int,
    n_reps::Int;
    model_type,
    constrain_choice_set,
    constrain_option
)
    return make_compute_probs(
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
"""
function make_compute_probs(
    n_options::Vector{Int},
    n_reps::Int;
    model_type,
    constrain_choice_set = false,
    constrain_option = false
)
    function_header = "function compute_probs(dist::$model_type{T}) where {T}\n"
    parameter_extraction = "\t(; p, ϵ) = dist\n"
    preference_patterns = make_preference_patterns(n_options)
    preference_parms = make_preference_parms(preference_patterns)
    preference_extraction = "\t" * join(preference_parms, ", ") * " = p\n"

    error_parms = make_error_parms(n_options)
    error_extraction = "\t" * join(error_parms, ", ") * " = ϵ\n"
    theta = "\tθ = fill(0.0, $(prod(n_options)^n_reps))\n"
    eqs = make_equations(
        n_options,
        n_reps;
        constrain_choice_set,
        constrain_option
    )
    indented_eqs = join("\t" .* split(eqs, "\n"), "\n")
    str =
        function_header * parameter_extraction * preference_extraction * error_extraction *
        theta * indented_eqs * "return θ \n" * "end"
    return str
end
