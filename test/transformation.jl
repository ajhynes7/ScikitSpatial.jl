import ScikitSpatial: Vector


@testset "Vector from two points" begin
    @test Vector([0, 0], [0, 0]) == [0, 0]
    @test Vector([0, 0], [1, 0]) == [1, 0]
    @test Vector([1, 0, 1], [0, 0, 5]) == [-1, 0, 4]
end


@testset "Centroid of points" begin
    @test centroid([0 0; 1 0]) == [0.5 0]
    @test centroid([0 -1; 1 3; 2 5]) ≈ [1 7/3]
    @test centroid([0 -1 2; 1 3 5; 2 5 9]) ≈ [1 7/3 16/3]
end


@testset "Mean center points" begin
    @test mean_center([1 0; 2 1; 3 2]) == [-1 -1; 0 0; 1 1]
    @test mean_center([
        -2 0 2 5;
        4 1 -3 2
    ]) == [
        -3 -0.5 2.5 1.5;
        3 0.5 -2.5 -1.5
    ]
end


@testset "To point" begin
    line = Line([0, 0], [1, 0])

    @test to_point(line) == [1, 0]
    @test to_point(line; t=1) == [1, 0]
    @test to_point(line; t=2) == [2, 0]
    @test to_point(line; t=-1) == [-1, 0]

    line = Line([1, 2, 3], [1, 2, 3])

    @test to_point(line) == [2, 4, 6]
    @test to_point(line; t=1) == [2, 4, 6]
    @test to_point(line; t=2) == [3, 6, 9]
    @test to_point(line; t=-1) == [0, 0, 0]
end
