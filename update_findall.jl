function update_findall(opinions, r)
    n = length(opinions)
    #permutation = shuffle(collect(range(1, n, length = n)))
    #permutation = map(x -> Int(round(x)), permutation)
    #opinions = map(x -> Int(round(x)), opinions)
    new_opinions = zeros(n)
    for i in 1:n #permutation
        if r[i] == 0
            new_opinions[i] = opinions[i]
        else
            l_v = findall(opinions.>=opinions[i] - 1)
            if isempty(l_v)
                l_N = 1
            else
                l_N = l_v[1]
            end
            r_v = findall(opinions.<=opinions[i] + 1)[end]
            if isempty(r_v)
                r_N = 1
            else
                r_N = r_v[end]
            end
            new_opinions[i] = sum(opinions[l_N:r_N])/(r_N - l_N + 1)
        end
    end
    return new_opinions
end
