function out = basisgrow(V)
B = [];

% iterate over each vector in V
for i = 1:size(V, 2)
    % get the i-th vector 
    % transpose it to a column vector
    v = V(:,i);

    % if B is empty, initialize it with the first vector
    if isempty(B)
        B = v;
     % append the new vector to B and call our LI helper
    else 
        % check if adding v keeps the set linearly independent
        M = [B, v];
        if islinearlyindependent(M)
            % if true, and v to B
            B = [B, v];
        end
    end
end
out = size(B, 2);