@testset "Vector-vector projection" begin

    x_unit = [1, 0]
    y_unit = [0, 1]

    project(x_unit, x_unit) == x_unit
    project(y_unit, y_unit) == y_unit

    # The projection is the zero vector if u and v are perpendicular.
    project(x_unit, y_unit) == [0, 0]
    project(y_unit, x_unit) == [0, 0]
    project([5, 3], [-3, 5]) == [0, 0]

    @test project([1, 0], x_unit) == [1, 0]
    @test project([1, 1], x_unit) == [1, 0]
    @test project([5, 5], x_unit) == [5, 0]
    @test project([5, -5], x_unit) == [5, 0]
    @test project([-5, 5], x_unit) == [-5, 0]

    # The magnitude of the second vector shouldn't matter.
    @test project([1, 0], 2 * x_unit) == [1, 0]

    @test project([1, 0], [1, 1]) == [0.5, 0.5]
    @test project([1, 2, 4], [5, 1, -1]) == [5, 1, -1] / 9
end


@testset "Point-line projection" begin

    line_x = Line([0, 0], [1, 0])
    @test project([0, 0], line_x) == [0, 0]
    @test project([10, 0], line_x) == [10, 0]
    @test project([0, 10], line_x) == [0, 0]
    @test project([10, 10], line_x) == [10, 0]

    line_diag = Line([0, 0], [1, 1])
    @test project([0, 0], line_diag) == [0, 0]
    @test project([1, 0], line_diag) == 0.5 * ones(2)

    line_diag_3d = Line([0, 0, 0], [1, 1, 1])
    @test project([1, 0, 0], line_diag_3d) == 1/3 * ones(3)

    # The magnitude of the direction vector should not matter.
    @test project([1, 0, 0], Line([0, 0, 0], -2 * ones(Int, 3))) == 1/3 * ones(3)

    @test project([50, 10], Line([1, -5], [0, 3])) == [1, 10]
end


@testset "Point-plane projection" begin

    plane_xy = Plane([0, 0, 0], [0, 0, 1])

    @test project([0, 0, 0], plane_xy) == [0, 0, 0]
    @test project([1, 0, 0], plane_xy) == [1, 0, 0]
    @test project([50, -34, 0], plane_xy) == [50, -34, 0]
    @test project([50, -34, 50], plane_xy) == [50, -34, 0]
    @test project([50, -34, -150], plane_xy) == [50, -34, 0]

    # The magnitude of the plane normal should not matter.
    @test project([50, -34, -150], Plane([0, 0, 0], [0, 0, 5])) == [50, -34, 0]
    @test project([50, -34, -150], Plane([0, 0, 0], [0, 0, -5])) == [50, -34, 0]

    @test project([50, -34, -150], Plane([0, 0, -5], [0, 0, 1])) == [50, -34, -5]
    @test project([50, -34, -150], Plane([18, 23, -5], [0, 0, 1])) == [50, -34, -5]

    @test project([50, -34, -150], Plane([18, 23, -5], [0, 0, 1])) == [50, -34, -5]

    @test project([7, -3, 5], Plane([1, 2, 3], [1, 1, 1])) == [6, -4, 4]
end
