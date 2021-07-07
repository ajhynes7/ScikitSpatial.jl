using Formatting
using StaticArrays


@testset "Line" begin

    # A line can be constructed from static arrays.
    Line(SA[0, 0, 0], SA[1, 0, 0])

    # It can also be constructed from normal arrays.
    line = Line([0, 0], [1, 0])

    @test line.point isa SVector{2, Int}
    @test line.point == [0, 0]

    @test line.direction isa SVector{2, Int}
    @test line.direction == [1, 0]

    # The `vector` field is an alias for `direction`.
    @test line.vector isa SVector{2, Int}
    @test line.vector == [1, 0]

    # The point and direction must be vectors (one-dimensional arrays).
    @test_throws MethodError Line(0, [1, 0])
    @test_throws MethodError Line([0, 0], 1)
    @test_throws MethodError Line([0 0; 0 0], [1, 0])
    @test_throws MethodError Line([0, 0], [1 0; 0 0])

    template = "expected input array of length {}, got length {}"
    @test_throws DimensionMismatch(format(template, 1, 2)) Line([0], [1, 0])
    @test_throws DimensionMismatch(format(template, 2, 3)) Line([0, 0], [1, 0, 0])
    @test_throws DimensionMismatch(format(template, 3, 2)) Line([0, 0, 0], [1, 0])

    message = "The direction must have a non-zero magnitude."
    @test_throws ArgumentError(message) Line([0, 0], [0, 0])

    # The direction magnitude can be checked with a tolerance.
    Line([0.0, 0], [1e-2, 0])
    @test_throws ArgumentError(message) Line([0.0, 0], [1e-2, 0]; atol=1e-4)

    @test Line([0], [1]).dimension == 1
    @test Line([0, 0], [1, 0]).dimension == 2
    @test Line([0, 0, 0], [1, 0, 0]).dimension == 3
    @test Line([0, 0, 0, 0], [1, 0, 0, 0]).dimension == 4
end
