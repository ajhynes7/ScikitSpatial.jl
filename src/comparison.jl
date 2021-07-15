function is_zero(v; kwargs...)
    isapprox(v ⋅ v, 0; kwargs...)
end


function are_parallel(u, v; kwargs...)

    if is_zero(u; kwargs...) || is_zero(v; kwargs...)
        return true
    end

    similarity = cosine_similarity(u, v)

    return isapprox(abs(similarity), 1; kwargs...)
end


function are_perpendicular(u, v; kwargs...)
    return isapprox(u ⋅ v, 0; kwargs...)
end


function are_coplanar(points::AbstractMatrix)
    point_1 = points[1, :]
    vectors = points .- reshape(point_1, 1, length(point_1))

    return rank(vectors) <= 2
end
