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
    are_parallel,
    are_perpendicular,
    are_coplanar,

    # Projection
    project,

    # Intersection
    intersect,

    # Transformation
    Vector,
    to_point,
    centroid,
    mean_center,

    # Plotting
    plot


include("types.jl")
include("measurement.jl")
include("comparison.jl")
include("projection.jl")
include("intersection.jl")
include("transformation.jl")
include("plotting.jl")

end
