using TrueAndErrorModels: make_preference_parms
using TrueAndErrorModels: make_preference_patterns
using TrueAndErrorModels: add_choice_set_index
using TrueAndErrorModels: add_conditional_index
using TrueAndErrorModels: add_option_index
using Subscripts: sub

function make_error_parms(
    n_choice_sets,
    n_options;
    constrain_choice_set,
    constrain_conditional,
    constrain_option
)
    n_opt_constrained = constrain_option ? fill(1, n_choice_sets) : n_options
    n_choice_constrained = constrain_choice_set ? 1 : n_choice_sets
    error_parms = ""
    for c ∈ 1:n_choice_constrained
        for o1 ∈ 1:n_opt_constrained[c]
            for o2 ∈ 1:n_opt_constrained[c]
                (o1 == o2) && !constrain_option ? continue : nothing
                ϵ =
                    "ϵ" * add_option_index(o2; constrain_option) *
                    add_choice_set_index(c; constrain_choice_set) *
                    add_conditional_index(o1; constrain_conditional)
                error_parms *= contains(error_parms, ϵ) ? continue : ϵ
                error_parms *= ", "
            end
        end
    end
    return error_parms
end

function make_error_sampler(
    n_choice_sets::Int,
    n_options::Int;
    constrain_choice_set,
    constrain_conditional,
    constrain_option
)
    return make_error_sampler(
        n_choice_sets,
        fill(n_options, n_choice_sets);
        constrain_choice_set,
        constrain_conditional,
        constrain_option
    )
end

function make_error_sampler(
    n_choice_sets::Int,
    n_options::Vector{Int};
    constrain_choice_set,
    constrain_conditional,
    constrain_option
)
    parms = make_error_parms(
        n_choice_sets,
        n_options;
        constrain_choice_set,
        constrain_conditional,
        constrain_option
    )
    n = count(x -> occursin(x, ","), parms)
    return parms * " = rand(Uniform(0, .50), $n)"
end

function make_preference_sampler(n_choice_sets, n_options)
    parms = ""
    preference_patterns = make_preference_patterns(n_choice_sets, n_options)
    preference_parms = make_preference_parms(preference_patterns)
    n_parms = length(preference_parms)
    for i ∈ 1:n_parms
        parms *= preference_parms[i]
        parms *= (i == n_parms) ? "" : ","
    end
    parms *= " = rand(Dirichlet(fill(1, $n_parms)))"
    return parms
end
