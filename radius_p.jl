function radius_p(n, L, dist, prop_o, r_dist)
    opinions = start_pos(dist, n, L)
    steps = 1/prop_o
    if prop_o == 1
        r = ones(n)
        r_value = 1
    elseif prop_o > 0.5 && prop_o < 1
        prop_c = 1 - prop_o
        r = ones(n)
        r_value = Int(0)
        steps = Int(round(1/prop_c))
    else
        r = zeros(n)
        r_value = Int(1)
        steps = Int(round(1/prop_o))
    end

    if r_dist == "equi" && prop_o < 1
        for i in collect(1:steps:n)
            r[i] = r_value
        end
    else
        r = zeros(n)
        while sum(r) < round(n*prop_o, digits = 0)
            r[rand(1:n)] = Int(1)
        end
    end
    real_prop_o = sum(r)/n
    #println(real_prop_o)
    return r
end
#radius_p(7, 4, "equi", 0.5)



