@testset "Intersection of two lines" begin

    line_a = Line([0, 0], [1, 0])
    line_b = Line([0, 0], [0, 1])
    @test intersect(line_a, line_b) == [0, 0]

    line_b = Line([5, -3], [0, 1])
    @test intersect(line_a, line_b) == [5, 0]

    @test intersect(Line([0, 0], [1, 1]), Line([1, 0], [1, -1])) == [0.5, 0.5]

    @test intersect(Line([0, 0, 0], [1, 1, 1]), Line([1, 1, 0], [0, 0, 1])) ≈ ones(3)

    line = Line([0, 0], [1, 1])
    line_almost_parallel = Line([1, 0], [1, 1.01])
    intersect(line, line_almost_parallel)

    message = "The lines are parallel."
    @test_throws ArgumentError(message) intersect(Line([0, 0], [1, 1]), Line([1, 0], [1, 1]))

    message = "The lines are not coplanar."
    line_a = Line([0, 0, 0], [1, 0, 0])
    line_b = Line([0, 1, 0], [0, 0, 1])
    @test_throws ArgumentError(message) intersect(line_a, line_b)
end


@testset "Intersection of plane and line" begin

    origin = [0, 0, 0]

    line = Line(origin, [0, 0, 1])
    plane = Plane(origin, [0, 0, 1])

    @test intersect(plane, line) == [0, 0, 0]
    @test intersect(plane, Line([3, 5, 2], [0, 0, 1])) == [3, 5, 0]

    message = "The line and plane are parallel."
    @test_throws ArgumentError(message) intersect(plane, Line(origin, [1, 0, 0]))

    # The line is almost parallel to the plane.
    # This throws an error if the tolerance is large enough.
    line_almost_parallel = Line(zeros(3), [1, 0, 1e-2])
    intersect(plane, line_almost_parallel)
    @test_throws ArgumentError(message) intersect(plane, line_almost_parallel; atol=1e-2)
end


@testset "Intersection of circle/sphere and line" begin

    for (circle_or_sphere, line, point_expected_a, point_expected_b) in [
        (Circle([0, 0], 1), Line([0, 0], [1, 0]), [-1, 0], [1, 0]),
        (Circle([0, 0], 1), Line([0, 0], [0, 1]), [0, -1], [0, 1]),
        (Circle([0, 0], 1), Line([0, 1], [1, 0]), [0, 1], [0, 1]),
        (
            Circle([0.0, 0], 1),
            Line([0, 0.5], [1, 0]),
            [-√3 / 2, 0.5],
            [√3 / 2, 0.5],
        ),
        (Circle([1, 0], 1), Line([0, 0], [1, 0]), [0, 0], [2, 0]),
        (Circle([1.5, 0], 1), Line([0.0, 0], [1, 0]), [0.5, 0], [2.5, 0]),
        (Sphere([0, 0, 0], 1), Line([0, 0, 0], [1, 0, 0]), [-1, 0, 0], [1, 0, 0]),
    ]

        point_a, point_b = intersect(circle_or_sphere, line)

        @test point_a == point_expected_a && point_b == point_expected_b
    end
end
