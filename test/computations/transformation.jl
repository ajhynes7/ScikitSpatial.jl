import ScikitSpatial: Vector


@testset "Vector from two points" begin
    @test Vector([0, 0], [0, 0]) == [0, 0]
    @test Vector([0, 0], [1, 0]) == [1, 0]
    @test Vector([1, 0, 1], [0, 0, 5]) == [-1, 0, 4]
end


@testset "Unit" begin
    for (vector, vector_unit_expected) in [
        ([1, 0], [1, 0])
        ([2, 0], [1, 0])
        ([5, 0], [1, 0])
        ([-5, 0], [-1, 0])
        ([1, 1], √2 / 2 * ones(2))
        ([1, 1, 1], √3 / 3 * ones(3))
    ]
        @test unit(vector) ≈ vector_unit_expected
    end
end


@testset "Centroid of points" begin
    points = [
        0 1;
        0 0;
    ]
    centroid_  = centroid(points)

    # Use type assertion to ensure centroid is a vector (not matrix).
    centroid_::AbstractVector

    @test centroid_ == [0.5, 0]

    points = [
        0 1 2;
        -1 3 5;
    ]
    @test centroid(points) ≈ [1, 7/3]

    points = [
        0 1 2;
        -1 3 5;
        2 5 9;
    ]
    @test centroid(points) ≈ [1, 7/3, 16/3]
end


@testset "Mean center points" begin

    points = [
        1 2 3;
        0 1 2;
    ]
    points_centered_expected = [
        -1 0 1;
        -1 0 1;
    ]

    @test mean_center(points) == points_centered_expected

    points = [
        -2 4;
        0 1;
        2 -3;
        5 2;
    ]
    points_centered_expected = [
        -3 3;
        -0.5 0.5;
        2.5 -2.5;
        1.5 -1.5;
    ]
    @test mean_center(points) == points_centered_expected
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
