function update_open_m_cl(data, r, old_merged_cluster)
    cl_posNsize = old_merged_cluster
    cl_pos = cl_posNsize[:,1]
    new_cl_posNsize = zeros(axes(cl_posNsize))
    println(cl_posNsize)
    new_cl_posNsize[:,2] = cl_posNsize[:,2]
    rows = size(cl_posNsize)[1]
    sum_cl = zeros(rows)
    # Update clusters with regard to open minded clusters
    for i in 1:rows
        left_o = findall(x -> x >= cl_posNsize[i,1] - 1, cl_pos)[1]
        right_o = findall(x -> x <= cl_posNsize[i,1] + 1, cl_pos)[end]
        #@info i, left_o, right_o
        if left_o == right_o
            sum_cl[i] = cl_pos[i]*cl_posNsize[i,2]
            #@info i, sum_cl[i]
        else
            for j in left_o:right_o
                sum_cl[i] = sum_cl[i] + cl_posNsize[j,1]*cl_posNsize[j,2]
            end
        end
        #ClusterPosNSize = cl_posNsize
        if sum(r) == size(data)[1]
            sum_cl[i] = sum_cl[i]/sum(cl_posNsize[left_o:right_o,2])
        else
            d_close, left_c, right_c = update_close_m(data, r, i, cl_posNsize)
            @info i, left_c, right_c, d_close[left_c], d_close[right_c]
            sum_cl[i] = (sum_cl[i] + sum(d_close[left_c:right_c]))/(sum(cl_posNsize[left_o:right_o,2]) + (right_c-left_c+1))
        end
        new_cl_posNsize[i,1] = sum_cl[i]
    end
    merged_clusters = shrink_clusters(new_cl_posNsize)
    while size(merged_clusters)[1] < size(new_cl_posNsize)[1]
        new_cl_posNsize = merged_clusters
        merged_clusters = shrink_clusters(merged_clusters)
    end

    return merged_clusters
end
# new_cl_posNsize, right_o, left_o = update_open_m_cl(d, r)
