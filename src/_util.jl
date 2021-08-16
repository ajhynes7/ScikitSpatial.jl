function _convert_to_svector(vector::AbstractVector{T}) where {T <: Real}

    n_elements = length(vector)
    type_elements = eltype(vector)

    return SVector{n_elements, type_elements}(vector)
end


function _convert_to_svector(vectors)

    vector_first = vectors[1]

    n_elements = length(vector_first)
    type_elements = eltype(vector_first)

    vectors_static = []

    for vector in vectors
        push!(vectors_static, SVector{n_elements, type_elements}(vector))
    end

    return vectors_static
end
