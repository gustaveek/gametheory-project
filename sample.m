% sample.m Finds parents. The SUS way!
%   offsprings = sample (population, rankedOrder, expectation,
%                         param);
%
%   @param cell array of integer vectors population: population
%          cell array
%
%    @param vector of int rankedOrder: indicied into population cell
%           array (previous parameter).
%
%    @param vector of floats expectation: expectation value
%           corresponding to rankedOrder.
%
%    @param struct param: the main parameter struct
%
%    @return cell array of integer vectors offsprings: genrated offsprings
%
%    Finds indices into the population cell array. These are the indices
%    that will be inserted into the new population. The same parent can
%    occur many times. Finally the cell array off offsprings is generated
%    and returned.

function  rOffs = sample (aPop, aOrder, aExp, aParam)

%% Assuming the start value is in [0,1] (reason for rand and +index below)
startingPoint = rand;
parentsToOccur = zeros(aParam.nParents,1);
index = 1;
sumExp = 0;
for i = 1:length(aOrder)
    
    sumExp = sumExp + aExp(aOrder(i));
    while sumExp > (startingPoint + index - 1)
        parentsToOccur(index) = aOrder(i);
        index = index + 1;
    end
    
end

if length(parentsToOccur) ~= aParam.nParents
    disp('Family planning failed.')
end

%% parentsToOccur are the indexis into aPop
rOffs = cell(aParam.nParents, 1);
for i = 1:aParam.nParents
    rOffs{i} = aPop{parentsToOccur(i)};
end

end



