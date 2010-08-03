% replace.m  Replaces old with new population 
%    newPopulation = replace (population, offsprings)
%
%    @param cell array of float vectors, population: curent population
%    @param cell array of float vectors, offsprings: offsprings
%    @return cell array of float vectors, newPopulation: the new population 
%
%    Uses random insertion 


function  rNewPop = replace (aPop, aOffs)

  nInd = size(aPop, 1); % total number of individuals
  nOff = size(aOffs, 1); % number of offsprings to insert
  nRem = nInd - nOff;   % number from old population to insert
  
  rNewPop = cell(nInd, 1);

  %% get random vector
  permInd = randperm(nInd);
  permIndRem = permInd(1:nRem);

  %% insert into rNewPop
  i = 1;
  while i <= nOff,
    rNewPop{i} = aOffs{i};
    i = i + 1;
  end

  j = 1; 
  while i <= nInd
    rNewPop{i} = aPop{permIndRem(j)};
    i = i + 1;
    j = j + 1;
  end
  
end


