
@safetestset "to_table" begin
    using NamedArrays
    using TrueAndErrorModels
    using Test

    labels = get_response_labels(TrueErrorModel)
    table = to_table(labels)

    # choice 1 in columns 
    choices = ["RR", "RS", "SR", "SS"]
    for c1 ∈ choices, c2 ∈ choices
        @test table[c2, c1] == c1 * "," * c2
    end
end
