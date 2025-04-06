
function make_choice_patterns(n_choice_sets, n_options, n_reps)
    sub_patterns = collect(Base.product(map(i -> (1:n_options[i]...,), 1:n_choice_sets)...))
    sub_patterns = permutedims(sub_patterns, (n_choice_sets:-1:1))[:]

    patterns = collect(Base.product(fill(sub_patterns, n_reps)...))
    patterns = permutedims(patterns, (n_reps:-1:1))[:]
    return patterns
end

function make_preference_patterns(n_choice_sets, n_options)
    patterns = collect(Base.product(map(i -> (1:n_options[i]...,), 1:n_choice_sets)...))
    return permutedims(patterns, (n_choice_sets:-1:1))[:]
end

function make_preference_patterns(n_choice_sets::Int, n_options::Int)
    return make_preference_patterns(n_choice_sets, fill(n_options, n_choice_sets))
end

function add_choice_set_index(i; constrain_choice_set)
    return constrain_choice_set ? "" : sub("$i")
end

function add_option_index(i; constrain_option)
    return constrain_option ? "" : sub("$i")
end

function add_conditional_index(i; constrain_conditional)
    return constrain_conditional ? "" : "₍" * sub("$i") * "₎"
end

function make_preference_parms(preference_patterns)
    return map(i -> "p" * (sub.("$i")...), preference_patterns)
end

function make_error_terms(
    choice_pattern,
    preference_pattern,
    n_options;
    constrain_option,
    constrain_choice_set,
    constrain_conditional
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
                        add_choice_set_index(i; constrain_choice_set) *
                        add_conditional_index(preference_pattern[i]; constrain_conditional) :
                        ""
                end
                error_terms *= ")"
            else
                error_terms *=
                    "ϵ" * add_option_index(choice_pattern[r][i]; constrain_option) *
                    add_choice_set_index(i; constrain_choice_set) *
                    add_conditional_index(preference_pattern[i]; constrain_conditional)
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
    constrain_conditional = false,
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
                constrain_conditional,
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
    constrain_conditional,
    constrain_option
)
    return make_equations(
        n_choice_sets,
        fill(n_options, n_choice_sets),
        n_reps;
        constrain_choice_set,
        constrain_conditional,
        constrain_option
    )
end

function make_equations(
    n_choice_sets::Int,
    n_options::Vector{Int},
    n_reps::Int;
    constrain_choice_set,
    constrain_conditional,
    constrain_option
)
    choice_patterns = make_choice_patterns(n_choice_sets, n_options, n_reps)
    preference_patterns = make_preference_patterns(n_choice_sets, n_options)
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
            constrain_conditional,
            constrain_option
        )
        eqs *= comment * "θ[$i] = \n" * eq * " \n"
        i += 1
    end
    return eqs
end
