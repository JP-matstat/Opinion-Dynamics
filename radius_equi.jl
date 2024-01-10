function radius_equi(n, prop_o)
    #opinions = start_pos(dist, n, L)
    r = zeros(n)
    if prop_o == 0.5
        r[1:2:end] .= Int(1)
    elseif prop_o == 0.1
        r[1:10:end] .= Int(1)
    elseif prop_o == 0.2
        r[1:5:end] .= Int(1)
    elseif prop_o == 0.25
        r[1:4:end] .= Int(1)
    elseif prop_o == 0.33
        r[1:3:end] .= Int(1)
    elseif prop_o == 1
        r = ones(n)

    end

    return r
end
# radius_equi(10, 6, equi, 0.5)