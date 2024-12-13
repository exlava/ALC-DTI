
cd '/home/ozgun/AnV/Alcohol/Results/Braingraph/';

% Get matrix files
matFiles = dir('*matrix');

% loop over matrix files
for k = 1 : length(matFiles)

    mat = matFiles(k).name;

    % Load probtrackx results
    M = load(mat);

    subject = extractBefore(mat, '_fdt');
    
    % Load waytotal file
    W = load(strcat(subject, '_waytotal'));
    
    % Normalize matrix
    M_norm = M ./ repmat(W,1,length(W));
    
    % Save matrix
    writematrix(M_norm, subject)

end