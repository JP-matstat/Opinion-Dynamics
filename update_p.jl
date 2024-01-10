function update_p(opinions, r, counter)
    n = length(opinions)
    l_N = 1
    r_N = 1
    l_N_previous = l_N
    r_N_previous = r_N
    previous_opinion_sum = opinions[1]
    epsilon = sqrt(eps())
    new_opinions = zeros(n)

    for i in eachindex(opinions)
        if r[i] == 0
            new_opinions[i] = opinions[i]
            #@info i
        else
            if opinions[i] - opinions[1] <= 1 #+ epsilon
                l_N = 1
            else
                while opinions[i] >= opinions[l_N] + 1 #+ epsilon
                    l_N = l_N + 1
                end
            end
            if opinions[n] - opinions[i] <= 1 #+ epsilon
                r_N = n
            else
                while opinions[i] >= opinions[r_N] - 1 #+ epsilon
                    r_N = r_N + 1
                end
                r_N = r_N - 1
            end
            #@info i, l_N, r_N, n
            previous_opinion_sum = previous_opinion_sum + sum(opinions[r_N_previous+1:r_N]) - sum(opinions[l_N_previous:l_N-1])
            new_opinions[i] = previous_opinion_sum/(r_N - l_N + 1)
            l_N_previous = l_N
            r_N_previous = r_N
        end
    end
    return new_opinions
end
#new_o = update_p(opinions, 2, "prop", "equi", 1, 1, 1, 0)
