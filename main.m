% main. Main script for game theory project.
%   main
%
%   Main parameters
%
%   Main datastructures
%
clc; clear;

% main parameters
nIndividuals = 4;
param = ...
    struct( ...
    'nIndividuals', nIndividuals, ... % population size
    'nParents', round(nIndividuals/1.6), ...
    'selectionPressure', 0.5, ...
    'nGenerations', 0, ...
    'pMutSwitch', 0, ...
    'pMutSplit', 0, ...
    'pMutDuplicate', 0.0, 'pMutFloat', 0.0, 'pError', 0.0,...
    'payoffCC', 3, 'payoffCD', 0, 'payoffDC', 5, 'payoffDD', 1);

% main data structures

% population cell array:
% each element in the cell array contais a row vector that is the individual's chromosome. The lenth L of the chromosome varies, but disides the individuals memory size M.
%
%    L = 2^M
%
% M is non-negative integer.
population = cell(param.nIndividuals, 1);

newPopulation = cell(param.nIndividuals, 1); % exactly as population
fitness = zeros(param.nIndividuals, 1);  % straight w r t population
rankOrder = zeros(param.nIndividuals, 1);% crossed indecis into population
expectation = zeros(param.nIndividuals, 1); % straight values w r t rankOrder
parents = zeros(param.nParents, 1);   % indices into population
inserted = zeros (param.nParents, 1); % indices into newPopulation

% statistic data
bestIndividual = zeros (param.nGenerations, 1);

% begin. Initialize
population = initializePopulation(param);

% for number of generations
for iGen=1:param.nGenerations,
    
    fitness = evaluatePopulation (population, param);
    
    % rank and selection
    [temp, rankedOrder] = sort (fitness, 1, 'descend');
    expectation = compExpectation ( rankedOrder, fitness, param );
    
    % sample
    parents = sample (rankedOrder, expectation, param);
    
    % replacement
    [newPopulation, inserted] = replace (population, parents);
    
    % mutation
    newPopulation = mutate (newPopulation, inserted, param);
    
    % relevant statistics
    
    
    % generation shift
    population = newPopulation;
    
end
