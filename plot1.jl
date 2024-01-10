function plot1(agents)
    tick()
    #using Pkg
    #Pkg.add("PyPlot")
    #using PyPlot
    #n = Int(1e2)
    #L = 4
    dist = "equi"
    #prop_o = 1
    for u in collect(1:1)
        for L in [40] #collect(8:8)  collect(range(5.1, 7.0, length=50))
            for n in [agents]
                for prop_o in [1] #collect(range(0, 1, length=11))
                    n = Int(n)
                    #global d, counter, not_froozen, r = proportion_01(n, L, dist, prop_o)
                    global d, counter, not_froozen, r, mer_cl, all_mer_cl = proportion_01_plot1(n, L, dist, prop_o)                  
                    #global d, counter, not_froozen, r = proportion_01_while_op_c(n, L, dist, prop_o)
                    local op_c = length(unique(d[:,end])) - Int(round(n*(1-prop_o),digits=0))
                    froozen = Bool(1 - not_froozen)
                    print("Froozen: ", froozen, " ")
                    print("Open clusters: ", op_c, " ")
                    print("Cluster distance: ", round(d[end,end] - d[1,end]; digits = 3))
                    #push!(df, (n, L, dist, prop_o, op_c, counter, froozen))
                end
            end
        end
    end
    print(" Counter ", counter)
    PyPlot.clf()
    
    to_delete = findall(x->x==0, r)
    d_open = d[setdiff(1:end, to_delete), :]
   
    pygui(true)

    #=
    rows = size(d_open)[1]
    columns = size(d_open)[2]
    for i in 1:rows
        x = collect(1:columns-1)
        y = (d_open[i,1:end-1])
        display(plt.plot(x, y, linewidth=2.0, linestyle="-"))
    end

    println(size(d_open))
    println(size(all_mer_cl))
    =#

    #=
    println(size(d_open)[2])
    println("all_mer_cl ", size(all_mer_cl))
    rows = size(all_mer_cl)[1]
    columns = size(all_mer_cl)[2]
    println(size(d_open)[2]+columns-1)
    for i in 1:rows
        x = collect(size(d_open)[2]+1:size(d_open)[2]+columns-1)
        y = (all_mer_cl[i,1:end-1])
        display(plt.plot(x, y, linewidth=2.0, linestyle="-"))
    end
    =#
    

    d_open = hcat(d_open, all_mer_cl)
    rows = size(d_open)[1]
    columns = size(d_open)[2]
    for i in 1:rows
        x = collect(1:columns-1)
        y = (d_open[i,1:end-1])
        plt.plot(x, y, linewidth=2.0, linestyle="-")
    end

    clusters = ClusterSizes(d_open, r)

    plt.legend()
    gcf()
    tock()
    return d_open, clusters, all_mer_cl
end
    
    #savefig("C:\\Users\\johan\\OneDrive\\Dokument\\Opinion Dynamics\\Julia\\n6.png")
    