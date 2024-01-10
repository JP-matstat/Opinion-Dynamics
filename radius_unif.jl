function radius_unif(n, prop_o)
    r = zeros(n)
    random_nr = rand(n)
    for i in 1:n
        if random_nr[i] < prop_o
            r[i] = Int(1)
        end
    end
    return r
end