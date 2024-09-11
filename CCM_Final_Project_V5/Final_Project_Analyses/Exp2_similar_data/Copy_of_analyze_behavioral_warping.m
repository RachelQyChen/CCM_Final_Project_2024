% Data analyses for CCM final project
% Helen Hu (fh986@nyu.edu)

clear all;
% close all;
clc;


mydir = '/Users/helenhu/Desktop/CCM_Final_Project_Analyses/Final_Project_Analyses/Exp2_similar_data';

d = dir(sprintf('%s/*.mat',mydir));
    
files = {d.name};

compare_categories = 14:10:244;

numSubj = length(files);
subj_rating = NaN(numSubj,24);

for subj = 1:length(files)

    load(cell2mat(files(subj)));

    current_ratings = similarity_ratings;
    for ii = 1:length(current_ratings)
        r = current_ratings(ii);
        if r == 1
            current_ratings(ii) = 7;
        elseif r == 2
            current_ratings(ii) = 6;
        elseif r == 3
            current_ratings(ii) = 5;
        elseif r == 5
            current_ratings(ii) = 3;
        elseif r == 6
            current_ratings(ii) = 2;
        elseif r == 7
            current_ratings(ii) = 1;
        end
    end

    subj_rating(subj,:) = current_ratings;

end

avg_rating = mean(subj_rating,1);


avg_across_colors = mean(avg_rating);
median_across_colors = median(avg_rating);


%% model


G_values = 14:10:254;

sigma_c = 50; 
sigma_s = 55; 
mu1 = 124;
mu2 = 254;

g = (mu1-mu2)/(sigma_c^2 + sigma_s^2);
b = (mu1.^2-mu2.^2)/2/(sigma_c^2 + sigma_s^2);

pc_s = NaN(1,length(G_values));

for ii = 1:length(G_values)

    S = G_values(ii);
    pc_s(ii) = 1/(1+exp(-g*S+b)); % model from Feldman & Griffins (2007)
    
end


sigma_cs = sigma_c^2 + sigma_s^2;

ET_S = (sigma_c^2/sigma_cs).*G_values + (sigma_s^2/sigma_cs) * (mu1 * pc_s + mu2 * (1-pc_s));

E_rating = diff(ET_S);
E_rating_normalized = E_rating./max(E_rating);
E_rating_predict = E_rating_normalized*7-2.6;

figure;
hold on;
plot(G_values(1:24),avg_rating,'o-','LineWidth',2);
plot(G_values(1:24), E_rating_predict,'d-', 'LineWidth', 2);
hold off;
xlabel('G Values');
ylabel('Perceived Difference Rating');
title('Effect of G Values on Perceived Difference')
set(gca,'FontSize',18)
% xlim([114 254])
ylim([0 7])
legend('Behavioral Data','Model Simulation')
% yline(avg_across_colors,'LineWidth',2)

