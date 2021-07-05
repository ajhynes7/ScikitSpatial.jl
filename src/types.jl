struct Line
    point::AbstractVector
    direction::AbstractVector

    function Line(point::AbstractVector, direction::AbstractVector; kwargs...)

        if length(point) != length(direction)
            throw(ArgumentError("The point and direction must have the same length."))
        end

        if is_zero(direction; kwargs...)
            throw(ArgumentError("The direction must have a non-zero magnitude."))
        end

        new(point, direction)
    end
end


function Base.getproperty(line::Line, symbol::Symbol)

    if symbol === :dimension
        return length(line.point)
    end

    if symbol === :vector
        return line.direction
    end

    return getfield(line, symbol)
end
