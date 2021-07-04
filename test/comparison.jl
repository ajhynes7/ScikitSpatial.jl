@testset "Is zero" begin
    @test is_zero([0])
    @test is_zero([0, 0])
    @test is_zero([0, 0, 0])

    @test !is_zero([1])
    @test !is_zero([1, 0])
    @test !is_zero([1, 0, 0])

    @test !is_zero([1e-2, 0, 0])
    @test is_zero([1e-2, 0, 0]; atol=1e-4)
    @test !is_zero([1e-1, 0, 0]; atol=1e-4)
end
