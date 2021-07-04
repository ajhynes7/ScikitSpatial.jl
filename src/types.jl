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


function Base.getproperty(line::Line, symbol::Symbol)

    if symbol === :dimension
        return length(line.point)
    end

    return getfield(line, symbol)
end
