"""
    project(u::AbstractVector, v::AbstractVector) -> AbstractVector

Project vector `u` onto vector `v`.

# Examples

```jldoctest
julia> project([1, 1], [1, 0])
2-element Base.Vector{Float64}:
 1.0
 0.0

julia> project([5, 5], [1, 0])
2-element Base.Vector{Float64}:
 5.0
 0.0

julia> project([5, -5], [0, 1])
2-element Base.Vector{Float64}:
 -0.0
 -5.0
```

"""
function project(u::AbstractVector, v::AbstractVector)
    return (u ⋅ v) / (v ⋅ v) * v
end


"""
    project(point::AbstractVector, line::AbstractLine) -> StaticArrays.SVector

Project a point onto a line.


# Examples

```jldoctest
julia> project([1, 1], Line([0, 0], [1, 0]))
2-element StaticArrays.SVector{2, Float64} with indices SOneTo(2):
 1.0
 0.0

julia> project([5, -1], Line([0, 0], [1, 0]))
2-element StaticArrays.SVector{2, Float64} with indices SOneTo(2):
 5.0
 0.0

julia> project([1, 0], Line([0, 0], [1, 1]))
2-element StaticArrays.SVector{2, Float64} with indices SOneTo(2):
 0.5
 0.5

julia> point = project([1, 0, 0], Line([0, 0, 0], [1, 1, 1]));

julia> round.(point, digits=3)
3-element StaticArrays.SVector{3, Float64} with indices SOneTo(3):
 0.333
 0.333
 0.333
```

"""
function project(point::AbstractVector, line::AbstractLine)

    # Vector from the point on the line to the point in space.
    vector_to_point = Vector(line.point, point)

    # Vector projected onto the line.
    vector_projected = project(vector_to_point, line.direction)

    return line.point + vector_projected
end


"""
    project(point::AbstractVector, plane::AbstractPlane) -> StaticArrays.SVector

Project a point onto a plane.

# Examples

```jldoctest
julia> project([0, 0, 5], Plane([0, 0, 0], [0, 0, 1]))
3-element StaticArrays.SVector{3, Float64} with indices SOneTo(3):
 0.0
 0.0
 0.0

julia> plane = Plane([1,2,3], [1, 3, -2]);

julia> point_projected = project([5, 1, 3], plane);

julia> round.(point_projected, digits=3)
3-element StaticArrays.SVector{3, Float64} with indices SOneTo(3):
 4.929
 0.786
 3.143
```

"""
function project(point::AbstractVector, plane::AbstractPlane)

    # Vector from the point in space to the point on the plane.
    vector_to_plane_point = Vector(point, plane.point)

    # Perpendicular vector from the point in space to the plane.
    vector_to_plane = project(vector_to_plane_point, plane.normal)

    return point + vector_to_plane
end
