function start_pos(dist, n, L)
    opinions = zeros(n)
    if dist == "equi"
        opinions = range(0, stop=L, length=n)
    elseif dist == "unif"
        opinions = sort(L*rand(n))
    else
        opinions = []
        println("Wrong distribution")
    end
    return opinions
end
#start_pos("equi",10,6)
