function blueColorExperimentRemote()
    % Prompt user to manually input their initials
    subjectInitials = input('Enter your initials: ', 's');
    % Define the folder to save images
    folderName = [subjectInitials '_BlueColorImages'];
    if ~exist(folderName, 'dir')
        mkdir(folderName);  % Create the folder if it does not exist
    end


    G_values = linspace(14, 254, 25);
    R = 38/255;
    B = 203/255;
    
    G_sequence = 1:length(G_values);
    G_sequence = randperm(length(G_sequence));
    G_save = nan(size(G_sequence));
    

    % Loop generation and save figures
    for ii = 1:length(G_values)
        % Create figures
        figure;
        G = G_values(G_sequence(ii))/255;
        G_save(ii) = G_values(G_sequence(ii));
        color = [R, G, B]; % RGB values
        patch([0 1 1 0], [0 0 1 1], color);
        axis off; 
        title(sprintf('Color Brick%d', ii));
        
        % Save image to local files within the specified folder
        filename = sprintf('%s/color brick%d.png', folderName, ii);
        saveas(gcf, filename);
        close; 
    end
    
    % Save final values to a .mat file
    save([folderName '/' subjectInitials '_data.mat'], 'G_save');
    fprintf('All images saved in %s, ready to go!\n', folderName);
end
