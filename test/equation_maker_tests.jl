@testitem "sums to 1" begin
    using Distributions
    using TrueAndErrorModels
    using TrueAndErrorModels: make_equations
    using Test

    include("utilities.jl")

    n_choice_sets = 3
    n_reps = 2
    n_options = 2
    constrain_choice_set = false
    constrain_conditional = true
    constrain_option = true
    θ = zeros((n_options)^(n_reps + n_choice_sets))
    eqs = make_preference_sampler(n_choice_sets, n_options) * "\n"
    #eqs *= make_error_sampler(n_choice_sets, n_options, n_reps; constrained = false) * "\n"
    eqs *= make_equations(
        n_choice_sets,
        n_options,
        n_reps;
        constrain_choice_set,
        constrain_conditional,
        constrain_option
    )

    # p(1 | 1)
    # p(2 | 1)
    # p(3 | 1)
    # p(1 | 2)
    # p(2 | 2)
    # p(3 | 2)
    # p(1 | 3)
    # p(2 | 3)
    # p(3 | 3)

    dir = pwd()
    cd(@__DIR__)
    open("temp.jl", "w") do io
        write(io, eqs)
    end

    for _ ∈ 1:10
        include("temp.jl")
        @test sum(θ) ≈ 1
        @test all(x -> x ≤ 1, θ)
        @test all(x -> x ≥ 0, θ)
    end
    rm("temp.jl")
    cd(dir)

    # ϵ₂₍₁₎
    # ϵ₃₍₁₎
    # ϵ₁₍₂₎ = .2
    # ϵ₃₍₂₎
    # ϵ₂₍₃₎
    # ϵ₁₍₃₎

    # 1,2,3 1,3,3: (1 - ϵ₂₍₁₎ - ϵ₃₍₁₎)
end
