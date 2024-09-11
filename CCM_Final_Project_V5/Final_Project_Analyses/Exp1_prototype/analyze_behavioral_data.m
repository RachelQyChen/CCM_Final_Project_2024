% Data analyses for CCM final project
% Helen Hu (fh986@nyu.edu)

clear all;
close all;
clc;


mydir = '/Users/helenhu/Desktop/CCM_Final_Project_Analyses/Final_Project_Analyses/Exp1_prototype';

d = dir(sprintf('%s/*.mat',mydir));
    
files = {d.name};

G_values = linspace(14,254,25);

numSubj = length(files);
subj_response1 = NaN(numSubj,25);
subj_response2 = NaN(numSubj,25);

for subj = 1:length(files)

    load(cell2mat(files(subj)));

    for ii = 1:length(G_save)
        idx = find(G_save == G_values(ii));
        subj_response1(subj,ii) = response1(idx);
        subj_response2(subj,ii) = response2(idx); 
    end

end

subj_probBlue = subj_response1;
subj_probBlue(subj_probBlue == 2) = 0;
prob_blue = mean(subj_probBlue,1);

avg_goodness = NaN(1,size(subj_response2,2));

for cc = 1:size(subj_response2,2)
    subj_count = 0;
    sum_goodness = 0;
    for ss = 1:numSubj
        if subj_response1(ss,cc) == 1
            sum_goodness = sum_goodness + subj_response2(ss,cc);
            subj_count = subj_count + 1;
        end
    end
    avg_goodness(cc) = sum_goodness/subj_count;
end



subj_probGreen = subj_response1;
subj_probGreen(subj_probGreen == 1) = 0;
subj_probGreen(subj_probGreen == 2) = 1;
prob_Green = mean(subj_probGreen,1);

avg_goodness_green = NaN(1,size(subj_response2,2));

for cc = 1:size(subj_response2,2)
    subj_count = 0;
    sum_goodness = 0;
    for ss = 1:numSubj
        if subj_response1(ss,cc) == 2
            sum_goodness = sum_goodness + subj_response2(ss,cc);
            subj_count = subj_count + 1;
        end
    end
    avg_goodness_green(cc) = sum_goodness/subj_count;
end


%%
figure;
hold on;
plot(G_values,prob_blue,'o-','LineWidth',2);
plot(G_values,prob_Green,'o-','LineWidth',2,'Color',"#77AC30");
hold off;
xlabel('G Values');
ylabel('Possibility of Identification');
title('Effect of G Values on Identification')
set(gca,'FontSize',18)
xlim([14 254])
ylim([0 1])
legend('Identify as Blue','Identify as Green','Location','southwest');

figure;
hold on;
plot(G_values,avg_goodness,'o-','LineWidth',2);
plot(G_values,avg_goodness_green,'o-','LineWidth',2,'Color',"#77AC30");
hold off;
xlabel('G Values');
ylabel('Goodness Rating');
title('Effect of G Values on Goodness')
set(gca,'FontSize',18)
xlim([14 254])
ylim([0 7])
legend('Goodness of Blue','Goodness of Green','Location','southwest');

%% Bayesian model predictions

mu1 = 124; 
mu2 = 254;
sigma_sq_sum = 1500;%sigma1^2 + sigma2^2 


g = (mu1-mu2)/(sigma_sq_sum);
b = (mu1.^2-mu2.^2)/2/(sigma_sq_sum);

identification = NaN(size(prob_blue));

for ii = 1:length(G_values)

    S = G_values(ii);
    identification(ii) = 1/(1+exp(-g*S+b)); % model from Feldman & Griffins (2007)

end


figure;
hold on;
plot(G_values,prob_blue,'o-','LineWidth',2);
plot(G_values,identification,'r-','LineWidth',2)


xlabel('G Values');
ylabel('Possibility of Identification As Blue');
title('Effect of G Values on Identification')
set(gca,'FontSize',18)
xlim([14 254])
ylim([0 1])
legend('Data','Model')

