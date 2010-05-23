% sample.m Finds parents. The SUS way!
%    parents = sample (rankedOrder, expectation);
%
%    @param vector of int rankedOrder: indicied into population cell array.
%    @param vector of floats expectation: expectation value corresponding to rankedOrder.
%    @return vector of int parents: indexies into population cell array.
%
%    Finds indices into the population cell array. These are the indices
%    that will be inserted into the new population. The same parent can occur many times.

function  rPar = sample (aOrder, aExp, aParam)

% Assuming the start value is in [0,1] (reason for rand and +index below)
startingPoint = rand;
parentsToOccur = zeros(aParam.nParents,1);
index = 0;
sumExp = 0;
for i = 1:length(aOrder)
    
    sumExp = sumExp + aExp(aOrder(i));
    while sumExp > (startingPoint + index - 1)
        index = index + 1;
        parentsToOccur(index) = aOrder(i);
    end
    
end

if index ~= aParam.nParents
    disp('Family planning failed.')
end

rPar = parentsToOccur;

end
