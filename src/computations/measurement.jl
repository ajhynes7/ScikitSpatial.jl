function cosine_similarity(u, v)
    u ⋅ v / (norm(u) * norm(v))
end

function angle_between(u, v)
    acos(cosine_similarity(u, v))
end
