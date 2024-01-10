function save_data_to_excel(input)
    tick()
    # save_data_to_excel
    #using(Pkg)
    #Pkg.add("DataFrames")
    #using DataFrames
    #Pkg.add("CSV")
    #using CSV
    #Pkg.add("BenchmarkTools")
    #using BenchmarkTools
    df = DataFrame(n = Int[], L = Float64[], dist = String[], prop_o = Float64[], op_c = Int[], counter = Int[], froozen = Bool[], interval = Float64[])
    L_avr_cl = DataFrame(L = Float64[], avr_cl_over_rep = Float64[])
    prop_o_cl = DataFrame(prop_o = Float64[]; nr_clusters = Float64[])
    #n = Int(1e2)
    #L = 4
    dist = "equi"
    repetitions = 1
    global L_position = Int(1)
    for prop_o in [1] #collect(range(0.01, 1, length = 100)) #collect(range(0, 0.99, length=100))  
        for u in collect(1:repetitions)
            for L in [10] #collect(range(5, 15, length=21)) #[5.3]
                for n in [input] #collect(range(1, 1000, length=1000)) # #[1e2, 1e3, 1e4, 1e5]
                    n = Int(n)
                    #@time local dataf, counter, not_froozen, r = proportion_01(n, L, dist, prop_o)
                    global dataf, counter, not_froozen, r = proportion_01(n, L, dist, prop_o)
                    #global dataf, counter, not_froozen, r = proportion_01_while_op_c(n, L, dist, prop_o)
                    #global dataf, counter, not_froozen, r, merged_clusters = proportion_01_cl(n, L, dist, prop_o)
                    op_c = length(unique(dataf[:,end])) - Int(round(n*(1-prop_o),digits=0))
                    froozen = Bool(1 - not_froozen)
                    interval = interval_size(dataf, L)
                    push!(df, (n, L, dist, prop_o, op_c, counter, froozen, interval))              
                end
                #@info L
            end
        end
        #avr_cl_over_rep = sum(df[L_position:L_position + repetitions-1, 5])/repetitions
        L_position = L_position + repetitions
        #push!(L_avr_cl, (L, avr_cl_over_rep))

        to_delete = findall(x->x==0, r)
        d_open = dataf[setdiff(1:end, to_delete), :]
         @info clusters = ClusterSizes(d_open, r)
    end

    #CSV.write("C:\\Users\\johan\\OneDrive\\Dokument\\Opinion Dynamics\\Julia\\2022-01-03\\dataframe.csv", df)
    #CSV.write("G:\\Min enhet\\Opinion Dynamics\\2023\\Julia\\2023-02-01\\dataframe.csv", df)
    CSV.write("G:\\Min enhet\\Opinion Dynamics\\2023 Februari\\dataframe1.csv", df)

    #print(df)
    #CSV.write("G:\\Min enhet\\Opinion Dynamics\\2023\\Julia\\2023-02-01\\L_avr_cl.csv", L_avr_cl)
    #print(L_avr_cl)
    #m = ave_cl_nr(df, repetitions, clusters)
    #CSV.write("G:\\Min enhet\\Opinion Dynamics\\2023 Februari\\dataframe2.csv", m)
    println("Fruset ", !not_froozen)
    m_cl = unique(dataf[:,end])
    tock()
    return df, repetitions, dataf, r, m_cl
end
# df, rep, data, m, r = save_data_to_excel()
