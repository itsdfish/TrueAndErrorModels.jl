using TrueAndErrorModels: make_preference_parms
using TrueAndErrorModels: make_preference_patterns
using TrueAndErrorModels: subscriptnumber

function make_error_parms(n_choice_sets, n_reps)
    error_parms = ""
    for r ∈ 1:n_reps
        for i ∈ 1:n_choice_sets
            error_parms *= "ϵ" * subscriptnumber(i) *  subscriptnumber(r)
            error_parms *= (r == n_reps) && (i == n_choice_sets) ? "" : ", "
        end
    end
    return error_parms
end

function make_error_sampler(n_choice_sets, n_reps)
    parms = make_error_parms(n_choice_sets, n_reps)
    return parms * " = rand(Uniform(0, .50), $(n_choice_sets * n_reps))"
end

function make_preference_sampler(n_choice_sets)
    parms = ""
    preference_patterns = make_preference_patterns(n_choice_sets)
    preference_parms = make_preference_parms(preference_patterns)
    n_parms = length(preference_parms)
    for i ∈ 1:n_parms
        parms *= preference_parms[i]
        parms *= (i == n_parms) ? "" : "," 
    end
    parms *= " = rand(Dirichlet(fill(1, $n_parms)))"
    return parms 
end
