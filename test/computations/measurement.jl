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

@testset "Distance between points" begin
    for (point_a, point_b, distance_expected) in [
        ([0], [0], 0),
        ([0], [1], 1),
        ([0], [-1], 1),
        ([0, 0], [0, 1], 1),
        ([0, 0], [1, 1], √2),
        ([0, 0, 0], [1, 1, 1], √3),
    ]
        @test distance(point_a, point_b) ≈ distance_expected
    end
end

@testset "Distance from point to line" begin
    for (point, line, distance_expected) in [
        ([0, 0], Line([0, 0], [1, 0]), 0),
        ([1, 0], Line([0, 0], [1, 0]), 0),
        ([1, 1], Line([0, 0], [1, 0]), 1),
        ([1, 1], Line([0, 0], [1, 1]), 0),
        ([1, 1], Line([0, 0], [-1, -1]), 0),
        ([8, 7], Line([0, 0], [1, 0]), 7),
        ([20, -3], Line([0, 0], [1, 0]), 3),
        ([20, -3, 1], Line([0, 0, 0], [1, 0, 0]), √10),
    ]
        @test distance(point, line) ≈ distance_expected
    end
end
