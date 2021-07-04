@testset "Line" begin
    line = Line([0, 0], [1, 0])

    @test line.point == [0, 0]
    @test line.direction == [1, 0]
end
