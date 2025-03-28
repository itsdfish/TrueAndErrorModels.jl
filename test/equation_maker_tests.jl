@testitem "sums to 1 (1)" begin
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
    θ = zeros((n_options)^(n_reps * n_choice_sets))
    eqs = make_preference_sampler(n_choice_sets, n_options) * "\n"
    eqs *=
        make_error_sampler(
            n_choice_sets,
            n_options;
            constrain_choice_set,
            constrain_conditional,
            constrain_option
        ) * "\n"

    eqs *= make_equations(
        n_choice_sets,
        n_options,
        n_reps;
        constrain_choice_set,
        constrain_conditional,
        constrain_option
    )

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

@testitem "sums to 1 (2)" begin
    using Distributions
    using TrueAndErrorModels
    using TrueAndErrorModels: make_equations
    using Test

    include("utilities.jl")

    n_choice_sets = 2
    n_reps = 3
    n_options = 2
    constrain_choice_set = false
    constrain_conditional = true
    constrain_option = true
    θ = zeros((n_options)^(n_reps * n_choice_sets))
    eqs = make_preference_sampler(n_choice_sets, n_options) * "\n"
    eqs *=
        make_error_sampler(
            n_choice_sets,
            n_options;
            constrain_choice_set,
            constrain_conditional,
            constrain_option
        ) * "\n"

    eqs *= make_equations(
        n_choice_sets,
        n_options,
        n_reps;
        constrain_choice_set,
        constrain_conditional,
        constrain_option
    )

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

@testitem "sums to 1 (3)" begin
    using Distributions
    using TrueAndErrorModels
    using TrueAndErrorModels: make_equations
    using Test

    include("utilities.jl")

    n_choice_sets = 2
    n_reps = 2
    n_options = 3
    constrain_choice_set = false
    constrain_conditional = false
    constrain_option = false
    θ = zeros((n_options)^(n_reps * n_choice_sets))
    eqs = make_preference_sampler(n_choice_sets, n_options) * "\n"
    eqs *=
        make_error_sampler(
            n_choice_sets,
            n_options;
            constrain_choice_set,
            constrain_conditional,
            constrain_option
        ) * "\n"

    eqs *= make_equations(
        n_choice_sets,
        n_options,
        n_reps;
        constrain_choice_set,
        constrain_conditional,
        constrain_option
    )

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

@testitem "sums to 1 (4)" begin
    using Distributions
    using TrueAndErrorModels
    using TrueAndErrorModels: make_equations
    using Test

    include("utilities.jl")

    n_choice_sets = 2
    n_reps = 2
    n_options = 3
    constrain_choice_set = false
    constrain_conditional = true
    constrain_option = true
    θ = zeros((n_options)^(n_reps * n_choice_sets))
    eqs = make_preference_sampler(n_choice_sets, n_options) * "\n"
    eqs *=
        make_error_sampler(
            n_choice_sets,
            n_options;
            constrain_choice_set,
            constrain_conditional,
            constrain_option
        ) * "\n"

    eqs *= make_equations(
        n_choice_sets,
        n_options,
        n_reps;
        constrain_choice_set,
        constrain_conditional,
        constrain_option
    )

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


@testitem "test standard TEM" begin
    using Distributions
    using TrueAndErrorModels
    using TrueAndErrorModels: make_equations
    using Test

    include("utilities.jl")

    n_choice_sets = 2
    n_reps = 2
    n_options = 2
    constrain_choice_set = false
    constrain_conditional = true
    constrain_option = false
    θ = zeros((n_options)^(n_reps * n_choice_sets))
    eqs = make_preference_sampler(n_choice_sets, n_options) * "\n"
    eqs *=
        make_error_sampler(
            n_choice_sets,
            n_options;
            constrain_choice_set,
            constrain_conditional,
            constrain_option
        ) * "\n"

    eqs *= make_equations(
        n_choice_sets,
        n_options,
        n_reps;
        constrain_choice_set,
        constrain_conditional,
        constrain_option
    )

    dir = pwd()
    cd(@__DIR__)
    open("temp.jl", "w") do io
        write(io, eqs)
    end

    include("temp.jl")

    model = TrueErrorModel(; p = [p₁₁,p₁₂,p₂₁,p₂₂], ϵ = [ϵ₂₁, ϵ₂₂, ϵ₁₁, ϵ₁₂])
    θgt = compute_probs(model)

    @test θ ≈ θgt

    rm("temp.jl")
    cd(dir)
end
