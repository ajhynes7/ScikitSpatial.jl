abstract type AbstractHypersphere <: AbstractSpatial end


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
    point_static = _convert_to_svector(point)
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
