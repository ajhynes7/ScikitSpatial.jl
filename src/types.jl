struct Line{N, T}

    point::SVector{N, T}
    direction::SVector{N, T}

    function Line(point::SVector{N, T}, direction::SVector{N, T}; kwargs...) where {N, T}

        if is_zero(direction; kwargs...)
            throw(ArgumentError("The direction must have a non-zero magnitude."))
        end

        new{N, T}(point, direction)
    end
end


function Line(point::AbstractVector, direction::AbstractVector; kwargs...)

    n_elements = length(point)
    type_elements = eltype(point)

    point_static = SVector{n_elements, type_elements}(point)
    direction_static = SVector{n_elements, type_elements}(direction)

    return Line(point_static, direction_static; kwargs...)
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
