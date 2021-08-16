abstract type AbstractSpatial end

abstract type AbstractHyperplane <: AbstractSpatial end
abstract type AbstractHypersphere end

abstract type AbstractLine <: AbstractHyperplane end
abstract type AbstractPlane <: AbstractHyperplane end



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


struct Hypersphere{N, T} <: AbstractHypersphere where {N, T}

    point::SVector{N, T}
    radius::Real

    function Hypersphere(point::SVector{N, T}, radius::Real) where {N, T}
        if radius <= 0
            throw(ArgumentError("The radius must be positive."))
        end

        return new{N, T}(point, radius)
    end
end


function Hypersphere(point::AbstractVector, radius::Real)

    n_elements = length(point)
    type_elements = eltype(point)

    point_static = SVector{n_elements, type_elements}(point)

    return Hypersphere(point_static, radius)
end


const Circle = Hypersphere{2, T} where {T}
const Sphere = Hypersphere{3, T} where {T}


for (type, dim) in zip([:Circle, :Sphere], [2, 3])

    @eval function $type(point::AbstractVector, radius::Real)

        if length(point) != $dim
            throw(ArgumentError("The dimension of the point must be " * string($dim)))
        end

        return Hypersphere(point, radius)
    end
end
