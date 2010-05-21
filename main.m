% main. Main script for game theory project.
%   main
%
%   Main parameters
%
%   Main datasturctures
% 

% main parameters 
param = ...
    struct( ...
	   'nIndividuals', 0, ... % population size
	   'nOffsprings', nIndividuals, ...
	   'nGenerations, 0 ...
	   'pMutSwitch', 0.0,... % prob for switch mutation
	   'pMutSplit', 0.0,...
	   'pMutDuplicate', 0.0, 'pMutFloat', 0.0, 'pError', 0.0);

% main data structures

% population cell array:
% each element in the cell array contais a row vector that is the individual's chromosome. The lenth L of the chromosome varies, but disides the individuals memory size M.
% 
%    L = 2^M 
%
% M is non-negative integer.
population = cell(param.nIndiviuals, 1);

newPopulation = cell(param.nIndividuals, 1); % exactly as population
fitness = zeros(param.nIndividuals, 1);  % straight w r t population
rankOrder = zeros(param.nIndividuals, 1);% crossed indecis into population
expectation = zeros(param,nIndividuals, 1); % straight values w r t rankOrder
parents = zeros(param.nOffsprings, 1);   % indices into population 
inserted = zeros (param.nOffsprings, 1); % indices into newPopulation

% statistic data
bestIndividual = zeros (param.nGenerations, 1);

% begin. Initialize 
population = initializePopulation(param);

% for number of generations 
for iGen=1:param.nGenerations,

  fitness = evaluatePopulation (population, param);

  % rank and selection
  [temp, rankedOrder] = sort (fitness, 1, 'decend');
  expectation = compExpectation ( rankedOrder, fitness );

  % sample
  parents = sample (rankedOrder, expectation);

  % replacement
  [newPopulation, inserted] = replace (population, parents); 

  % mutation
  newPopulation = mutate (newPopulation, inserted, param); 
  
  % relevant statistics
  

  % generation shift
  population = newPopulation

end





  
  

% 





		    



