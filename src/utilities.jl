function Base.show(io::IO, ::MIME"text/plain", model::AbstractTrueErrorModel)
    T = typeof(model)
    model_name = string(T.name.name)
    column_labels = [
        [MultiColumn(4, "p"), MultiColumn(4, "ϵ")],
        ["pᵣᵣ", "pᵣₛ", "pₛᵣ", "pₛₛ", "ϵₛ₁", "ϵₛ₂", "ϵᵣ₁", "ϵᵣ₂"]
    ]
    return pretty_table(
        io,
        [model.p; model.ϵ]';
        title = model_name,
        column_label_alignment = :c,
        column_labels = column_labels,
        compact_printing = false,
        formatters = [fmt__printf("%5.2f", [2,])],
        alignment = :c
    )
end

get_response_labels(model::AbstractTrueErrorModel) = get_response_labels(typeof(model))

"""
    get_response_labels(::Type{<:AbstractTrueErrorModel})

Returns a vector of response pattern labels.
"""
function get_response_labels(::Type{<:AbstractTrueErrorModel})
    labels = [
        "RR,RR",
        "RR,RS",
        "RR,SR",
        "RR,SS",
        "RS,RR",
        "RS,RS",
        "RS,SR",
        "RS,SS",
        "SR,RR",
        "SR,RS",
        "SR,SR",
        "SR,SS",
        "SS,RR",
        "SS,RS",
        "SS,SR",
        "SS,SS"
    ]
end
