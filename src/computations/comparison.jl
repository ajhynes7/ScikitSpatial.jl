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
    point_1 = points[:, 1]
    vectors = points .- point_1

    return rank(vectors) <= 2
end


function are_coplanar(line_a::AbstractLine, line_b::AbstractLine)

    point_a1 = line_a.point
    point_a2 = to_point(line_a)

    point_b1 = line_b.point
    point_b2 = to_point(line_b)

    points = hcat(point_a1, point_a2, point_b1, point_b2)

    return are_coplanar(points)
end


function on_surface(point::AbstractVector, line::AbstractLine; kwargs...)
    return isapprox(distance(point, line), 0; kwargs...)
end
