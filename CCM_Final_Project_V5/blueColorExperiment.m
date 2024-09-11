
function blueColorExperiment()
subjectInitials = input('Enter your initials: ', 's');%evalin('base', 'subjectInitials');
finalGVarName = [subjectInitials '_finalG'];
% Folder to save images
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


% Initialize response array
response1 = zeros(1, length(G_values));
response2 = zeros(1, length(G_values));

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

    % Prompt user to judge if the color is blue
    resp1 = input('Is this color blue or turquoise? Enter 1 for blue, 2 for turquoise: ');
    response1(ii) = resp1;

    % Ask different follow-up questions based on the user's input
    if resp1 == 1
        resp2 = input('How well is this color a representative of the blue? Rate from 1 (very bad) to 7 (very good): ');
    else
        resp2 = input('How well is this color a representative of the turquoise? Rate from 1 (very bad) to 7 (very good): ');
    end
    response2(ii) = resp2;

    % Save image to local files within the specified folder
    filename = sprintf('%s/color brick%d.png', folderName, ii);
    saveas(gcf, filename);
    close;
end

%Save final values and responses to a .mat file
save([folderName '/' subjectInitials '_data.mat'], 'G_save', 'response1','response2');
fprintf('All images and responses saved in %s, ready to go!\n', folderName);
end
