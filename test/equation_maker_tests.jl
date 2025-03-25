@testitem "sums to 1" begin 
    using Distributions
    using TrueAndErrorModels
    using TrueAndErrorModels: make_equations
    using Test

    include("utilities.jl")

    n_choice_sets = 2
    n_reps = 2
    θ = zeros((n_reps * 2)^n_choice_sets)
    eqs = make_preference_sampler(n_choice_sets) * "\n"
    eqs *= make_error_sampler(n_choice_sets, n_reps) * "\n"


    eqs *= make_equations(n_choice_sets, n_reps; constrained = false)


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
end
