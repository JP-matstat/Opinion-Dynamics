function ave_cl_nr(d, rep, clusters)
    cluster_v = zeros(size(d)[1])
    nr_prop_o = zeros(length(clusters)) #zeros(length(unique(d[:,6])))
    k = 0
    m = DataFrame(prop_o = Float64[]; nr_clusters = Float64[])
    for i in eachindex(nr_prop_o)   #1:length(nr_prop_o)
        nr_prop_o[i] = mean(d[1+k*rep:(k+1)*rep, 5])
        k = k + 1
        #prop_o = only(unique(d[:,6])[i])
        prop_o = only(unique(d[:,6])[i])
        nr_clusters = only(nr_prop_o[i])
        push!(m, (prop_o, nr_clusters))
    end
    p = clusters #unique(d[:,6])
    m = reduce(hcat, (p, nr_prop_o))
    m = DataFrame(x = [p, nr_prop_o])
    return m

    #CSV.write("G:\\Min enhet\\Opinion Dynamics\\2023\\Julia\\2023-02-01\\dataframe2.csv", df)
end
