% main.m Main script for game theory project.
%   main

clc; clear;


%% main parameters
nIndividuals = 40;
param = ...
    struct( ...
	   'nIndividuals', nIndividuals, ... % population size
	   'nParents', round(nIndividuals*0.4), ...
	   'selectionPressure', 0.1, ...
       'selectionMethod', 'fitnessproportional', ... % or 'exponential'
	   'nGenerations', 40, ...
	   'pMutSwitch', 0.001, ...
	   'pMutSplit', 0.001, ...
	   'pMutDuplicate', 0.001, ...
	   'mutFloatLength', 0.05, ...
	   'pMutFloat', 0.001, ...
	   'pError', 0.01,...
	   'payoffCC', 3, ...
	   'payoffDC', 5, ...
	   'payoffCD', 0, ...
	   'payoffDD', 1);

%% Sweeping parameters
pMutFloats = [0.01]% , 0.05, 0.1];

for i = 1:length(pMutFloats)
  tic
  param.pMutFloat = pMutFloats(i);
  disp('Runns with:')
  disp(param);
  [dataPop{i}, dataDist{i} dataStrategies{i} dataPercentOfEachStrategy{i}]= mainLoop2 (param);
  dataParam{i} = param;
  save data3.mat dataPop dataDist dataParam
  toc
end
%length(dataPercentOfEachStrategy{1}{param.nGenerations});
%dataPercentOfEachStrategy{1};
%dataPercentOfEachStrategy{1}{param.nGenerations};
strategyOccuransMatrix=zeros(param.nGenerations,length(dataPercentOfEachStrategy{1}{param.nGenerations}));

for j=1:param.nGenerations
    for k=1:length(dataPercentOfEachStrategy{1}{j})
        strategyOccuransMatrix(j,k)=dataPercentOfEachStrategy{1}{j}(k);
    end
end

area(strategyOccuransMatrix)
