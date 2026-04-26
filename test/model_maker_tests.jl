module ModelMakerTest1
using Distributions
using TrueAndErrorModels
using Test

n_reps = 2
n_options = [2, 2]
@make_model TestModel n_options n_reps

p = rand(Dirichlet(fill(1, 4)))
ϵ = rand(Uniform(0, 0.5), 4)

model1 = TrueErrorModel(; p, ϵ)
θ1 = compute_probs(model1)

model2 = TestModel(; p, ϵ)
θ2 = compute_probs(model2)

@test θ1 ≈ θ2
end

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
end

module ModelMakerTest3
using Test
using Distributions
using TrueAndErrorModels

n_reps = 2
n_options = [2, 2]
@make_model TestModel n_options n_reps

for _ ∈ 1:10
    p = rand(Dirichlet(fill(1, 4)))
    ϵ = fill(0.0, 4)
    model1 = TrueErrorModel(; p, ϵ)
    θ1 = compute_probs(model1)
    model2 = TestModel(; p, ϵ)
    θ2 = compute_probs(model2)

    @test θ1 ≈ θ2
end
end
