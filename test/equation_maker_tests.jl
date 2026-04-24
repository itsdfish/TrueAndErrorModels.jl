@safetestset "sums to 1 (1)" begin
    using Distributions
    using TrueAndErrorModels
    using TrueAndErrorModels: make_equations
    using Test

    include("utilities.jl")

    n_choice_sets = 3
    n_reps = 2
    n_options = 2
    constrain_choice_set = false
    constrain_option = true
    eqs = "θ = fill(0.0, $(n_options^(n_choice_sets * n_reps)))\n"
    eqs *= make_preference_sampler(n_choice_sets, n_options) * "\n"
    eqs *=
        make_error_sampler(
            n_choice_sets,
            n_options;
            constrain_choice_set,
            constrain_option
        ) * "\n"

    eqs *= make_equations(
        n_choice_sets,
        n_options,
        n_reps;
        constrain_choice_set,
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

@safetestset "sums to 1 (2)" begin
    using Distributions
    using TrueAndErrorModels
    using TrueAndErrorModels: make_equations
    using Test

    include("utilities.jl")

    n_choice_sets = 2
    n_reps = 3
    n_options = 2
    constrain_choice_set = false
    constrain_option = true
    eqs = "θ = fill(0.0, $(n_options^(n_choice_sets * n_reps)))\n"
    eqs *= make_preference_sampler(n_choice_sets, n_options) * "\n"
    eqs *=
        make_error_sampler(
            n_choice_sets,
            n_options;
            constrain_choice_set,
            constrain_option
        ) * "\n"

    eqs *= make_equations(
        n_choice_sets,
        n_options,
        n_reps;
        constrain_choice_set,
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

@safetestset "sums to 1 (3)" begin
    using Distributions
    using TrueAndErrorModels
    using TrueAndErrorModels: make_equations
    using Test

    include("utilities.jl")

    n_choice_sets = 2
    n_reps = 2
    n_options = 3
    constrain_choice_set = false
    constrain_option = false
    eqs = "θ = fill(0.0, $(n_options^(n_choice_sets * n_reps)))\n"
    eqs *= make_preference_sampler(n_choice_sets, n_options) * "\n"
    eqs *=
        make_error_sampler(
            n_choice_sets,
            n_options;
            constrain_choice_set,
            constrain_option
        ) * "\n"

    eqs *= make_equations(
        n_choice_sets,
        n_options,
        n_reps;
        constrain_choice_set,
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

@safetestset "sums to 1 (4)" begin
    using Distributions
    using TrueAndErrorModels
    using TrueAndErrorModels: make_equations
    using Test

    include("utilities.jl")

    n_choice_sets = 2
    n_reps = 2
    n_options = 3
    constrain_choice_set = false
    constrain_option = true
    eqs = "θ = fill(0.0, $(n_options^(n_choice_sets * n_reps)))\n"
    eqs *= make_preference_sampler(n_choice_sets, n_options) * "\n"
    eqs *=
        make_error_sampler(
            n_choice_sets,
            n_options;
            constrain_choice_set,
            constrain_option
        ) * "\n"

    eqs *= make_equations(
        n_choice_sets,
        n_options,
        n_reps;
        constrain_choice_set,
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

@safetestset "sums to 1 (5)" begin
    using Distributions
    using TrueAndErrorModels
    using TrueAndErrorModels: make_equations
    using Test

    include("utilities.jl")

    n_choice_sets = 2
    n_reps = 2
    n_options = [2, 3]
    constrain_choice_set = false
    constrain_option = false
    eqs = "θ = fill(0.0, $(prod(n_options)^n_reps))\n"
    eqs *= make_preference_sampler(n_choice_sets, n_options) * "\n"
    eqs *=
        make_error_sampler(
            n_choice_sets,
            n_options;
            constrain_choice_set,
            constrain_option
        ) * "\n"

    eqs *= make_equations(
        n_choice_sets,
        n_options,
        n_reps;
        constrain_choice_set,
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

@safetestset "test standard TEM" begin
    using Distributions
    using TrueAndErrorModels
    using TrueAndErrorModels: make_equations
    using Test

    include("utilities.jl")

    n_choice_sets = 2
    n_reps = 2
    n_options = 2
    constrain_choice_set = false
    constrain_option = false
    eqs = "θ = fill(0.0, $(n_options^(n_choice_sets * n_reps)))\n"
    eqs *= make_preference_sampler(n_choice_sets, n_options) * "\n"
    eqs *=
        make_error_sampler(
            n_choice_sets,
            n_options;
            constrain_choice_set,
            constrain_option
        ) * "\n"

    eqs *= make_equations(
        n_choice_sets,
        n_options,
        n_reps;
        constrain_choice_set,
        constrain_option
    )

    dir = pwd()
    cd(@__DIR__)
    open("temp.jl", "w") do io
        write(io, eqs)
    end

    include("temp.jl")

    model = TrueErrorModel(; p = [p₁₁, p₁₂, p₂₁, p₂₂], ϵ = [ϵ₂₁, ϵ₂₂, ϵ₁₁, ϵ₁₂])
    θgt = compute_probs(model)

    @test θ ≈ θgt

    rm("temp.jl")
    cd(dir)
end

@safetestset "test make_compute_probs" begin
    using ArgCheck
    using Distributions
    using TrueAndErrorModels
    using Test

    struct TestModel{T <: Real} <: AbstractTrueErrorModel{T}
        p::AbstractVector{T}
        ϵ::AbstractVector{T}

        function TestModel(p::AbstractArray{T}, ϵ::AbstractArray{T}) where {T <: Real}
            @argcheck all((ϵ .≥ 0) .&& (ϵ .≤ 0.5))
            return new{T}(p, ϵ)
        end
    end

    function TestModel(p, ϵ)
        return TestModel(promote(p, ϵ)...)
    end

    function TestModel(; p, ϵ)
        return TestModel(p, ϵ)
    end

    n_choice_sets = 2
    n_reps = 2
    n_options = [2, 3]
    constrain_choice_set = false
    constrain_option = false

    function_str = make_compute_probs(
        n_choice_sets,
        n_options,
        n_reps;
        model_type = "TestModel",
        constrain_choice_set,
        constrain_option
    )

    dir = pwd()
    cd(@__DIR__)
    open("temp.jl", "w") do io
        write(io, function_str)
    end

    include("temp.jl")

    for _ ∈ 1:100
        model = TestModel(;
            p = rand(Dirichlet(fill(1, 6))),
            ϵ = rand(Uniform(0, 0.5), 5)
        )
        θ = compute_probs(model)

        @test sum(θ) ≈ 1
        @test all(x -> x ≥ 0, θ)
        @test length(θ) == 36
    end

    rm("temp.jl")
    cd(dir)
end
