function is_zero(v; kwargs...)
    isapprox(v ⋅ v, 0; kwargs...)
end


function is_parallel(u, v; kwargs...)

    similarity = cosine_similarity(u, v)

    return isapprox(abs(similarity), 1; kwargs...)
end
