import Base: intersect


"""
    intersect(line_a::AbstractLine, line_b::AbstractLine) -> AbstractVector

Compute the intersection of two lines.

The intersection of two lines is a point.

# Examples

```jldoctest
julia> intersect(Line([0, 0], [1, 0]), Line([5, 5], [0, 1]))
2-element StaticArrays.SVector{2, Float64} with indices SOneTo(2):
 5.0
 0.0
```

"""
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


function intersect(plane::AbstractPlane, line::AbstractLine; kwargs...)

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


function intersect(plane_a::AbstractPlane, plane_b::AbstractPlane)

    array_normals_stacked = vcat(plane_a.normal', plane_b.normal')

    array_11 = 2 * Matrix(1I, 3, 3)
	array_12 = array_normals_stacked'
	array_21 = array_normals_stacked
	array_22 = zeros(2, 2)

	matrix = vcat(hcat(array_11, array_12), hcat(array_21, array_22))

    dot_a = plane_a.point ⋅ plane_a.normal
    dot_b = plane_b.point ⋅ plane_b.normal

    y = [0, 0, 0, dot_a, dot_b]

    solution = matrix \ y

    point = solution[1:3]
	direction = plane_a.normal × plane_b.normal

    return Line(point, direction)
end


function intersect(circle::Circle, line::AbstractLine)

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


function intersect(sphere::Sphere, line::AbstractLine)

    vector_to_line = Vector(sphere.point, line.point)
    direction_unit = unit(line.direction)

    dot = direction_unit ⋅ vector_to_line

    discriminant = dot^2 - (norm(vector_to_line)^2 - sphere.radius^2)

    if discriminant < 0
        throw(ArgumentError("The line does not intersect the sphere."))
    end

    pm = [-1, 1]  # Array to compute minus/plus.
    distances = -dot .+ √discriminant * pm

    points = line.point .+ distances' .* direction_unit

    point_a = points[:, 1]
    point_b = points[:, 2]

    return point_a, point_b
end
