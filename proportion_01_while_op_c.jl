function proportion_01_while_op_c(n, L, dist, prop_o)
    n = Int(n)
    time_steps = Int(50)
    opinions = start_pos(dist, n, L)
    opinion_matrix = opinions
    #r_dist = "equi"
    r_dist = "unif"
    #r = radius_p(n, L, dist, prop_o, r_dist)
    if r_dist == "equi"
        r = radius_equi(n, prop_o)
    else
        r = radius_unif(n, prop_o)
    end

    counter = 1
    froozen = Bool(1)
    previous_opinions = zeros(n)
    op_c = n*sum(r)/length(r)
    to_delete = findall(x->x==0, r)
    froozen_plus_2 = 0
    #kounter = 0
    while froozen_plus_2 < 2
        #kounter = kounter + 1
        opinions = update_ss(opinions, r)
        froozen = (previous_opinions == opinions)
        if froozen == Bool(1)
            froozen_plus_2 = froozen_plus_2 + 1
        end
        previous_opinions = opinions
        opinion_matrix = vcat(opinion_matrix, opinions)
        counter = counter + 1
        open_m_cl = opinions[setdiff(1:end, to_delete)]
        op_c = length(unique(open_m_cl))
        @info counter, op_c, froozen, L, n, prop_o
    end
    update_ss_counter = counter
    opinion_matrix = reshape(opinion_matrix, (n, counter))
    old_merged_clusters = merge2clusters(opinion_matrix, r)
    merged_clusters = old_merged_clusters
    not_froozen = Bool(1)
    froozen_plus_3 = 0
    while froozen_plus_3 < 10
            old_merged_clusters = update_open_m_cl(opinion_matrix, r, merged_clusters)
            not_froozen = (merged_clusters != old_merged_clusters)
            if not_froozen == Bool(0)
                froozen_plus_3 = froozen_plus_3 + 1
            end
            merged_clusters = old_merged_clusters
            counter = counter + 1
            @info counter, not_froozen, size(merged_clusters), n, L
    end
    #opinion_matrix = reshape(opinion_matrix, (n, update_ss_counter))
    
    #=
    if counter < time_steps
        to_delete = findall(x->x==0, r)
        d_open = d[setdiff(1:end, to_delete), :]
        merged_clusters = unique(d_open[:,end])
    end
    =#
    #println("Number of open-minded clusters: ", length(unique(opinion_matrix[:,end])) - Int(n - sum(r)))
    #to_delete = findall(x->x==0, r)
    opinion_matrix_open = opinion_matrix[setdiff(1:end, to_delete), :]
    #merged_clusters = update_open_m_cl(opinion_matrix_open, r, merged_clusters) # En fuling
    
    rows = size(merged_clusters)[1]
    i = 1
    while i < rows
        if merged_clusters[i+1,1] - merged_clusters[i,1] < 0.1
            merged_clusters = update_open_m_cl(opinion_matrix_open, r, merged_clusters) # En fuling
        end
        rows = size(merged_clusters)[1]
        i = i + 1
    end
    while i < rows
        if merged_clusters[i+1,1] - merged_clusters[i,1] < 0.01
            merged_clusters = update_open_m_cl(opinion_matrix_open, r, merged_clusters) # En fuling
        end
        rows = size(merged_clusters)[1]
        i = i + 1
    end
    
    #print(unique(opinion_matrix[:,end]))
    #converges = (maximum(opinion_matrix_open[:,end]) - minimum(opinion_matrix_open[:,end-1]) <= 1)
    froozen = !not_froozen
    return opinion_matrix, counter, froozen, r, merged_clusters, r_dist
end
    # d, c, f, r, mc = proportion_01(10, 2, "equi", 0.9)
