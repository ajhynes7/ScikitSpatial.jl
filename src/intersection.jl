import ScikitSpatial: intersect


function intersect(line_a::AbstractLine, line_b::AbstractLine)

    if !are_coplanar(line_a, line_b)
        throw(ArgumentError("The lines are not coplanar."))
    end

    if are_parallel(line_a.direction, line_b.direction)
        throw(ArgumentError("The lines are parallel."))
    end

    # Vector from line A to line B.
    vector_ab = Vector(line_a.point, line_b.point)

    # Vector perpendicular to both lines.
    vector_perpendicular = line_a.direction × line_b.direction

    num = (vector_ab × line_b.direction) ⋅ vector_perpendicular
    denom = norm(vector_perpendicular)^2

    # Vector along line A to the intersection point.
    vector_a_scaled = num / denom * line_a.direction

    return line_a.point + vector_a_scaled
end


function intersect(line::AbstractLine, plane::AbstractPlane; kwargs...)

    if are_perpendicular(line.direction, plane.normal; kwargs...)
        throw(ArgumentError("The line and plane are parallel."))
    end

    vector_plane_line = Vector(plane.point, line.point)

    num = -plane.normal ⋅ vector_plane_line
    denom = plane.normal ⋅ line.direction

    # Vector along the line to the intersection point.
    vector_line_scaled = num / denom * line.direction

    return line.point + vector_line_scaled
end
