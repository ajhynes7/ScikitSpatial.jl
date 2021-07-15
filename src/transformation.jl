using Statistics


function Vector(point_a::AbstractVector, point_b::AbstractVector)
    return point_b - point_a
end


function to_point(line::AbstractLine; t::Int=1)
    return line.point + t * line.direction
end


function centroid(points::AbstractMatrix)
    return mean(points, dims=1)
end


function mean_center(points::AbstractMatrix)
    return points .- centroid(points)
end
