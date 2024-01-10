function proportion_01(n, L, dist, prop_o)
    n = Int(n)
    time_steps = Int(150000)
    opinions = start_pos(dist, n, L)
    opinion_matrix = opinions
    r_dist = "equi"
    #r = radius_p(n, L, dist, prop_o, r_dist)
    r = radius_equi(n, prop_o)
    
    counter = 1
    not_froozen = Bool(1)
    previous_opinions = zeros(n)
    while counter < time_steps && not_froozen
    #while maximum(opinions)-minimum(opinions) >= 1 || length(unique(opinions)) > 2
        opinions = update_p(opinions, r, counter)
        #if counter % 2 == 1
        #    opinions = update_p(opinions, r, counter)
        #else
        #    opinions = update_p_reversed(opinions, r, counter)
        #end
        #opinions = update_findall(opinions, r)
        #opinions = update_ss(opinions, r)
        not_froozen = (previous_opinions != opinions)
        previous_opinions = opinions
        opinion_matrix = vcat(opinion_matrix, opinions)
        counter = counter + 1
        #@info counter
    end
    opinion_matrix = reshape(opinion_matrix, (n, counter))
    #println("Number of open-minded clusters: ", length(unique(opinion_matrix[:,end])) - Int(n - sum(r)))
    to_delete = findall(x->x==0, r)
    opinion_matrix_open = opinion_matrix[setdiff(1:end, to_delete), :]
    println("Nr open cl ", length(unique(opinion_matrix_open[:,end])))
    #print(unique(opinion_matrix[:,end]))
    #converges = (maximum(opinion_matrix_open[:,end]) - minimum(opinion_matrix_open[:,end-1]) <= 1)
    return opinion_matrix, counter, not_froozen, r
end
    # d, c, f, r = proportion_01(10, 2, "equi", 0.9)
