# ScikitSpatial.jl

A Julia implementation of the Python package [scikit-spatial](https://github.com/ajhynes7/scikit-spatial).

This package provides spatial types and computations between them.

The following types are provided:
- Line
- Plane

Most of the computations fall into the following categories:
- Measurement
- Comparison
- Projection
- Transformation


## Usage

### Composite types

A line has a point and direction vector. These are stored as static arrays from [StaticArrays.jl](https://github.com/JuliaArrays/StaticArrays.jl).

```jldoctest
julia> using ScikitSpatial

julia> line = Line([2, 3], [1, 2])
Line{2, Int64}([2, 3], [1, 2])

julia> line.point
2-element StaticArrays.SVector{2, Int64} with indices SOneTo(2):
 2
 3

julia> line.vector
2-element StaticArrays.SVector{2, Int64} with indices SOneTo(2):
 1
 2
```

The property `direction` can also be used to access the direction vector.

```
julia> line.direction
2-element StaticArrays.SVector{2, Int64} with indices SOneTo(2):
 1
 2
```

### Measurement

Measure the cosine similarity between two vectors.

```jldoctest
julia> round(cosine_similarity([1, 0], [1, 1]), digits=3)
0.707
```

### Projection

Project a vector onto a vector.

```jldoctest
julia> project([5, 3], [1, 1])
2-element Base.Vector{Float64}:
 4.0
 4.0
```

Project a point onto a line.

```jldoctest
julia> project([8, -2], line)
2-element StaticArrays.SVector{2, Float64} with indices SOneTo(2):
 1.2
 1.4
```
