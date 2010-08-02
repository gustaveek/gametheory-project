% statistics.m Collects statistics over the population.
%      stats = statistics (genNum, poulation, stats, param)
%
%      @param int, genNum: generation number
%
%      @param cell array of float row vectors, population: the current
%             population.
%
%      @param struct of different kinds, stats: statistical data
%             and parameters.
%
%      @param struct of different kinds, param: the main parameter struct.
%
%      @param struct, stats: the same argument struct
%
%      What is measured is 1) cooperation tendency distribution. 
%
%      1) Consider the two least significat srategy bits, those that 
%      concerns the opponent last action. The cooperation tendency 
%      distibution is the distribution of strategies among the population 
%      regarding those two, and the measure is performed once for evvery 
%      call.
%
%           gen 1 distribution regarding opponents action D
%           gen 1 distribution regarding opponents action c
%           gen 2 distribution regarding opponents action D
%           etc.

% not att all ready
function rStats = staistics (aGenNum, aPop, aStats, aParam)

  %% collect parameters
  nInd = aParam.nIndividuals;

  %% 1) cooperation tendency distribution
  genomes = zeros(nInd, 2); % extracted least significat bits
  for i = 1:nInd,
    genomes(i, 1:2) = memOne (aPop{i});

  end
  


end

% Returns the two least significat genome bits. 
function rGeno = memOne (aInd)
  rGeno = zeros(1, 2);
  % Not at all ready

end