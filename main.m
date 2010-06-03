% main. Main script for game theory project.
%   main
%
%   Main parameters
%
%   Main datastructures
%
clc; clear;


%% main parameters
nIndividuals = 100;
param = ...
    struct( ...
	   'nIndividuals', nIndividuals, ... % population size
	   'nParents', round(nIndividuals*0.4), ...
	   'selectionPressure', 0.1, ...
       'selectionMethod', 'fitnessproportional', ... % or 'exponential'
	   'nGenerations', 100000, ...
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
				% main data structures

% population cell array:
% each element in the cell array contais a row vector that is the individual's chromosome. The lenth L of the chromosome varies, but decides the individuals memory size M.
%
%    L = 2^M
%
% M is non-negative integer.
population = cell(param.nIndividuals, 1); % major population cell array
offsprings = cell(param.nParents, 1); % generated offspring population

fitness = zeros(param.nIndividuals, 1);  % straight w r t population
rankOrder = zeros(param.nIndividuals, 1);% crossed indecis into population
expectation = zeros(param.nIndividuals, 1); % straight values w r t rankOrder
parents = zeros(param.nParents, 1);   % indices into population

%% Statistical data and parameters
statDist = zeros (param.nGenerations, 4); % in every gen, the outcome distribution dd, dc, cd, cc
sparas = cell(1, param.nGenerations);
				       
%% begin. Initialize
population = initializePopulation(param);

%% for number of generations
for iGen=1:param.nGenerations,
    tic

    %% Evaluate population 
    [fitness, outcomeDist]= evaluatePopulation (population, param);
    
    %% rank and selection
    %[temp, rankedOrder] = sort (fitness, 1, 'descend');
    expectation = compExpectation ( fitness, param );
    
    %% sample
    offsprings = sample (population, expectation, param);
    
    %% mutation
    offsprings =  mutate (offsprings, param); % NB! check this syntax
    
    %% replacement, that is generation shift
    population = replace (population, offsprings);
    
    %% relevant statistics
    %%    stat = statistics (population, stats, param);

    sparas{iGen}=population;
    statDist(iGen, :) = outcomeDist;

    %% save every 100 iteration
    if rem(iGen, 100) == 0
      save data100000;
    end

    toc
end
