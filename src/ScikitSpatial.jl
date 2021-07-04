module ScikitSpatial

using LinearAlgebra

export

    # Composite types (structs)
    Line,

    # Measurement
    cosine_similarity,
    angle_between,

    # Comparison
    is_zero


include("types.jl")
include("measurement.jl")
include("comparison.jl")

end
