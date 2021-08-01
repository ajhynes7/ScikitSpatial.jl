abstract type AbstractSpatial end

abstract type AbstractHyperplane <: AbstractSpatial end
abstract type AbstractHypersphere <: AbstractSpatial end

abstract type AbstractLine <: AbstractHyperplane end
abstract type AbstractPlane <: AbstractHyperplane end
abstract type AbstractCircle <: AbstractHypersphere end


for (type, supertype) in zip([:Line, :Plane], [:AbstractLine, :AbstractPlane])

    @eval struct $type{N, T} <: $supertype

        point::SVector{N, T}
        vector::SVector{N, T}

        function $type(point::SVector{N, T}, vector::SVector{N, T}; kwargs...) where {N, T}

            if is_zero(vector; kwargs...)
                throw(ArgumentError("The vector must have a non-zero magnitude."))
            end

            new{N, T}(point, vector)
        end
    end

    @eval function $type(point::AbstractVector, vector::AbstractVector; kwargs...)

        n_elements = length(point)
        type_elements = eltype(point)

        point_static = SVector{n_elements, type_elements}(point)
        vector_static = SVector{n_elements, type_elements}(vector)

        return $type(point_static, vector_static; kwargs...)
    end
end


for (type, alias) in zip(
    (:AbstractLine, :AbstractPlane),
    (:(:direction), :(:normal)),
)
    @eval function Base.getproperty(obj::$type, symbol::Symbol)

        if symbol === $alias
            return obj.vector
        end

        return getfield(obj, symbol)
    end
end


struct Circle{N, T} <: AbstractCircle
    point::SVector{N, T}
    radius::Real
end


function Circle(point::AbstractVector, radius::Real)

    n_elements = length(point)
    type_elements = eltype(point)

    point_static = SVector{n_elements, type_elements}(point)

    return Circle(point_static, radius)
end
