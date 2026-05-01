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
