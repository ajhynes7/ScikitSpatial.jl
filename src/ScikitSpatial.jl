module ScikitSpatial

using LinearAlgebra

export

    # Composite types (structs)
    Line,

    cosine_similarity,
    angle_between

include("types.jl")
include("measurement.jl")

end
