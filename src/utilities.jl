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
