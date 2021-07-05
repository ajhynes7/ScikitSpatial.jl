import ScikitSpatial: Vector


@testset "Vector from two points" begin
    @test Vector([0, 0], [0, 0]) == [0, 0]
    @test Vector([0, 0], [1, 0]) == [1, 0]
    @test Vector([1, 0, 1], [0, 0, 5]) == [-1, 0, 4]
end
