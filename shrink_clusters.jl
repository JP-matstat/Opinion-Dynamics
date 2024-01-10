function shrink_clusters(new_cl_posNsize)
    #new_rows = length(unique(new_cl_posNsize[:,1]))
    merged_clusters = new_cl_posNsize
    skip = Bool(1)

    for i in 1:size(merged_clusters)[1]
        match_clusters = findall(new_cl_posNsize[:,1] .== new_cl_posNsize[i,1])
        if length(match_clusters) > 1 && skip
            skip = Bool(0) #Bool(skip - length(match_clusters) + 1)
            merged_clusters[match_clusters[1],2] = sum(new_cl_posNsize[match_clusters,2])
            to_delete = match_clusters[2:end]
            merged_clusters = merged_clusters[setdiff(1:end, to_delete), :]
        end
        #if skip < 1
        #    skip = Bool(skip + 1)
        #end
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