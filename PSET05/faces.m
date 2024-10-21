%% Part (a) Load and display 15 face images
figure;
for i = 1:15
    fileID = fopen(['faces/' num2str(i) '.txt'], 'r');
    A = fscanf(fileID, '%f');
    fclose(fileID);
    imageMatrix = reshape(A, [195, 231]);
    subplot(3, 5, i);
    imshow(uint8(imageMatrix)');
    title(['Face Number: ' num2str(i)]);
end

%% Part b: Load all faces and find basis
numFaces = 100;
faceSize = 195 * 231;
F = zeros(faceSize, numFaces);

for i = 1:numFaces
    fileID = fopen(['faces/' num2str(i) '.txt'], 'r');
    F(:, i) = fscanf(fileID, '%f');
    fclose(fileID);
end

% had to customise the algo to this problem
B = []; 
for i = 1:numFaces
    v = F(:, i);
    if isempty(B)
        B = v;
    else
        M = [B v];
        if islinearlyindependent(M)
            B = [B v];
        end
    end
end

dimension = size(B, 2);
fprintf('The dimension of the dataset is %d.\n', dimension);

figure;
numBasisFaces = dimension;
rows = ceil(sqrt(numBasisFaces));
cols = ceil(numBasisFaces / rows);
for i = 1:numBasisFaces
    imageMatrix = reshape(B(:, i), [195, 231]);
    subplot(rows, cols, i);
    imshow(uint8(imageMatrix));
    title(['Basis face ' num2str(i)]);
end
sgtitle('Basis faces of the dataset');


%% part c: Emotion faces
emotions = {'happy', 'sad', 'excited'};
M = zeros(45045, 3);
for i = 1:3
    fileID = fopen(['facebasis/' emotions{i} '.txt'], 'r');
    M(:, i) = fscanf(fileID, '%f');
    fclose(fileID);
end

% disp emotion faces
figure;
for i = 1:3
    subplot(1, 3, i);
    imshow(uint8(reshape(M(:, i), [195, 231]))');
    title(emotions{i});
end

% check if M is linearly independent
if islinearlyindependent(M)
    disp('the emotion faces are L.I');
else
    disp('the emotion faces are LI.');
end
% check if they form a basis for the dataset
if size(M, 2) == dimension
    disp('the emotion faces form a basis for the dataset.');
else
    disp('the emotion faces do not form a basis for the dataset.');
end


%% Part d: Faces that can be reppresented by the emotion faces

repped = [];
notrepped = [];

for i = 1:num_faces
    v = faces_matrix(:, i);
    % try to solve M * c = v
    c = M \ v;  % <----- least squares solution
    residual = norm(M * c - v);
    relative_residual = residual / norm(v);
    if relative_residual < 0.01  % <----- threshold 
        repped = [repped, i];
    else
        notrepped = [notrepped, i];
    end
end

fprintf('number of faces that can be represented: %d\n', length(repped));
fprintf('number of faces that cannot be represented: %d\n', length(notrepped));


%% Part (e): Display faces in and not in the span of emotion faces

% display 10 faces in the span
figure;
for i = 1:min(10, length(repped))
    idx = repped(i);
    subplot(2, 5, i);
    imshow(uint8(reshape(faces_matrix(:, idx), [195, 231]))');
    title(sprintf('In Span %d', idx));
end

% disp 10 faces not in span
figure;
for i = 1:min(10, length(notrepped))
    idx = notrepped(i);
    subplot(2, 5, i);
    imshow(uint8(reshape(faces_matrix(:, idx), [195, 231]))');
    title(sprintf('Not In Span %d', idx));
end