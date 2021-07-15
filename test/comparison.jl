@testset "Is zero" begin
    @test is_zero([0])
    @test is_zero([0, 0])
    @test is_zero([0, 0, 0])

    @test !is_zero([1])
    @test !is_zero([1, 0])
    @test !is_zero([1, 0, 0])

    @test !is_zero([1e-2, 0, 0])
    @test is_zero([1e-2, 0, 0]; atol=1e-4)
    @test !is_zero([1e-1, 0, 0]; atol=1e-4)
end


@testset "Is Parallel" begin
    @test are_parallel([1, 0], [1, 0])
    @test are_parallel([1, 0], [-1, 0])
    @test are_parallel([1, 0], [2, 0])

    @test are_parallel([1, 5], [1, 5])
    @test are_parallel([1, 5], [3, 15])
    @test are_parallel([1, 5], [-5, -25])

    @test are_parallel([1, 2, 3], [3, 6, 9])

    @test !are_parallel([1, 0], [1, 1])
    @test !are_parallel([1, 0], [1, 1e-2])
    @test are_parallel([1, 0], [1, 1e-2]; atol=1e-2)

    # The zero vector is parallel to all vectors.
    @test are_parallel([0, 0], [1, 0])
    @test are_parallel([0, 0], [5, 3])
    @test are_parallel([3, 4], [0, 0])
    @test are_parallel([3, 4, -21], [0, 0, 0])

    @test !are_parallel([0, 1e-2], [1, 0])
    @test are_parallel([0, 1e-2], [1, 0]; atol=1e-2)
    @test !are_parallel([1, 0], [0, 1e-2])
    @test are_parallel([1, 0], [0, 1e-2]; atol=1e-2)
end


@testset "Is Perpendicular" begin
    @test are_perpendicular([1, 0], [0, 1])
    @test are_perpendicular([0, 1], [-1, 0])
    @test !are_perpendicular([1, 0], [1, 0])
    @test are_perpendicular([50, 0], [0, 2])

    @test are_perpendicular([5, 2], [2, -5])
    @test are_perpendicular([1, 1, 0], [0, 0, 1])

    @test !are_perpendicular([1, 0], [1e-2, 1])
    @test are_perpendicular([1, 0], [1e-2, 1]; atol=1e-2)
end


@testset "Are coplanar" begin

    # Any three or fewer points are coplanar.
    points = [
        0 0 1;
    ]
    @test are_coplanar(points)

    points = [
        0 0 1;
        1 1 2;
    ]
    @test are_coplanar(points)

    points = [
        0 0 1;
        1 1 2;
        5 2 7;
    ]
    @test are_coplanar(points)

    points = [
        0 0 1;
        1 1 0;
        5 2 0;
        6 -2 0;
    ]
    @test !are_coplanar(points)

    points = [
        0 0 0;
        1 1 1;
        2 2 2;
        3 3 3;
    ]
    @test are_coplanar(points)

    points = [
        5 7 4;
        1 1 4;
        5 2 4;
        6 -2 4;
    ]
    @test are_coplanar(points)

    # Duplicates do not matter.
    points = [
        0 0 0;
        1 1 1;
        2 2 2;
        3 3 3;
        3 3 3;
    ]
    @test are_coplanar(points)
end
