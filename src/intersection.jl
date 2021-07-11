import ScikitSpatial: intersect


function intersect(line::AbstractLine, plane::AbstractPlane; kwargs...)

    if is_perpendicular(line.direction, plane.normal; kwargs...)
        throw(ArgumentError("The line and plane are parallel."))
    end

    vector_plane_line = Vector(plane.point, line.point)

    num = -plane.normal ⋅ vector_plane_line
    denom = plane.normal ⋅ line.direction

    # Vector along the line to the intersection point.
    vector_line_scaled = num / denom * line.direction

    return line.point + vector_line_scaled
end
