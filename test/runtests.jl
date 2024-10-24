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

@safetestset "one methods to_table" begin
    using TrueAndErrorModels
    using Test
    using NamedArrays

    @test length(methods(to_table)) == 1
end

@safetestset "test Turing" begin
    using TrueAndErrorModels
    using Test
    using Turing
    using TuringUtilities

    dist = TrueErrorModel(; p = [0.65, 0.15, 0.15, 0.05], ϵ = fill(0.10, 4))
    data = rand(dist, 200)

    model = tet1_model(data)
    chains = sample(model, NUTS(1000, 0.65), MCMCThreads(), 1000, 4)

    pred_model = predict_distribution(
        TrueErrorModel;
        model,
        func = x -> x ./ sum(x),
        n_samples = 200
    )

    post_preds = generated_quantities(pred_model, chains)
    post_preds = stack(post_preds, dims = 1)
end
