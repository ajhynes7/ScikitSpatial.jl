# Circle and Sphere

The `Circle` and `Sphere` types are defined by a point (representing the centre), and a radius.

```@meta
DocTestSetup = quote
    using ScikitSpatial
end
```

```jldoctest
julia> circle = Circle([0,0], 1)
Circle{Int64}([0, 0], 1)

julia> circle.point
2-element StaticArrays.SVector{2, Int64} with indices SOneTo(2):
 0
 0

julia> circle.radius
1
```

For a circle, the point must be 2D.

```jldoctest
julia> Circle([0, 0], 1)
Circle{Int64}([0, 0], 1)

julia> Circle([0, 0, 0], 1)
ERROR: ArgumentError: The dimension of the point must be 2
```

For a sphere, it must be 3D.

```jldoctest
julia> Sphere([0, 0], 1)
ERROR: ArgumentError: The dimension of the point must be 3

julia> Sphere([0, 0, 0], 1)
Sphere{Int64}([0, 0, 0], 1)
```
