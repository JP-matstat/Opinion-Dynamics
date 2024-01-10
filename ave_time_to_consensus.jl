function ave_time_to_consensus(d, rep)
    cluster_v = zeros(size(d)[1])
    nr_prop_o = zeros(length(unique(d[:,4])))
    k = 0
    m = DataFrame(prop_o = Float64[]; time_consensus = Float64[])
    for i in eachindex(nr_prop_o)   #1:length(nr_prop_o)
        nr_prop_o[i] = mean(d[1+k*rep:(k+1)*rep, 6])
        k = k + 1
        prop_o = only(unique(d[:,4])[i])
        time_consensus = only(nr_prop_o[i])
        push!(m, (prop_o, time_consensus))
    end
    #p = unique(d[:,4])
    #m = reduce(hcat, (p, nr_prop_o))
    #m = DataFrame(x = [p, nr_prop_o])
    return m

    CSV.write("G:\\Min enhet\\Opinion Dynamics\\2023\\Julia\\2023-02-01\\dataframe3.csv", m)
end
