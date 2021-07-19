using PyPlot

import PyPlot: plot


function _connect_points(ax, point_a::SVector{2, T}, point_b::SVector{2, T}; kwargs...) where {T}

    X = point_a[1], point_b[1]
    Y = point_a[2], point_b[2]

    ax.plot(X, Y; kwargs...)
end


function _connect_points(ax, point_a::SVector{3, T}, point_b::SVector{3, T}; kwargs...) where {T}

    X = point_a[1], point_b[1]
    Y = point_a[2], point_b[2]
    Z = point_a[3], point_b[3]

    ax.plot(X, Y, Z; kwargs...)
end


function plot(ax, point::SVector{2, T}; kwargs...) where {T}
    x, y = point
    ax.scatter(x, y; kwargs...)
end


function plot(ax, line::AbstractLine; t_1::Int = 0, t_2::Int = 1, kwargs...)

    point_a = to_point(line, t=t_1)
    point_b = to_point(line, t=t_2)

    _connect_points(ax, point_a, point_b; kwargs...)
end
