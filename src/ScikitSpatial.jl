module ScikitSpatial

using LinearAlgebra
using StaticArrays


export

    # Composite types (structs)
    Line,

    # Measurement
    cosine_similarity,
    angle_between,

    # Comparison
    is_zero,

    # Projection
    project,

    # Transformation
    Vector


include("types.jl")
include("measurement.jl")
include("comparison.jl")
include("projection.jl")
include("transformation.jl")

end
