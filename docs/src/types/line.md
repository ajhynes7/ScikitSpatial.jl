# Line

A line is defined by a point and a direction vector.

```@meta
DocTestSetup = quote
    using ScikitSpatial
end
```

```jldoctest line
julia> line = Line([0, 0], [1, 0])
Line{2, Int64}([0, 0], [1, 0])

julia> line.point
2-element StaticArrays.SVector{2, Int64} with indices SOneTo(2):
 0
 0

julia> line.vector
2-element StaticArrays.SVector{2, Int64} with indices SOneTo(2):
 1
 0
```

The direction vector can also be accessed with the `direction` field.

```jldoctest line
julia> line.direction
2-element StaticArrays.SVector{2, Int64} with indices SOneTo(2):
 1
 0
```
