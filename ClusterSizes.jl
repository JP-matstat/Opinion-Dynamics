function ClusterSizes(d_open, r)
    nr_cl = length(unique(d_open[:,end]))
        clusters = zeros(nr_cl)
        for k in 1:nr_cl-1
            clusters[k] = count(j->(only(unique(d_open[:,end])[k])<= j < only(unique(d_open[:,end])[k+1])), d_open[:,end])
        end
        clusters[end] = sum(r) - sum(clusters)
    return clusters
end