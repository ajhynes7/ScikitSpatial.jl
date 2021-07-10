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


@testset "Is Parallel" begin
    @test is_parallel([1, 0], [1, 0])
    @test is_parallel([1, 0], [-1, 0])
    @test is_parallel([1, 0], [2, 0])

    @test is_parallel([1, 5], [1, 5])
    @test is_parallel([1, 5], [3, 15])
    @test is_parallel([1, 5], [-5, -25])

    @test is_parallel([1, 2, 3], [3, 6, 9])

    @test !is_parallel([1, 0], [1, 1])
    @test !is_parallel([1, 0], [1, 1e-2])
    @test is_parallel([1, 0], [1, 1e-2]; atol=1e-2)
end
