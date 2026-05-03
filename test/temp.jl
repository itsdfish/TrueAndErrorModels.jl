cd(@__DIR__)
using Pkg
Pkg.activate(".")
using TrueAndErrorModels

n_options = [2, 2]
n_reps = 2
@make_model TestModel n_options n_reps

model = TestModel(; p = [0.3, 0.40, 0.3, 0.0], ϵ = [0.4, 0.2, 0.2, 0.1])
probs = compute_probs(model)
data = rand(model, 100)
LL = logpdf(model, data)

get_error_parm_count(model)
get_n_options(model)
get_n_reps(model)
get_true_parm_count(model)
show_equations(model)

n_options = [2, 3]
n_reps = 2
@make_model TestModel n_options n_reps

model = TestModel(; p = [0.3, 0.40, 0.3, 0.0, 0.0, 0.0], ϵ = [0.4, 0.2, 0.2, 0.1, 0.0])
compute_probs(model)
get_error_parm_count(model)
get_n_options(model)
get_n_reps(model)
get_true_parm_count(model)
show_equations(model)
