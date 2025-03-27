@testitem "sums to 1" begin
    using Distributions
    using TrueAndErrorModels
    using TrueAndErrorModels: make_equations
    using Test

    include("utilities.jl")

    n_choice_sets = 2
    n_reps = 2
    constrained = false
    θ = zeros((n_reps * 2)^n_choice_sets)
    eqs = make_preference_sampler(n_choice_sets) * "\n"
    eqs *= make_error_sampler(n_choice_sets, n_reps; constrained) * "\n"
    eqs *= make_equations(n_choice_sets, n_reps; constrained)

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
