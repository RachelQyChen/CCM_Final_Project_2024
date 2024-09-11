% Data analyses for CCM final project
% Helen Hu (fh986@nyu.edu)

clear all;
% close all;
clc;


mydir = '/Users/helenhu/Desktop/CCM_Final_Project_Analyses/Exp2_similar_data';

d = dir(sprintf('%s/*.mat',mydir));
    
files = {d.name};

compare_categories = 14:10:244;

numSubj = length(files);
subj_rating = NaN(numSubj,24);

for subj = 1:length(files)

    load(cell2mat(files(subj)));

    for ii = 1:length(G_pairs_tested)
        idx = find(G_pairs_tested(:,1) == compare_categories(ii));
        subj_rating(subj,ii) = similarity_ratings(idx);
    end

end

avg_rating = mean(subj_rating,1);

for ii = 1:length(avg_rating)
    r = avg_rating(ii);
    if r == 1
        avg_rating(ii) = 7;
    elseif r == 2
        avg_rating(ii) = 6;
    elseif r == 3
        avg_rating(ii) = 5;
    elseif r == 5
        avg_rating(ii) = 3;
    elseif r == 6
        avg_rating(ii) = 2;
    elseif r == 7
        avg_rating(ii) = 1;
    end
end

avg_across_colors = mean(avg_rating);
median_across_colors = median(avg_rating);

%%%%%%%%%%%%




G_values = 14:10:254;

sigma = 40;
sigma_c = sigma; 
sigma_s = sigma; 
mu1 = 124;
mu2 = 254;
constant = 10000/0.6*1.4;
constant2 = 3.25;


g = (mu1-mu2)/(sigma_c^2 + sigma_s^2);
b = (mu1.^2-mu2.^2)/2/(sigma_c^2 + sigma_s^2);

identification = NaN(1,length(G_values));

for ii = 1:length(G_values)

    S = G_values(ii);
    identification(ii) = 1/(1+exp(-g*S+b)); % model from Feldman & Griffins (2007)
    
end


sigma_cs = sigma_c^2 + sigma_s^2;


dpc_dS = g*identification.*(1-identification); %(g/2) * sech((g*G_values + b)/2).^2;
dET_dS = sigma_c^2/sigma_cs + constant*(sigma_s^2/sigma_cs) * ((mu1-mu2)/(2*sigma_cs)) * dpc_dS + constant2


%%%%%%%%%%%%

figure;
hold on;
plot(G_values(1:24)+5,avg_rating,'o-','LineWidth',2);
plot(G_values, dET_dS, 'LineWidth', 2);
hold off;
xlabel('G Values');
ylabel('Perceived Difference');
title('Effect of G Values on Perceived Difference')
set(gca,'FontSize',18)
xlim([114 254])
ylim([0 7])
% yline(avg_across_colors,'LineWidth',2)

