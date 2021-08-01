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


function intersect(line::AbstractLine, circle::AbstractCircle)

    # Two points on the line.
    point_1 = line.point
    point_2 = point_1 + unit(line.direction)

    # Translate the points on the line to mimic the circle being centered on the origin.
    point_translated_1 = point_1 - circle.point
    point_translated_2 = point_2 - circle.point

    x_1, y_1 = point_translated_1
    x_2, y_2 = point_translated_2

    d_x = x_2 - x_1
    d_y = y_2 - y_1

    # Pre-compute variables common to x and y equations.
    d_r_squared = d_x^2 + d_y^2
    determinant = x_1 * y_2 - x_2 * y_1
    discriminant = circle.radius^2 * d_r_squared - determinant^2

    root = √discriminant

    mp = [-1, 1]  # Array to compute minus/plus.
    sign = d_y < 0 ? -1 : 1

    coords_x = (determinant * d_y .+ mp * sign * d_x * root) / d_r_squared
    coords_y = (-determinant * d_x .+ mp * abs(d_y) * root) / d_r_squared

    point_translated_a = [coords_x[1], coords_y[1]]
    point_translated_b = [coords_x[2], coords_y[2]]

    # Translate the intersection points back from origin circle to real circle.
    point_a = point_translated_a + circle.point
    point_b = point_translated_b + circle.point

    return point_a, point_b
end
