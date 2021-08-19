push!(LOAD_PATH,"../src/")

using Documenter
using ScikitSpatial

DocMeta.setdocmeta!(ScikitSpatial, :DocTestSetup, :(using ScikitSpatial); recursive=true)

makedocs(
    sitename="ScikitSpatial.jl",
    modules=[ScikitSpatial],
    doctest=true,
    pages = [
        "Introduction" => "index.md",
        "Types" => [
            "types/line.md",
            "types/plane.md",
        ],
        "Computations" => [
            "Measurement" => "computations/measurement.md",
            "Projection" => "computations/projection.md",
        ],
    ]
)


deploydocs(
    repo = "github.com/ajhynes7/ScikitSpatial.jl.git",
)
