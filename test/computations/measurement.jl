@testset "Cosine Similarity" begin
    for (point_a, point_b, similarity_expected) in [
        ([1, 0], [0, 1], 0),
        ([1, 0], [1, 1], √2 / 2),
        ([1, 0, 0], [1, 0, 0], 1),
        ([1, 0, 0], [0, 0, 1], 0),
        ([1, 0, 0], [1, 1, 1], √3 / 3),
    ]
        @test cosine_similarity(point_a, point_b) ≈ similarity_expected
    end
end

@testset "Angle between vectors" begin
    for (point_a, point_b, angle_expected) in [
        ([1, 0], [1, 0], 0),
        ([1, 0], [0, 1], π / 2),
        ([1, 0], [1, 1], π / 4),
        ([1, 0, 0], [1, 0, 1], π / 4),
    ]
        @test angle_between(point_a, point_b) ≈ angle_expected
    end
end
