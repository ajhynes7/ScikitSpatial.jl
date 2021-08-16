using Formatting


@testset "$type" for type in [Line, Plane]

    # The object can be constructed from static arrays.
    type(SA[0, 0, 0], SA[1, 0, 0])

    # It can also be constructed from normal arrays.
    obj = type([0, 0], [1, 0])

    @test obj.point isa SVector{2, Int}
    @test obj.point == [0, 0]

    @test obj.vector isa SVector{2, Int}
    @test obj.vector == [1, 0]

    # The point and vector must be Julia vectors (one-dimensional arrays).
    @test_throws MethodError type(0, [1, 0])
    @test_throws MethodError type([0, 0], 1)
    @test_throws MethodError type([0 0; 0 0], [1, 0])
    @test_throws MethodError type([0, 0], [1 0; 0 0])

    template = "expected input array of length {}, got length {}"
    @test_throws DimensionMismatch(format(template, 1, 2)) type([0], [1, 0])
    @test_throws DimensionMismatch(format(template, 2, 3)) type([0, 0], [1, 0, 0])
    @test_throws DimensionMismatch(format(template, 3, 2)) type([0, 0, 0], [1, 0])

    message = "The vector must have a non-zero magnitude."
    @test_throws ArgumentError(message) type([0, 0], [0, 0])

    # The vector magnitude can be checked with a tolerance.
    type([0.0, 0], [1e-2, 0])
    @test_throws ArgumentError(message) type([0.0, 0], [1e-2, 0]; atol=1e-4)
end


@testset "Vector aliases" begin
    for (type, alias) in zip((:Line, :Plane), (:direction, :normal))
        eval(
            quote
                obj = $type([0, 0], [1, 0])

                @test obj.$alias isa SVector{2, Int}
                @test obj.$alias == [1, 0]
            end
        )
    end
end


@testset "Circle" begin

    circle = Circle([0, 0], 1)

    @test circle.point == [0, 0]
    @test circle.radius == 1

    @test obj.point isa SVector{2, Int}
end
