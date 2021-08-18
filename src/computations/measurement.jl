"""
    cosine_similarity(u::AbstractVector, v::AbstractVector) -> Float

Compute the cosine similarity of two vectors.

# Examples

```jldoctest
julia> cosine_similarity([1, 0], [1, 0])
1.0

julia> round(cosine_similarity([1,1], [1,0]), digits=3)
0.707

julia> cosine_similarity([1, 0], [0, 1])
0.0

julia> cosine_similarity([-1, 0], [1, 0])
-1.0

julia> round(cosine_similarity([1,0,0], [1,1,1]), digits=3)
0.577
```

"""
function cosine_similarity(u::AbstractVector, v::AbstractVector)
    u ⋅ v / (norm(u) * norm(v))
end


"""
    angle_between(u::AbstractVector, v::AbstractVector) -> Float

Compute the angle between two vectors. The angle is returned in radians.

# Examples

```jldoctest
julia> angle_between([1, 0], [1, 0])
0.0

julia> round(angle_between([1,1], [1,0]), digits=3)
0.785

julia> round(angle_between([1, 0], [0, 1]), digits=3)
1.571

julia> round(angle_between([-1, 0], [1, 0]), digits=3)
3.142

julia> round(angle_between([1,0,0], [1,1,1]), digits=3)
0.955
```

"""
function angle_between(u::AbstractVector, v::AbstractVector)
    acos(cosine_similarity(u, v))
end


"""
    distance(point_a::AbstractVector, point_b::AbstractVector) -> Float

Compute the distance between two points.

# Examples

```jldoctest
julia> distance([0, 0], [0, 0])
0.0

julia> distance([1, 0], [0, 0])
1.0

julia> round(distance([1, 1], [2, 2]), digits=3)
1.414

julia> round(distance([0, 0, 0], [-1, -1, -1]), digits=3)
1.732
```

"""
function distance(point_a::AbstractVector, point_b::AbstractVector)
    return norm(Vector(point_a, point_b))
end


"""
    distance(point_a::AbstractVector, point_b::AbstractVector) -> Float

Compute the distance from a point to a line.

This is the distance from the point to its projection on the line.


# Examples

```jldoctest
julia> distance([0, 0], Line([0, 0], [1, 0]))
0.0

julia> round(distance([1, 0], Line([0, 0], [1, 1])), digits=3)
0.707

julia> round(distance([1, 2, 3], Line([-1, 3, 2], [7, 4, 2])), digits=3)
1.978
```

"""
function distance(point::AbstractVector, line::AbstractLine)
    point_projected = project(point, line)
    return distance(point, point_projected)
end
