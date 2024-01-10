function proportion_01_plot1(n, L, dist, prop_o)
    n = Int(n)
    time_steps = Int(50)
    opinions = start_pos(dist, n, L)
    opinion_matrix = opinions
    r_dist = "equi"
    #r_dist = "unif"
    #r = radius_p(n, L, dist, prop_o, r_dist)
    if r_dist == "equi"
        r = radius_equi(n, prop_o)
    else
        r = radius_unif(n, prop_o)
    end

    counter = 1
    not_froozen = Bool(1)
    previous_opinions = zeros(n)
    op_c = n*sum(r)/length(r)
    to_delete = findall(x->x==0, r)
    while not_froozen
        opinions = update_ss(opinions, r)
        not_froozen = (previous_opinions != opinions)
        previous_opinions = opinions
        opinion_matrix = vcat(opinion_matrix, opinions)
        counter = counter + 1
        #open_m_cl = opinions[setdiff(1:end, to_delete)]
        #op_c = length(unique(open_m_cl))
    end
    first_counter = counter
    update_ss_counter = counter
    dataf = reshape(opinion_matrix, (n, counter))
    old_merged_clusters = merge2clusters(dataf, r)
    merged_clusters = old_merged_clusters*2
    froozen = Bool(0)
    all_mer_cl = zeros(Int(sum(r)))
    not_froozen_cl = Bool(1)
    
    while not_froozen_cl #|| counter < 310
        not_froozen_cl = (merged_clusters != old_merged_clusters)
        #not_froozen_cl = Bool(0)
        merged_clusters = old_merged_clusters
        old_merged_clusters = update_open_m_cl(dataf, r, merged_clusters)
        update_ss_counter = update_ss_counter + 1
        index = 1
        till = 0
        v_mc = ones(Int(sum(r)))
        for j in 1:size(merged_clusters)[1]
            till = till + merged_clusters[j,2]
            v_mc[index:Int(till)] .= merged_clusters[j,1]
            index = index + Int(merged_clusters[j,2])
        end
        all_mer_cl = hcat(all_mer_cl, v_mc)
        #@info counter, not_froozen, size(v_mc), v_mc
    end
    
    opinion_matrix = reshape(opinion_matrix, (n, counter))
    kolumner = update_ss_counter - counter
    all_mer_cl = all_mer_cl[:,2:end]
    all_mer_cl = reshape(all_mer_cl, (Int(sum(r)), Int(kolumner)))
    if first_counter < counter
        all_mer_cl = reduce(hcat, all_mer_cl)
    end
    if counter < time_steps
        to_delete = findall(x->x==0, r)
        d_open = all_mer_cl[setdiff(1:end, to_delete), :]
        merged_clusters = unique(d_open[:,end])
    end
    #println("Number of open-minded clusters: ", length(unique(opinion_matrix[:,end])) - Int(n - sum(r)))
    to_delete = findall(x->x==0, r)
    opinion_matrix_open = opinion_matrix[setdiff(1:end, to_delete), :]
    #print(unique(opinion_matrix[:,end]))
    #converges = (maximum(opinion_matrix_open[:,end]) - minimum(opinion_matrix_open[:,end-1]) <= 1)
    
    return opinion_matrix, counter, froozen, r, merged_clusters, all_mer_cl
end
    # d, c, f, r, amc = proportion_01_plot1(10, 2, "equi", 0.9)
