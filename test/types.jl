@testset "Line" begin
    line = Line([0, 0], [1, 0])

    @test line.point == [0, 0]
    @test line.direction == [1, 0]

    # The `vector` field is an alias for `direction`.
    @test line.vector == [1, 0]

    # The point and direction must be abstract vectors.
    @test_throws MethodError Line(0, [1, 0])
    @test_throws MethodError Line([0, 0], 1)
    @test_throws MethodError Line([0 0; 0 0], [1, 0])
    @test_throws MethodError Line([0, 0], [1 0; 0 0])

    message = "The point and direction must have the same length."
    @test_throws ArgumentError(message) Line([0], [1, 0])
    @test_throws ArgumentError(message) Line([0, 0], [1, 0, 0])
    @test_throws ArgumentError(message) Line([0, 0, 0], [1, 0])

    message = "The direction must have a non-zero magnitude."
    @test_throws ArgumentError(message) Line([0, 0], [0, 0])

    # The direction magnitude can be checked with a tolerance.
    Line([0, 0], [1e-2, 0])
    @test_throws ArgumentError(message) Line([0, 0], [1e-2, 0]; atol=1e-4)

    @test Line(zeros(1), [1]).dimension == 1
    @test Line(zeros(2), [1, 0]).dimension == 2
    @test Line(zeros(3), [1, 0, 0]).dimension == 3
    @test Line(zeros(4), [1, 0, 0, 0]).dimension == 4
end
