A = [1,4,1,2; 0,1,3,-4;0,2,6,7;2,9,5,-7];
R = rref(A);
A(4,:) = A(4,:) - 2 * A(1,:);
A(3,:) = A(3,:) - 2 * A(2,:);
A(4,:) = A(4,:) - A(2,:);
A(4,:) = (-1/7) * A(4,:);
A(3,:) = A(3,:) - 15 * A(4,:);
A(2,:) = A(2,:) + 4 * A(4,:);
A(1,:) = A(1,:) - 2 * A(4,:);
A(1,:) = A(1,:) - 4 * A(2,:);
A([3, 4], :) = A([4, 3], :);

disp('Reduced Row Echelon Form rref()');
disp(R);
disp('Reduced Row Echelon Form using Elementary row operations:');
disp(A);