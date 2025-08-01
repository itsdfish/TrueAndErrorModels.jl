@testitem "predict_distribution" begin
    using TrueAndErrorModels
    using Test
    using Turing
    using TuringUtilities

    n_sim = 200
    dist = TrueErrorModel(; p = [0.65, 0.15, 0.15, 0.05], ϵ = fill(0.10, 4))
    data = rand(dist, n_sim)

    model = tet1_model(data)
    chains = sample(model, NUTS(500, 0.65), MCMCThreads(), 500, 4)

    pred_model = predict_distribution(
        simulator = p -> rand(TrueErrorModel(; p...), n_sim);
        model,
        func = x -> x ./ sum(x)
    )

    post_preds = returned(pred_model, chains)
    post_preds = stack(post_preds, dims = 1)
    @test model() ≠ nothing
end

@testitem "tet1_model" begin
    using TrueAndErrorModels
    using Test
    using Turing

    n_sim = 10
    dist = TrueErrorModel(; p = [0.65, 0.15, 0.15, 0.05], ϵ = fill(0.10, 4))
    data = rand(dist, n_sim)
    model = tet1_model(data)

    for _ ∈ 1:100
        Θ = model()
        @test length(Θ) == 2
        @test all(Θ.p .≥ 0)
        @test sum(Θ.p) ≈ 1
        @test all((Θ.ϵ .≥ 0) .&& (Θ.ϵ .≤ .5))
        @test var(Θ.ϵ) ≈ 0 
    end
end

@testitem "tet2_model" begin
    using TrueAndErrorModels
    using Test
    using Turing

    n_sim = 10
    dist = TrueErrorModel(; p = [0.65, 0.15, 0.15, 0.05], ϵ = fill(0.10, 4))
    data = rand(dist, n_sim)
    model = tet2_model(data)

    for _ ∈ 1:100
        Θ = model()
        @test length(Θ) == 2
        @test all(Θ.p .≥ 0)
        @test sum(Θ.p) ≈ 1
        @test all((Θ.ϵ .≥ 0) .&& (Θ.ϵ .≤ .5))
        @test Θ.ϵ[1] ≈ Θ.ϵ[3]
        @test Θ.ϵ[2] ≈ Θ.ϵ[4]
    end
end

@testitem "tet4_model" begin
    using TrueAndErrorModels
    using Test
    using Turing

    n_sim = 10
    dist = TrueErrorModel(; p = [0.65, 0.15, 0.15, 0.05], ϵ = fill(0.10, 4))
    data = rand(dist, n_sim)
    model = tet4_model(data)

    for _ ∈ 1:100
        Θ = model()
        @test length(Θ) == 2
        @test all(Θ.p .≥ 0)
        @test sum(Θ.p) ≈ 1
        @test all((Θ.ϵ .≥ 0) .&& (Θ.ϵ .≤ .5))
        @test Θ.ϵ[1] ≠ Θ.ϵ[2] ≠ Θ.ϵ[3] ≠ Θ.ϵ[4] 
    end
end

@testitem "eut1_model" begin
    using TrueAndErrorModels
    using Test
    using Turing

    n_sim = 10
    dist = TrueErrorModel(; p = [0.65, 0.15, 0.15, 0.05], ϵ = fill(0.10, 4))
    data = rand(dist, n_sim)
    model = eut1_model(data)

    for _ ∈ 1:100
        Θ = model()
        @test length(Θ) == 2
        @test all(Θ.p .≥ 0)
        @test sum(Θ.p) ≈ 1
        @test Θ.p[2] ≈ 0
        @test Θ.p[3] ≈ 0
        @test all((Θ.ϵ .≥ 0) .&& (Θ.ϵ .≤ .5))
        @test var(Θ.ϵ) ≈ 0 
    end
end

@testitem "eut2_model" begin
    using TrueAndErrorModels
    using Test
    using Turing

    n_sim = 10
    dist = TrueErrorModel(; p = [0.65, 0.15, 0.15, 0.05], ϵ = fill(0.10, 4))
    data = rand(dist, n_sim)
    model = eut2_model(data)

    for _ ∈ 1:100
        Θ = model()
        @test length(Θ) == 2
        @test all(Θ.p .≥ 0)
        @test sum(Θ.p) ≈ 1
        @test Θ.p[2] ≈ 0
        @test Θ.p[3] ≈ 0
        @test all((Θ.ϵ .≥ 0) .&& (Θ.ϵ .≤ .5))
        @test Θ.ϵ[1] ≈ Θ.ϵ[3]
        @test Θ.ϵ[2] ≈ Θ.ϵ[4]
    end
end

@testitem "eut4_model" begin
    using TrueAndErrorModels
    using Test
    using Turing

    n_sim = 10
    dist = TrueErrorModel(; p = [0.65, 0.15, 0.15, 0.05], ϵ = fill(0.10, 4))
    data = rand(dist, n_sim)
    model = eut4_model(data)

    for _ ∈ 1:100
        Θ = model()
        @test length(Θ) == 2
        @test all(Θ.p .≥ 0)
        @test sum(Θ.p) ≈ 1
        @test Θ.p[2] ≈ 0
        @test Θ.p[3] ≈ 0
        @test all((Θ.ϵ .≥ 0) .&& (Θ.ϵ .≤ .5))
        @test Θ.ϵ[1] ≠ Θ.ϵ[2] ≠ Θ.ϵ[3] ≠ Θ.ϵ[4] 
    end
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