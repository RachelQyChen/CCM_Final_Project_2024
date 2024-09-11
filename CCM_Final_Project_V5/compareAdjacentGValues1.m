function similarity_ratings = compareAdjacentGValues()
    
    subjectInitials = input('Enter your initials: ', 's');
    folderName = [subjectInitials '_BlueColorImages'];
    G_values = linspace(14, 254, 25); % Assuming G_save contains the G_values used
    R = 38/255; % These values are constants as per the provided example
    B = 203/255;
    

    % Initialize the similarity ratings array
    similarity_ratings = zeros(1, length(G_values) - 1);

    % Loop through the G_values to compare adjacent values
    for ii = 1:length(G_values) - 1
        figure;  % Create a new figure for each pair of adjacent color blocks

        % First color block
        subplot(1, 2, 1); % Display as subplots in the same figure
        G1 = G_values(ii) / 255;
        color1 = [R, G1, B];
        patch([0 1 1 0], [0 0 1 1], color1);
        axis off;
        title(sprintf('Color Block %d', ii));

        % Second color block
        subplot(1, 2, 2);
        G2 = G_values(ii + 1) / 255;
        color2 = [R, G2, B];
        patch([0 1 1 0], [0 0 1 1], color2);
        axis off;
        title(sprintf('Color Block %d: G=%.2f', ii + 1, G_values(ii + 1)));

        % Prompt user to rate the similarity
        prompt = sprintf('Rate the similarity between Block %d and Block %d (1=very dissimilar, 7=very similar): ', ii, ii + 1);
        similarity_ratings(ii) = input(prompt);

        % Optionally, save the figure if needed
        filename = sprintf('%s/Comparison_Block%d_and_%d.png', folderName, ii, ii + 1);
        saveas(gcf, filename);
        close(gcf); % Close the figure
    end
    save([folderName '/' subjectInitials '_similarity.mat'], 'similarity_ratings');

end

