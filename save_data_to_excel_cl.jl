function save_data_to_excel_cl(input)
    tick()
    # save_data_to_excel
    #using(Pkg)
    #Pkg.add("DataFrames")
    #using DataFrames
    #Pkg.add("CSV")
    #using CSV
    #Pkg.add("BenchmarkTools")
    #using BenchmarkTools
    df = DataFrame(n = Int[], L = Float64[], dist = String[], r_dist = String[], prop_o = Float64[], real_p_o = Float64[], op_c = Int[], counter = Int[], froozen = Bool[], interval = Float64[], clusters = Int[])
    #L_avr_cl = DataFrame(L = Float64[], avr_cl_over_rep = Float64[])
    #prop_o_cl = DataFrame(prop_o = Float64[]; nr_clusters = Float64[])
    #n = Int(1e2)
    #L = 4
    #dist = "unif"
    dist = "equi"
    clusters = 0
    repetitions = 1
    global L_position = Int(1)
    for prop_o in collect(range(0.01, 1, length=100))  
        for u in collect(1:repetitions)
            for L in [8] #collect(range(5, 9, length = 100)) #[5, 7, 9, 11, 13, 15]
                for n in [input] #collect(range(input, input + 10, length = 11)) #collect(range(1, 1000, length=10))  #[1e2, 1e3, 1e4, 1e5] #[input, input + 1, input + 2, input + 3, input*10, input*10 + 1, input*10 + 2, input*10 + 3]
                    n = Int(n)
                    #@time local dataf, counter, not_froozen, r = proportion_01(n, L, dist, prop_o)
                    #global dataf, counter, not_froozen, r = proportion_01(n, L, dist, prop_o)
                    #global dataf, counter, not_froozen, r, merged_clusters = proportion_01_cl(n, L, dist, prop_o)
                    global dataf, counter, froozen, r, merged_clusters, r_dist = proportion_01_while_op_c(n, L, dist, prop_o)
                    real_p_o = sum(r)/n
                    #println(merged_clusters)
                    #println(size(merged_clusters)[1])
                    clusters = size(merged_clusters)[1]
                    real_prop_o = sum(r)/n
                    op_c = length(unique(dataf[:,end])) - Int(round(n*(1-real_p_o),digits=0))
                    #op_c = length(unique(dataf[:,end])) - Int(round(n*(1-prop_o),digits=0))
                    #froozen = Bool(1 - froozen)
                    interval = interval_size(dataf, L)
                    push!(df, (n, L, dist, r_dist, prop_o, real_p_o, op_c, counter, froozen, interval, clusters))              
                end
            end
        end
        #avr_cl_over_rep = sum(df[L_position:L_position + repetitions-1, 5])/repetitions
        L_position = L_position + repetitions
        #push!(L_avr_cl, (L, avr_cl_over_rep))

        to_delete = findall(x->x==0, r)
        global d_open = dataf[setdiff(1:end, to_delete), :]
        #global clusters = ClusterSizes(d_open, r)
    end

    #CSV.write("C:\\Users\\johan\\OneDrive\\Dokument\\Opinion Dynamics\\Julia\\2022-01-03\\dataframe.csv", df)
    #CSV.write("G:\\Min enhet\\Opinion Dynamics\\2023\\Julia\\2023-02-01\\dataframe.csv", df)
    CSV.write("G:\\Min enhet\\Opinion Dynamics\\2023 Februari\\dataframe1.csv", df)

    #print(df)
    #CSV.write("G:\\Min enhet\\Opinion Dynamics\\2023\\Julia\\2023-02-01\\L_avr_cl.csv", L_avr_cl)
    #print(L_avr_cl)
    m = ave_cl_nr(df, repetitions, clusters)
    #CSV.write("G:\\Min enhet\\Opinion Dynamics\\2023 Februari\\dataframe2.csv", m)
    tock()
    return df, repetitions, dataf, m, r, merged_clusters
end
# df, rep, data, m, r, mc = save_data_to_excel_cl()
