using Documenter
using StaticArrays
using Test

using ScikitSpatial


DocMeta.setdocmeta!(ScikitSpatial, :DocTestSetup, :(using ScikitSpatial); recursive=true)
doctest(ScikitSpatial)

include("types/base.jl")
include("computations/base.jl")
