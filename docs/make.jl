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
        "Computations" => [
            "Measurement" => "computations/measurement.md",
            "Projection" => "computations/projection.md",
        ]
    ]
)
