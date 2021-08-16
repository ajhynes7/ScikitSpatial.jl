@testset "Circle/Sphere construction" begin

    for (type, dim_allowed) in zip([Circle, Sphere], [2, 3])
        for dim in 1:4
            point = zeros(Int64, dim)

            if dim == dim_allowed
                obj = type(point, 1)
                @test isa(obj.point, SVector{dim, Int64})
            else
                message = "The dimension of the point must be $dim_allowed"
                @test_throws ArgumentError(message) type(point, 1)
            end
        end
    end
end
