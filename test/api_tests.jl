module ComputeProbsTest1
using TrueAndErrorModels
using TrueAndErrorModels: col_to_row_major
using Test

n_options = [2, 2]
n_reps = 2
@make_model TestModel n_options n_reps

model = TestModel(; p = [0.1, 0.3, 0.2, 0.4], ϵ = [0.05, 0.15, 0.10, 0.20])
probs = compute_probs(model)

@test sum(model.p) ≈ 1
@test sum(probs) ≈ 1

true_probs = [
    0.086
    0.039
    0.037
    0.014
    0.039
    0.122
    0.014
    0.039
    0.037
    0.014
    0.187
    0.066
    0.014
    0.039
    0.066
    0.187
]

true_probs = col_to_row_major(true_probs, (2, 2, 2, 2))

@test probs ≈ true_probs atol = 0.002
println("$(@__MODULE__) passed")
end

module ComputeProbsTest2
using Random
using TrueAndErrorModels
using TrueAndErrorModels: col_to_row_major
using Test

Random.seed!(574)

n_options = [2, 2]
n_reps = 2
@make_model TestModel n_options n_reps

model = TestModel(; p = [0.1, 0.3, 0.2, 0.4], ϵ = [0.05, 0.15, 0.10, 0.20])
n_trials = 100_000
data = rand(model, n_trials)
probs = data ./ n_trials

@test sum(model.p) ≈ 1
@test sum(probs) ≈ 1

true_probs = [
    0.086
    0.039
    0.037
    0.014
    0.039
    0.122
    0.014
    0.039
    0.037
    0.014
    0.187
    0.066
    0.014
    0.039
    0.066
    0.187
]
true_probs = col_to_row_major(true_probs, (2, 2, 2, 2))

@test probs ≈ true_probs atol = 0.005
println("$(@__MODULE__) passed")
end

module Constructors1
using TrueAndErrorModels
using Test

n_options = [2, 2]
n_reps = 2
@make_model TestModel n_options n_reps

model1 = TestModel(; p = [0.1, 0.3, 0.2, 0.4], ϵ = [0.05, 0.15, 0.10, 0.20])
model2 = TestModel([0.1, 0.3, 0.2, 0.4], [0.05, 0.15, 0.10, 0.20])
@test model1 == model2
println("$(@__MODULE__) passed")
end

# @safetestset "constructors 2" begin
#     using TrueAndErrorModels
#     using Test
# n_options = [2, 2]
# n_reps = 2
# @make_model TestModel n_options n_reps
#     model1 = TestModel(; p = [0.1, 0.2, 0.3, 0.4], ϵ = Float32[0.05, 0.15, 0.10, 0.20])
#     @test isa(model1.p, Vector{Float64})
#     println("$(@__MODULE__) passed")
# end

module Constructors4
using TrueAndErrorModels
using Test

n_options = [2, 2]
n_reps = 2
@make_model TestModel n_options n_reps

Θ = (
    p = [0.1, 0.3, 0.3, 0.4], ϵ = [-0.05, 0.10, 0.15, 0.20]
)
@test_throws ArgumentError TestModel(; Θ...)
println("$(@__MODULE__) passed")
end

# @safetestset "constructors 4" begin
#     using TrueAndErrorModels
#     using Test

# n_options = [2, 2]
# n_reps = 2
# @make_model TestModel n_options n_reps

#     Θ = (
#         p = [0.1, 0.2, 0.3, 0.4], ϵ = [0.51, 0.10, 0.15, 0.20]
#     )
#     @test_throws ArgumentError TestModel(; Θ...)
#     println("$(@__MODULE__) passed")
# end

# @safetestset "two methods" begin
#     using TrueAndErrorModels
#     using Test
#     using Turing

# n_options = [2, 2]
# n_reps = 2
# @make_model TestModel n_options n_reps

#     @test length(methods(tet1_model)) == 2
#     println("$(@__MODULE__) passed")
# end

# @safetestset "one methods to_table" begin
#     using TrueAndErrorModels
#     using Test
#     using NamedArrays

# n_options = [2, 2]
# n_reps = 2
# @make_model TestModel n_options n_reps

#     @test length(methods(to_table)) == 1
#     println("$(@__MODULE__) passed")
# end

# @safetestset "to_table" begin
#     using NamedArrays
#     using TrueAndErrorModels
#     using Test

#     labels = get_response_labels(TestModel)
#     table = to_table(labels)

#     # choice 1 in columns 
#     choices = ["RR", "RS", "SR", "SS"]
#     for c1 ∈ choices, c2 ∈ choices
#         @test table[c2, c1] == c1 * "," * c2
#     end
#     println("$(@__MODULE__) passed")
# end

module ModelMakerTest2
using Distributions
using TrueAndErrorModels
using Test

n_reps = 2
n_options = [2, 3]
@make_model TestModel n_options n_reps

for _ ∈ 1:100
    model = TestModel(;
        p = rand(Dirichlet(fill(1, 6))),
        ϵ = rand(Uniform(0, 0.5), 5)
    );
    θ = compute_probs(model)

    @test sum(θ) ≈ 1
    @test all(x -> x ≥ 0, θ)
    @test length(θ) == 36
end
println("$(@__MODULE__) passed")
end

module PredictDistribution
using TrueAndErrorModels
using Test
using Turing
using TuringUtilities

n_reps = 2
n_options = [2, 2]
@make_model TestModel n_options n_reps
n_sim = 200
dist = TestModel(; p = [0.65, 0.15, 0.15, 0.05], ϵ = fill(0.10, 4))
data = rand(dist, n_sim)

@model function tet1_model(data::Vector{<:Integer})
    p ~ Dirichlet(fill(1, 4))
    ϵ ~ Uniform(0, 0.5)
    ϵ′ = fill(ϵ, 4)
    data ~ TestModel(; p, ϵ = ϵ′)
    return (; p, ϵ = ϵ′)
end
model = tet1_model(data)
chains = sample(model, NUTS(500, 0.65), MCMCThreads(), 500, 4)

pred_model = predict_distribution(
    simulator = p -> rand(TestModel(; p...), n_sim);
    model,
    func = x -> x ./ sum(x)
)

post_preds = returned(pred_model, chains)
post_preds = stack(post_preds, dims = 1)
@test model() ≠ nothing
println("$(@__MODULE__) passed")
end
