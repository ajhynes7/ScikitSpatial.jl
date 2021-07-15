@testset "Line-line intersection" begin

    line_a = Line([0, 0], [1, 0])
    line_b = Line([0, 0], [0, 1])
    @test intersect(line_a, line_b) == [0, 0]

    line_b = Line([5, -3], [0, 1])
    @test intersect(line_a, line_b) == [5, 0]

    @test intersect(Line([0, 0], [1, 1]), Line([1, 0], [1, -1])) == [0.5, 0.5]

    @test intersect(Line([0, 0, 0], [1, 1, 1]), Line([1, 1, 0], [0, 0, 1])) ≈ ones(3)

    line = Line([0, 0], [1, 1])
    line_almost_parallel = Line([1.0, 0], [1, 1.01])
    intersect(line, line_almost_parallel)

    message = "The lines are parallel."
    @test_throws ArgumentError(message) intersect(Line([0, 0], [1, 1]), Line([1, 0], [1, 1]))

    message = "The lines are not coplanar."
    line_a = Line([0, 0, 0], [1, 0, 0])
    line_b = Line([0, 1, 0], [0, 0, 1])
    @test_throws ArgumentError(message) intersect(line_a, line_b)
end


@testset "Line-plane intersection" begin

    origin = [0, 0, 0]

    line = Line(origin, [0, 0, 1])
    plane = Plane(origin, [0, 0, 1])

    @test intersect(line, plane) == [0, 0, 0]
    @test intersect(Line([3, 5, 2], [0, 0, 1]), plane) == [3, 5, 0]

    message = "The line and plane are parallel."
    @test_throws ArgumentError(message) intersect(Line(origin, [1, 0, 0]), plane)

    # The line is almost parallel to the plane.
    # This throws an error if the tolerance is large enough.
    line_almost_parallel = Line(zeros(3), [1, 0, 1e-2])
    intersect(line_almost_parallel, plane)
    @test_throws ArgumentError(message) intersect(line_almost_parallel, plane; atol=1e-2)
end
