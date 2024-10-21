function out = islinearlyindependent(M)
    out = (rank(M) == size(M,2));
end
