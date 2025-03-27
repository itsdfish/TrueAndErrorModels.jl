
function make_choice_patterns(n_choice_sets, n_reps)
    sub_patterns = collect(Base.product(fill((1, 2), n_choice_sets)...))
    sub_patterns = permutedims(sub_patterns, (n_choice_sets:-1:1))[:]

    patterns = collect(Base.product(fill(sub_patterns, n_reps)...))
    patterns = permutedims(patterns, (n_reps:-1:1))[:]
    return patterns
end

function make_preference_patterns(n_choice_sets)
    patterns = collect(Base.product(fill((1, 2), n_choice_sets)...))
    return permutedims(patterns, (n_choice_sets:-1:1))[:]
end

function make_rep_index(i; constrained)
    return constrained ? "" : sub("$i")
end

function make_preference_parms(preference_patterns)
    return map(i -> "p" * (sub.("$i")...), preference_patterns)
end

function make_error_terms(choice_pattern, preference_pattern; constrained = true)
    error_terms = ""
    n_choice_sets = length(preference_pattern)
    n_reps = length(choice_pattern)
    for r ∈ 1:n_reps
        for i ∈ 1:n_choice_sets
            ϵ = "ϵ" * sub("$i") * make_rep_index(r; constrained)
            if preference_pattern[i] == choice_pattern[r][i]
                error_terms *= "(1 - $ϵ)"
            else
                error_terms *= "$ϵ"
            end
            error_terms *= (r == n_reps) && (i == n_choice_sets) ? "" : " * "
        end
    end
    return error_terms
end

function make_equation_rhs(
    preference_parms,
    preference_patterns,
    choice_pattern;
    constrained = false
)
    n = length(preference_patterns)
    eq = ""
    for i ∈ 1:n
        eq *=
            preference_parms[i] * " * " *
            make_error_terms(choice_pattern, preference_patterns[i]; constrained)
        eq *= (i == n) ? "" : " + \n"
    end
    return eq
end

function make_equations(n_choice_sets, n_reps; constrained = true)
    choice_patterns = make_choice_patterns(n_choice_sets, n_reps)
    preference_patterns = make_preference_patterns(n_choice_sets)
    preference_parms = make_preference_parms(preference_patterns)
    eqs = ""
    i = 1
    for choice_pattern ∈ choice_patterns
        comment = "# choice pattern: $choice_pattern \n"
        eq = make_equation_rhs(
            preference_parms,
            preference_patterns,
            choice_pattern;
            constrained
        )
        eqs *= comment * "θ[$i] = \n" * eq * " \n"
        i += 1
    end
    return eqs
end
