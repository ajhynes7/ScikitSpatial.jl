function cosine_similarity(u, v)
    u ⋅ v / (norm(u) * norm(v))
end


function angle_between(u, v)
    acos(cosine_similarity(u, v))
end


function distance(point_a::AbstractVector, point_b::AbstractVector)
    return norm(Vector(point_a, point_b))
end


function distance(point::AbstractVector, line::AbstractLine)
    point_projected = project(point, line)
    return distance(point, point_projected)
end
