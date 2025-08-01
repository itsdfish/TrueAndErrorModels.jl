@testitem "compute_probs" begin
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

@testitem "rand" begin
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

@testitem "constructors 1" begin
    using TrueAndErrorModels
    using Test

    model1 = TrueErrorModel(; p = [0.1, 0.2, 0.3, 0.4], ϵ = [0.05, 0.10, 0.15, 0.20])
    model2 = TrueErrorModel([0.1, 0.2, 0.3, 0.4], [0.05, 0.10, 0.15, 0.20])
    @test model1 == model2
end

@testitem "constructors 2" begin
    using TrueAndErrorModels
    using Test

    model1 = TrueErrorModel(; p = [0.1, 0.2, 0.3, 0.4], ϵ = Float32[0.05, 0.10, 0.15, 0.20])
    @test isa(model1.p, Vector{Float64})
end

@testitem "constructors 4" begin
    using TrueAndErrorModels
    using Test

    Θ = (
        p = [0.1, 0.2, 0.3, 0.4], ϵ = [-0.05, 0.10, 0.15, 0.20]
    )
    @test_throws ArgumentError TrueErrorModel(; Θ...)
end

@testitem "constructors 4" begin
    using TrueAndErrorModels
    using Test

    Θ = (
        p = [0.1, 0.2, 0.3, 0.4], ϵ = [0.51, 0.10, 0.15, 0.20]
    )
    @test_throws ArgumentError TrueErrorModel(; Θ...)
end

@testitem "two methods" begin
    using TrueAndErrorModels
    using Test
    using Turing

    @test length(methods(tet1_model)) == 2
end

@testitem "one methods to_table" begin
    using TrueAndErrorModels
    using Test
    using NamedArrays

    @test length(methods(to_table)) == 1
end

@test "to_table" begin
    using NamedArrays
    using TrueAndErrorModels
    using Test

    labels = get_response_labels()
    table = to_table(labels)

    # choice 1 in columns 
    choices = ["RR", "RS", "SR", "SS"]
    for c1 ∈ choices, c2 ∈ choices
        @test table[c2, c1] == c1 * "," * c2
    end
end
