function project(u::AbstractVector, v::AbstractVector)
    return u ⋅ v / v ⋅ v * v
end


function project(point::AbstractVector, line::AbstractLine)
    vector_to_point = Vector(line.point, point)
    vector_projected = project(vector_to_point, line.direction)

    return line.point + vector_projected
end
