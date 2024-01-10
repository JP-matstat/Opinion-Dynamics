function proportion_01_cl(n, L, dist, prop_o)
    n = Int(n)
    time_steps = Int(11)
    opinions = start_pos(dist, n, L)
    opinion_matrix = opinions
    r_dist = "equi"
    r = radius_p(n, L, dist, prop_o, r_dist)
    
    counter = 1
    not_froozen = Bool(1)
    previous_opinions = zeros(n)
    while counter < time_steps && not_froozen
    #while maximum(opinions)-minimum(opinions) >= 1 || length(unique(opinions)) > 2
        #opinions = update_p(opinions, r, counter)
        #if counter % 2 == 1
        #    opinions = update_p(opinions, r, counter)
        #else
        #    opinions = update_p_reversed(opinions, r, counter)
        #end
        #opinions = update_findall(opinions, r)
        opinions = update_ss(opinions, r)
        not_froozen = (previous_opinions != opinions)
        previous_opinions = opinions
        opinion_matrix = vcat(opinion_matrix, opinions)
        counter = counter + 1
        @info counter
    end
    update_ss_counter = counter
    while counter >= time_steps && not_froozen 
        if counter == time_steps
            dataf = reshape(opinion_matrix, (n, counter))
            old_merged_clusters = merge2clusters(dataf, r)
        end
        while not_froozen
            merged_clusters = old_merged_clusters
            old_merged_clusters, not_froozen = update_open_m_cl(dataf, r, merged_clusters)
            counter = counter + 1
            @info counter
        end
    end
    opinion_matrix = reshape(opinion_matrix, (n, update_ss_counter))
    if counter < time_steps
        to_delete = findall(x->x==0, r)
        d_open = d[setdiff(1:end, to_delete), :]
        merged_clusters = unique(d_open[:,end])
    end
    #println("Number of open-minded clusters: ", length(unique(opinion_matrix[:,end])) - Int(n - sum(r)))
    to_delete = findall(x->x==0, r)
    opinion_matrix_open = opinion_matrix[setdiff(1:end, to_delete), :]
    #print(unique(opinion_matrix[:,end]))
    #converges = (maximum(opinion_matrix_open[:,end]) - minimum(opinion_matrix_open[:,end-1]) <= 1)
    return opinion_matrix, counter, not_froozen, r, merged_clusters
end
    # d, c, f, r = proportion_01(10, 2, "equi", 0.9)
