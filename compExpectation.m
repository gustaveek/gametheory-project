%compExpectation.m Computes number of offspring expectation values
%    expectation = compExpectation ( rankedOrder, fitness );
%
%    @param vector of int rankedOrder: indices into population with ordered individuals
%    @param vector float fitness: fitness of individuals in population

% aOrder: contains the index-ordering of individuals with highest fitness
% aFitness: contains fitness of individuals in population order
% aParam: the params, man!

function rExp = compExpectation ( aOrder, aFitness, aParam )

expectedValue = zeros(aParam.nIndividuals,1);
for i = 1:aParam.nIndividuals
    
    expectedValue(i) = aParam.nParents*(1-aParam.selectionPressure)/...
        (1 - aParam.selectionPressure ^ aParam.nIndividuals)*...
        aParam.selectionPressure ^ ( aOrder(i) - 1 );
    
end

rExp = expectedValue;


end

