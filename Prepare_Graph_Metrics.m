% This script gathers results from GRETNE Matlab files, organizes and saves
% them ready to be imported to R



% Read covariates from Scripts folder
T = readtable('/home/ozgun/AnV/Alcohol/Scripts/Data/Covars.csv');

% Load results into Matlab
load('/home/ozgun/AnV/Alcohol/Results/Braingraph/NetworkEfficiency/NetworkEfficiency.mat','aEg');
load('/home/ozgun/AnV/Alcohol/Results/Braingraph/BetweennessCentrality/BetweennessCentrality.mat', 'aBc');
load('/home/ozgun/AnV/Alcohol/Results/Braingraph/NodalEfficiency/NodalEfficiency.mat', 'aNe');
load('/home/ozgun/AnV/Alcohol/Results/Braingraph/DegreeCentrality/DegreeCentrality.mat', 'aDc');

% Assign result names
EG = aEg;
N_BC = aBc;
N_EL = aNe;
N_DC = aDc;

vars = {'aEg','aBc','aNLe','aDc'};
clear(vars{:})
clear vars;


Tglobal = T;
% Global Metrics
G = {'EG'};
for i=1:length(G)
    Tglobal.(G{i}) = eval(G{i});
end
writetable(Tglobal,'/home/ozgun/AnV/Alcohol/Stats/Network/Global_Metrics.csv')

% Nodal Metrics
N = {'N_BC', 'N_EL', 'N_DC'};
for i=1:length(N)
    Tlocal = [T, array2table(eval(N{i}))];
    Tlocal.Properties.VariableNames = {'Subject','Group','lAMY','rAMY','lINS','rINS','lBNS','rBNS','lHIP','rHIP','lHYP','rHYP','lPFC','rPFC'};
    writetable(Tlocal, strcat('/home/ozgun/AnV/Alcohol/Stats/Network/',N{i},'.csv'))
end