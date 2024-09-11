function similarity_ratings = compareAdjacentGValues()
    
    subjectInitials = input('Enter your initials: ', 's');
    folderName = [subjectInitials '_BlueColorImages'];
    G_values = linspace(14, 254, 25); % Assuming G_save contains the G_values used
    R = 38/255; % These values are constants as per the provided example
    B = 203/255;

    % Generate pairs of indices for adjacent blocks
    pairs = [1:length(G_values)-1; 2:length(G_values)]';
    
    % Shuffle the order of pairs
    shuffledIndices = randperm(size(pairs, 1));
    shuffledPairs = pairs(shuffledIndices, :);

    % Initialize the similarity ratings array and G-values for pairs
    similarity_ratings = zeros(1, length(shuffledPairs));
    G_pairs_tested = zeros(size(shuffledPairs)); % To store the actual G values of the pairs tested

    % Loop through the shuffled G_values to compare adjacent values
    for ii = 1:length(shuffledPairs)
        figure;  % Create a new figure for each pair of adjacent color blocks
        
        idx1 = shuffledPairs(ii, 1);
        idx2 = shuffledPairs(ii, 2);

        % Record the G values of the pairs being tested
        G_pairs_tested(ii, 1) = G_values(idx1);
        G_pairs_tested(ii, 2) = G_values(idx2);

        % First color block
        subplot(1, 2, 1); % Display as subplots in the same figure
        G1 = G_values(idx1) / 255;
        color1 = [R, G1, B];
        patch([0 1 1 0], [0 0 1 1], color1);
        axis off;
        title(sprintf('Color Block A'));

        % Second color block
        subplot(1, 2, 2);
        G2 = G_values(idx2) / 255;
        color2 = [R, G2, B];
        patch([0 1 1 0], [0 0 1 1], color2);
        axis off;
        title(sprintf('Color Block B'));

        % Prompt user to rate the similarity
        prompt = sprintf('Rate the similarity between Block %d and Block %d (1=very dissimilar, 7=very similar): ', idx1, idx2);
        similarity_ratings(shuffledIndices(ii)) = input(prompt);

        % Optionally, save the figure if needed
        filename = sprintf('%s/Comparison_Block%d_and_%d.png', folderName, idx1, idx2);
        saveas(gcf, filename);
        close(gcf); % Close the figure
    end

    % Save the similarity ratings and G-values for the pairs tested
    save([folderName '/' subjectInitials '_similarity.mat'], 'similarity_ratings', 'G_pairs_tested');

end
