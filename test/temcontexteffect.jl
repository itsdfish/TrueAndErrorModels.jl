@testitem "TEMContextEffect" begin
    using Distributions
    using TrueAndErrorModels
    using Test

    for _ ∈ 1:100
        model = TEMContextEffect(
            p = rand(Dirichlet(fill(1, 6))),
            ϵ = rand(Uniform(0, 0.50), 5)
        )

        θ = compute_probs(model)
        @test sum(θ) ≈ 1
        @test all(x -> x ≤ 1, θ)
        @test all(x -> x ≥ 0, θ)
    end
end
