% main. Main script for game theory project.
%   main
%
%   Main parameters
%
%   Main datastructures
%
clc; clear;


%% main parameters
nIndividuals = 16;
param = ...
    struct( ...
	   'nIndividuals', nIndividuals, ... % population size
	   'nParents', round(nIndividuals/1.6), ...
	   'selectionPressure', 0.1, ...
	   'selectionMethod', 'exponential', ... % or 'fitprop'
	   'nGenerations', 10, ...
	   'pMutSwitch', 0.05, ...
	   'pMutSplit', 0.025, ...
	   'pMutDuplicate', 0.8, ...
	   'mutFloatLength', 0.05, ...
	   'pMutFloat', 0.05, ...
	   'pError', 0.05,...
	   'payoffCC', 3, ...
	   'payoffCD', 0, ...
	   'payoffDC', 5, ...
	   'payoffDD', 1);
				% main data structures

% population cell array:
% each element in the cell array contais a row vector that is the individual's chromosome. The lenth L of the chromosome varies, but disides the individuals memory size M.
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

bestIndividual = zeros (param.nGenerations, 1); % statistic data


%% begin. Initialize
population = initializePopulation(param);


%% for number of generations
for iGen=1:param.nGenerations,
    
    fitness = evaluatePopulation (population, param);
    
    %% rank and selection
    [temp, rankedOrder] = sort (fitness, 1, 'descend');
    expectation = compExpectation ( rankedOrder, fitness, param );
    
    %% sample
    offsprings = sample (population, rankedOrder, expectation, param);
    
    %% mutation
    offsprings =  mutate (offsprings, param); % OBS! check this syntax
    
    %% replacement, that is generation shift
    population = replace (population, offsprings);
    
    %% relevant statistics
    
end

% for i= 1:size(population, 1)
%     disp(population{i})
% end