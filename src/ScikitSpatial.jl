module ScikitSpatial

using LinearAlgebra
using StaticArrays


export

    # Composite types (structs)
    Line,
    Plane,

    # Measurement
    cosine_similarity,
    angle_between,

    # Comparison
    is_zero,
    is_parallel,
    is_perpendicular,
    are_coplanar,

    # Projection
    project,

    # Intersection
    intersect,

    # Transformation
    Vector


include("types.jl")
include("measurement.jl")
include("comparison.jl")
include("projection.jl")
include("intersection.jl")
include("transformation.jl")

end
