# Average number of clusters
function AverageNumberClusters(n)
    d, repetitions, od = save_data_to_excel(n)
    ave_cl = zeros(length(unique(d[:,4])))
    global i = 1
    global nr_prop_o = 1
    while nr_prop_o <= length(ave_cl)
        ave_cl[nr_prop_o] = mean(d[i:i + repetitions - 1, 5])
        global nr_prop_o = nr_prop_o + 1
        global i = i + repetitions
    end
    return ave_cl, d, od
    #print(od)
    
end