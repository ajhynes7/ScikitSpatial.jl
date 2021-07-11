function is_zero(v; kwargs...)
    isapprox(v ⋅ v, 0; kwargs...)
end


function is_parallel(u, v; kwargs...)

    if is_zero(u; kwargs...) || is_zero(v; kwargs...)
        return true
    end

    similarity = cosine_similarity(u, v)

    return isapprox(abs(similarity), 1; kwargs...)
end


function is_perpendicular(u, v; kwargs...)
    return isapprox(u ⋅ v, 0; kwargs...)
end
