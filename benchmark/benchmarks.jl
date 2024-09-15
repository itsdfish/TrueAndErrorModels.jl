####################################################################################################
#                                       set up
####################################################################################################
using BenchmarkTools
using TrueAndErrorModels

SUITE = BenchmarkGroup()
model = TrueErrorModel(;
    p = [0.1, 0.2, 0.3, 0.4],
    ϵ = [0.05, 0.10, 0.15, 0.20]
)
data = rand(model, 1000)
####################################################################################################
#                                     compute probs
####################################################################################################
SUITE[:compute_probs] = @benchmarkable(
    compute_probs(model),
    evals = 10,
    samples = 10_000,
)
####################################################################################################
#                                       logpdf
####################################################################################################
SUITE[:logpdf] = @benchmarkable(
    logpdf(model, data),
    evals = 10,
    samples = 10_000,
    setup = (data)
)
