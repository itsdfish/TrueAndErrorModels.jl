cd(@__DIR__)
using Pkg
Pkg.activate(".")
using TrueAndErrorModels

n_options = [2, 2]
n_reps = 2
@make_model TestModel n_options n_reps

model = TestModel(; p = [0.3, 0.40, 0.3, 0.0], ϵ = [0.4, 0.2, 0.2, 0.1])
compute_probs(model)
error_parm_count(model)
get_n_options(model)
get_n_reps(model)
true_parm_count(model)

n_options = [2, 3]
n_reps = 2
@make_model TestModel n_options n_reps

model = TestModel(; p = [0.3, 0.40, 0.3, 0.0, 0.0, 0.0], ϵ = [0.4, 0.2, 0.2, 0.1, 0.0]);
compute_probs(model)
error_parm_count(model)
get_n_options(model)
get_n_reps(model)
true_parm_count(model)
