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

    points = hcat([0; 0; 1])
    @test are_coplanar(points)

    points = [
        0 1;
        0 1;
        1 2;
    ]
    @test are_coplanar(points)

    points = [
        0 1 5;
        0 1 2;
        1 2 7;
    ]
    @test are_coplanar(points)

    # points = [
    #     0 0 1;
    #     1 1 0;
    #     5 2 0;
    #     6 -2 0;
    # ]
    points = [
        0 1 5 6;
        0 1 2 -2;
        1 0 0 0;
    ]
    @test !are_coplanar(points)

    points = [
        0 1 2 3;
        0 1 2 3;
        0 1 2 3;
    ]
    @test are_coplanar(points)

    points = [
        5 1 5 6;
        7 1 2 -2;
        4 4 4 4;
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
    points = [
        0 1 2 3;
        0 1 2 3;
        0 1 2 3;
    ]
    @test are_coplanar(points)
end


@testset "Point on surface of line" begin
    for (point, line, bool_expected) in [
        ([0, 0], Line([0, 0], [1, 0]), true)
        ([2, 0], Line([0, 0], [5, 0]), true)
        ([2, 0], Line([0, 0], [-5, 0]), true)
        ([0, 0], Line([0, 0], [1, 1]), true)
        ([1, 0], Line([0, 0], [1, 1]), false)
        ([1, 0], Line([0, 0], [1, 1]), false)
    ]
        @test on_surface(point, line) == bool_expected
    end

    for (point, line, atol, bool_expected) in [
        ([0, 1e-2], Line([0, 0], [1, 0]), 1e-2, true)
        ([0, 1e-2], Line([0, 0], [1, 0]), 1e-3, false)
    ]
        @test on_surface(point, line; atol=atol) == bool_expected
    end
end

@testset "Lines are approximately equal" begin
    for (line_a, line_b, bool_expected) in [
        (Line([0, 0], [1, 0]), Line([0, 0], [1, 0]), true),
        (Line([0, 0], [1, 0]), Line([0, 0], [5, 0]), true),
        (Line([0, 0], [1, 0]), Line([0, 0], [-1, 0]), true),
        (Line([0, 0], [1, 0]), Line([0, 0], [-5, 0]), true),
        (Line([3, 0], [1, 0]), Line([0, 0], [-5, 0]), true),
        (Line([-3, 0], [1, 0]), Line([0, 0], [-5, 0]), true),
        (Line([0, 1], [1, 0]), Line([0, 0], [1, 0]), false),
        (Line([0, -1], [1, 0]), Line([0, 0], [1, 0]), false),
        (Line([0, 0], [1, 0]), Line([0, 0], [1, 1]), false),
    ]
        @test isapprox(line_a, line_b) == bool_expected
    end

    for (line_a, line_b, atol, bool_expected) in [
        (Line([0, 1e-2], [1, 0]), Line([0, 0], [1, 0]), 1e-2, true),
        (Line([0, 1e-2], [1, 0]), Line([0, 0], [1, 0]), 1e-3, false),
        (Line([0, 0], [1, 1]), Line([0, 0], [1, 1.01]), 1e-2, true),
        (Line([0, 0], [1, 1]), Line([0, 0], [1, 1.01]), 1e-5, false),
    ]
        @test isapprox(line_a, line_b; atol=atol) == bool_expected
    end
end
