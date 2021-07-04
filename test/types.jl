@testset "Line" begin
    line = Line([0, 0], [1, 0])

    @test line.point == [0, 0]
    @test line.direction == [1, 0]

    # The point and direction must be abstract vectors.
    @test_throws MethodError Line(0, [1, 0])
    @test_throws MethodError Line([0, 0], 1)
    @test_throws MethodError Line([0 0; 0 0], [1, 0])
    @test_throws MethodError Line([0, 0], [1 0; 0 0])

    message = "The point and direction must have the same length."
    @test_throws ArgumentError(message) Line([0], [1, 0])
    @test_throws ArgumentError(message) Line([0, 0], [1, 0, 0])
    @test_throws ArgumentError(message) Line([0, 0, 0], [1, 0])
end
