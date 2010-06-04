% mainLoop.m Main function for game theory project.
%     returnData = main (param)
%
%     @param struct, param: main parameters
%
%     @return cell array nGen x 1, rPop: all populations
%
%     @return nGen x 4 floats, rDist: outcome distribution in every
%             generation of the fom [P(dd) P(dc) P(cd) P(cc)]. 
%
% Performes simulation and the resulting data. P(dc) will allways 
% equals  P(cd) I belevve /Gustav. 

function [rPop, rDist] = mainLoop (aParam)

  % population cell array:
  % each element in the cell array contais a row vector that is the individual's chromosome. The lenth L of the chromosome varies, but decides the individuals memory size M.
  %
  %    L = 2^M
  %
  % M is non-negative integer.

  %% Data structures
  population = cell(aParam.nIndividuals, 1); % major population cell array
  offsprings = cell(aParam.nParents, 1); % generated offspring population

  fitness = zeros(aParam.nIndividuals, 1);  % straight w r t population
  rankOrder = zeros(aParam.nIndividuals, 1);% crossed indecis into population
  expectation = zeros(aParam.nIndividuals, 1); % straight values w r t rankOrder
  parents = zeros(aParam.nParents, 1);   % indices into population

  %% Statistical data and parameters
  rDist = zeros(aParam.nGenerations, 4); % in every gen, the outcome distribution dd, dc, cd, cc
  rPop  = cell(1, aParam.nGenerations);
  
  %% begin. Initialize
  population = initializePopulation(aParam);

  %% for number of generations
  for iGen=1:aParam.nGenerations,

    %% Evaluate population 
    [fitness, outcomeDist]= evaluatePopulation (population, aParam);
    
    %% rank and selection
				%[temp, rankedOrder] = sort (fitness, 1, 'descend');
    expectation = compExpectation ( fitness, aParam );
    
    %% sample
    offsprings = sample (population, expectation, aParam);
    
    %% mutation
    offsprings =  mutate (offsprings, aParam); % NB! check this syntax
    
    %% replacement, that is generation shift
    population = replace (population, offsprings);
    
    %% relevant statistics
    %%    stat = statistics (population, stats, aParam);

    rPop{iGen} = population;
    rDist(iGen, :) = outcomeDist;

  end

end
