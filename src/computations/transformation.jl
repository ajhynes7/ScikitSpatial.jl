using Statistics


"""
    Vector(point_a::AbstractVector, point_b::AbstractVector) -> AbstractVector

Return the vector from point A to point B.

# Examples

```jldoctest
julia> import ScikitSpatial: Vector

julia> Vector([0, 0], [1, 1])
2-element Base.Vector{Int64}:
 1
 1

julia> Vector([-1, 0], [1, 1])
2-element Base.Vector{Int64}:
 2
 1

julia> Vector([5, 2, -4], [3, -1, 9])
3-element Base.Vector{Int64}:
 -2
 -3
 13
```

"""
function Vector(point_a::AbstractVector, point_b::AbstractVector)
    return point_b - point_a
end


"""
    unit(v::AbstractVector) -> AbstractVector

Return the unit vector in the same direction as the input vector.

# Examples

```jldoctest
julia> unit([2, 0])
2-element Base.Vector{Float64}:
 1.0
 0.0

julia> round.(unit([1, 1]), digits=3)
2-element Base.Vector{Float64}:
 0.707
 0.707

julia> round.(unit([1, 1]), digits=3)
2-element Base.Vector{Float64}:
 0.707
 0.707

julia> round.(unit([-1, 1, -3]), digits=3)
3-element Base.Vector{Float64}:
 -0.302
  0.302
 -0.905
```
"""
function unit(v::AbstractVector)
    return v / norm(v)
end


"""
    to_point(line::AbstractLine, t::Int=1) -> AbstractVector

Return a point along the line.

# Examples

```jldoctest
julia> line = Line([1, 3], [2, -5]);

julia> to_point(line)
2-element StaticArrays.SVector{2, Int64} with indices SOneTo(2):
  3
 -2
```

"""
function to_point(line::AbstractLine; t::Int=1)
    return line.point + t * line.direction
end


"""
    centroid(points::AbstractMatrix) -> AbstractVector

Compute the centroid of multiple points.

The points are represented by a *D* x *N* array,
where *D* is the number of dimensions and *N* is the number of points.

# Examples

```jldoctest
julia> point_a = [-1, -1]; point_b = [0, 0]; point_c = [1, 1];

julia> points = hcat(point_a, point_b, point_c)
2×3 Matrix{Int64}:
 -1  0  1
 -1  0  1

julia> centroid(points)
2-element Base.Vector{Float64}:
 0.0
 0.0

julia> point_a = [5, -3, 2]; point_b = [2, 1, 3]; point_c = [8, 1, 9]; point_d = [2, 3, 3];

julia> points = hcat(point_a, point_b, point_c, point_d)
3×4 Matrix{Int64}:
  5  2  8  2
 -3  1  1  3
  2  3  9  3

julia> centroid(points)
3-element Base.Vector{Float64}:
 4.25
 0.5
 4.25
```

"""
function centroid(points::AbstractMatrix)
    return vec(mean(points, dims=2))
end


"""
    mean_center(points::AbstractMatrix) -> AbstractVector

Return a transformed set of points which are centered about the origin.

The centroid of the original points is treated as the origin for the new points.

# Examples

```jldoctest
julia> point_a = [5, 5]; point_b = [7, 7]; point_c = [9, 9];

julia> points = hcat(point_a, point_b, point_c)
2×3 Matrix{Int64}:
 5  7  9
 5  7  9

julia> mean_center(points)
2×3 Matrix{Float64}:
 -2.0  0.0  2.0
 -2.0  0.0  2.0
```
"""
function mean_center(points::AbstractMatrix)
    return points .- centroid(points)
end
