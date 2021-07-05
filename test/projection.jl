@testset "Vector-vector projection" begin
    @test project([1, 0], [1, 0]) == [1, 0]
    @test project([1, 1], [1, 0]) == [1, 0]
    @test project([5, 5], [1, 0]) == [5, 0]
    @test project([5, -5], [1, 0]) == [5, 0]
    @test project([-5, 5], [1, 0]) == [-5, 0]
end

@testset "Point-line projection" begin
    line = Line([0, 0], [1, 0])

    @test project([0, 0], line) == [0, 0]
    @test project([10, 0], line) == [10, 0]
    @test project([0, 10], line) == [0, 0]
    @test project([10, 10], line) == [10, 0]
end
