module ScikitSpatial

using LinearAlgebra
using StaticArrays


export

    # Composite types (structs)
    Line,
    Plane,
    Circle,
    Sphere,

    # Measurement
    cosine_similarity,
    angle_between,

    # Comparison
    is_zero,
    are_parallel,
    are_perpendicular,
    are_coplanar,

    # Projection
    project,

    # Intersection
    intersect,

    # Transformation
    Vector,
    unit,
    to_point,
    centroid,
    mean_center


include("_util.jl")
include("types.jl")
include("measurement.jl")
include("comparison.jl")
include("projection.jl")
include("intersection.jl")
include("transformation.jl")

end
