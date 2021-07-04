function is_zero(v; kwargs...)
    isapprox(v ⋅ v, 0; kwargs...)
end
