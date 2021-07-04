@testset "Cosine Similarity" begin
    @test cosine_similarity([1, 0], [1, 0]) == 1
    @test cosine_similarity([1, 0], [0, 1]) == 0
    @test cosine_similarity([1, 0], [1, 1]) ≈ √2 / 2

    @test cosine_similarity([1, 0, 0], [1, 0, 0]) == 1
    @test cosine_similarity([1, 0, 0], [0, 0, 1]) == 0
    @test cosine_similarity([1, 0, 0], [1, 1, 1]) ≈ √3 / 3
end

@testset "Angle between vectors" begin
    @test angle_between([1, 0], [1, 0]) == 0
    @test angle_between([1, 0], [0, 1]) ≈ π / 2
    @test angle_between([1, 0], [1, 1]) ≈ π / 4

    @test angle_between([1, 0, 0], [1, 0, 1]) ≈ π / 4
end
