using SafeTestsets

@safetestset "compute_probs" begin
    using TrueAndErrorModels
    using Test

    model = TrueErrorModel(; p = [0.1, 0.2, 0.3, 0.4], ϵ = [0.05, 0.10, 0.15, 0.20])
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
    @test probs ≈ true_probs atol = 0.002
end

@safetestset "rand" begin
    using Random
    using TrueAndErrorModels
    using Test

    Random.seed!(574)

    model = TrueErrorModel(; p = [0.1, 0.2, 0.3, 0.4], ϵ = [0.05, 0.10, 0.15, 0.20])
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
    @test probs ≈ true_probs atol = 0.005
end

@safetestset "zero methods" begin
    using TrueAndErrorModels
    using Test

    @test length(methods(tet1_model)) == 0
end

@safetestset "two methods" begin
    using TrueAndErrorModels
    using Test
    using Turing

    @test length(methods(tet1_model)) == 2
end