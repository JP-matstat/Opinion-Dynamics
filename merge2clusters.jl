function merge2clusters(d, r)
    tick()
    to_delete = findall(x->x==0, r)
    d_open = d[setdiff(1:end, to_delete), :]
    #d_open_rounded = round.(d_open[:,end], digits = 14)
    cl_size = ClusterSizes(d_open, r)
    clusters = unique(d_open[:,end])
    cl_posNsize = hcat(clusters, cl_size)
    tock()
    return cl_posNsize
end
