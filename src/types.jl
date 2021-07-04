struct Line
    point::AbstractVector
    direction::AbstractVector

    function Line(point::AbstractVector, direction::AbstractVector)

        if length(point) != length(direction)
            throw(ArgumentError("The point and direction must have the same length."))
        end

        new(point, direction)
    end
end
