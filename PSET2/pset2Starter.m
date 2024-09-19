clear all;

% Given matrix a and vector b from the pset2Starter.m file
a = [ 0.6319    0.2710    0.1788    0.7075    0.0483    0.9887    0.2945    0.6184    0.3532    0.6819 
        0    0.4175    0.6078    0.2151    0.1220    0.5958    0.6395    0.9147    0.2467    0.8972
        0         0    0.1490    0.7063    0.0807    0.8347    0.6563    0.2434    0.7766    0.6804
        0         0         0    0.4258    0.2133    0.8493    0.3473    0.5010    0.8115    0.9080
        0         0         0         0    0.3399    0.1983    0.0393    0.1723    0.9792    0.9941
        0         0         0         0         0    0.3544    0.7249    0.0914    0.6420    0.8030
        0         0         0         0         0         0    0.3622    0.8130    0.7589    0.3029
        0         0         0         0         0         0         0    0.9745    0.5066    0.5533
        0         0         0         0         0         0         0         0    0.0912    0.3514
        0         0         0         0         0         0         0         0         0    0.9362];

b = [0.3429
     0.5243
     0.9816
     0.3595
     0.8800
     0.6246
     0.9441
     0.2452
     0.5530
     0.3220];

n = 10;  
x = zeros(n, 1);  

x(n) = b(n) / a(n, n);  

for i = n-1:-1:1
    runningsum = 0;
    for j = i+1:n
        runningsum = runningsum + a(i, j) * x(j);
    end
    x(i) = (b(i) - runningsum) / a(i, i);
end

% function definition for back substitution
function x = backSub(A, b)
    [n, ~] = size(A);  % determine the size of matrix A
    x = zeros(n, 1);  % initialize solution vector
    
    x(n) = b(n) / A(n, n);  % solve for x_n
    for i = n-1:-1:1
        runningsum = 0;
        for j = i+1:n
            runningsum = runningsum + A(i, j) * x(j);
        end
        x(i) = (b(i) - runningsum) / A(i, i);
    end
end


x_backSub = backSub(a, b);

% solve using Matlab's built-in method
Mlabx = a \ b;

% compare result using the norm
difference_norm = norm(x_backSub - Mlabx);

% display the results
disp('solution using backSub fun:');
disp(x_backSub);
disp('solution using Matlab built-in solver:');
disp(Mlabx);
disp('difference norm:');
disp(difference_norm);

% part (i): matrix modification
a_modified = a;
a_modified(10, 10) = 0;  % modify the last entry

% try to solve the modified system
    x_modified = backSub(a_modified, b);
    disp('Solution for modified system using backSub fun:');
    disp(x_modified);

    Mlabx_modified = a_modified \ b;
    disp('Solution for modified system using Matlab built-in solver:');
    disp(Mlabx_modified);

function out = islinearlyindependent(M)
    % get number of vectors (columns) in the matrix M
    [~, n] = size(M);
    
    % check if rank of the matrix is equal to the number of vectors (columns)
    if rank(M) == n
        out = 1;  % the vectors are linearly independent
    else
        out = 0;  % the vectors are linearly dependent
    end
end
load('dataMatrices.mat');
disp('Linear Independence Test:');
disp('Matrix A1:');
result_A1 = islinearlyindependent(dataMatrix1);
disp(result_A1);

disp('Matrix A2:');
result_A2 = islinearlyindependent(dataMatrix2);
disp(result_A2);

disp('Matrix A3:');
result_A3 = islinearlyindependent(dataMatrix3);
disp(result_A3);

disp('Matrix A4:');
result_A4 = islinearlyindependent(dataMatrix4);
disp(result_A4);