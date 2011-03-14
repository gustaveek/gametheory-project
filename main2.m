% main.m Main script for game theory project.
%   main

clc; clear;

%% main parameters
nIndividuals = 100;
param = ...
    struct( ...
    'nIndividuals', nIndividuals, ... % population size
    'nParents', round(nIndividuals*0.4), ...
    'selectionPressure', 0.1, ...
    'selectionMethod', 'fitnessproportional', ... % or 'exponential'
    'nGenerations', 10000, ...
    'pMutSwitch', 0.0001, ...
    'pMutSplit', 0.0001, ...
    'pMutDuplicate', 0.0001, ...
    'mutFloatLength', 0.05, ...
    'pMutFloat', 0.0001, ...
    'pError', 0.01,...
    'payoffCC', 3, ...
    'payoffDC', 5, ...
    'payoffCD', 0, ...
    'payoffDD', 1);

%% Sweeping parameters
pMut = ones (1, 35) * 5e-4;
nPar = ones (1, 35) * round (nIndividuals * 2e-1);
pErr = ones (1, 35) * 0.01;

pMut(1:5) = 1e-4;
pMut(11:15) = 1e-3;
nPar(16:20) = round (nIndividuals * 1e-1);
nPar(26:30) = round (nIndividuals * 4e-1);

pErr(31:35) = 0;

for i = 1:length(pMut)
    param.pMutFloat = pMut(i);
    param.pMutSwitch = pMut(i);
    param.pMutDuplicate = 0.1*pMut(i);
    param.pMutSplit = 0.1*pMut(i);
    
    param.nParents = nPar(i);
    param.pError  = pErr(i);
        
    disp('Runns with:')
    disp(param);
    [dataPop dataDist dataStrategies dataPercentOfEachStrategy]= mainLoop2 (param);
    
    strategyOccuransMatrix=zeros(param.nGenerations,length(dataPercentOfEachStrategy{param.nGenerations}));
    
    for j=1:param.nGenerations
        for k=1:length(dataPercentOfEachStrategy{j})
            strategyOccuransMatrix(j,k)=dataPercentOfEachStrategy{j}(k);
        end
    end
    
    filename = sprintf ('data-2010-08-03-no%.3d.mat', i);
    save (filename, 'param', 'dataPop', 'dataDist', 'dataStrategies', 'dataPercentOfEachStrategy', 'strategyOccuransMatrix');

end
