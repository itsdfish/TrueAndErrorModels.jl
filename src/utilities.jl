function Base.show(io::IO, ::MIME"text/plain", model::AbstractTrueErrorModel)
    T = typeof(model)
    model_name = string(T.name.name)
    n_options = get_n_options(model)
    preference_patterns = make_preference_patterns(n_options)
    p = make_preference_parms(preference_patterns)
    ϵ = make_error_parms(n_options)
    θ = vcat(p, ϵ)
    column_labels = [
        [MultiColumn(length(model.p), "p"), MultiColumn(length(model.ϵ), "ϵ")],
        θ
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

function col_to_row_major(v::AbstractVector, dims::Tuple)
    # Reconstruct the N-dimensional array
    A = reshape(v, dims)
    # Reverse the dimension order and flatten
    return vec(permutedims(A, reverse(1:length(dims))))
end
