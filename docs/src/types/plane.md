# Plane

A plane is defined by a point and a normal vector.

```jldoctest plane
julia> using ScikitSpatial

julia> plane = Plane([0, 0, 0], [0, 0, 1])
Plane{3, Int64}([0, 0, 0], [0, 0, 1])

julia> plane.point
3-element StaticArrays.SVector{3, Int64} with indices SOneTo(3):
 0
 0
 0

julia> plane.vector
3-element StaticArrays.SVector{3, Int64} with indices SOneTo(3):
 0
 0
 1
```

The normal vector can also be accessed with the `normal` field.

```jldoctest plane
julia> plane.normal
3-element StaticArrays.SVector{3, Int64} with indices SOneTo(3):
 0
 0
 1
```
