function shrink_clusters2(cl_posNsize, new_cl_posNsize)
    merged_clusters = zeros(length(unique(new_cl_posNsize[:,1])),2)
    
    for i in 1:size(cl_posNsize)[1]
        match_clusters = findall(new_cl_posNsize[:,1] .== new_cl_posNsize[i,1])
        if length(match_clusters) == 1
            merged_clusters[i,:] = new_cl_posNsize[i,:]
        else length(match_clusters) > 1
            merged_clusters[match_clusters[1],2] = sum(new_cl_posNsize[match_clusters,2])
            merged_clusters[match_clusters[1],2] = new_cl_posNsize[match_clusters[1],1]
            i = i + 1
        end
    end
    #=
    if new_rows < size(cl_posNsize)[1]
        for i in axes(merged_clusters)[1]
            for j in axes(new_cl_posNsize)[1]
                if merged_clusters[i,1] == new_cl_posNsize[j,1]
                    merged_clusters[i,2] = merged_clusters[i,2] + cl_posNsize[j,2]
                end
            end
        end
    else
        merged_clusters = new_cl_posNsize
    end
    =#

    return merged_clusters
end