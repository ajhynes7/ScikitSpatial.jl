import Base: isapprox


"""
    is_zero(v; kwargs...)

Check if a vector is the zero vector.

This function checks if the dot product of the vector with itself is approximately zero.
Keyword arguments can be passed along to `isapprox`.

# Examples

```jldoctest
julia> is_zero([0, 0])
true

julia> is_zero([1, 0])
false

julia> is_zero([0, 1e-3])
false

julia> is_zero([0, 1e-3], atol=1e-2)
true
```

"""
function is_zero(v; kwargs...)
    isapprox(v ⋅ v, 0; kwargs...)
end


@doc raw"""
    are_parallel(u, v; kwargs...) -> Bool

Check if two vectors are parallel.

Two nonzero vectors `u` and `v` are parallel if

```math
\lvert \texttt{cosine\_similarity}(u, v) \rvert = 0
```

The zero vector is considered to be parallel to all vectors.

Keyword arguments can be passed along to `isapprox`.
The tolerances are used to check if the vector is zero,
or if the vectors are otherwise parallel.

# Examples

```jldoctest
julia> are_parallel([1, 0], [1, 0])
true

julia> are_parallel([1, 0], [5, 0])
true

julia> are_parallel([1, 0], [-5, 0])
true

julia> are_parallel([5, 3], [-10, -6])
true

julia> are_parallel([5, 3], [-10, 6])
false
```

The zero vector is considered to be parallel to all vectors.

```jldoctest
julia> are_parallel([0, 0], [1, 1])
true

julia> are_parallel([1, 1], [0, 0])
true
```

The tolerances are used to check if the vector is zero,
or if the vectors are otherwise parallel.

```jldoctest
julia> are_parallel([1, 1], [0, 1e-3])
false

julia> are_parallel([1, 1], [0, 1e-3], atol=1e-2)
true

julia> are_parallel([1, 1], [1, 1.01])
false

julia> are_parallel([1, 1], [1, 1.01], atol=1e-2)
true
```
"""
function are_parallel(u, v; kwargs...)

    if is_zero(u; kwargs...) || is_zero(v; kwargs...)
        return true
    end

    similarity = cosine_similarity(u, v)

    return isapprox(abs(similarity), 1; kwargs...)
end


@doc raw"""
    are_perpendicular(u, v; kwargs...) -> Bool

Check if two vectors are perpendicular.

Two vectors `u` and `v` are perpendicular if

```math
u \cdot v = 0
```

Keyword arguments can be passed along to `isapprox`.

"""
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


function isapprox(line_a::AbstractLine, line_b::AbstractLine; kwargs...)

    point_on_surface = on_surface(line_a.point, line_b; kwargs...)
    directions_parallel = are_parallel(line_a.direction, line_b.direction; kwargs...)

    return point_on_surface && directions_parallel
end
