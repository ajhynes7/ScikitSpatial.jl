function project(u::AbstractVector, v::AbstractVector)
    return (u ⋅ v) / (v ⋅ v) * v
end


function project(point::AbstractVector, line::AbstractLine)

    # Vector from the point on the line to the point in space.
    vector_to_point = Vector(line.point, point)

    # Vector projected onto the line.
    vector_projected = project(vector_to_point, line.direction)

    return line.point + vector_projected
end


function project(point::AbstractVector, plane::AbstractPlane)

    # Vector from the point in space to the point on the plane.
    vector_to_plane_point = Vector(point, plane.point)

    # Perpendicular vector from the point in space to the plane.
    vector_to_plane = project(vector_to_plane_point, plane.normal)

    return point + vector_to_plane
end
