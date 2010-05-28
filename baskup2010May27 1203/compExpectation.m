% compExpectation.m Computes number of offspring expectation values
%    expectation = compExpectation ( rankedOrder, fitness, param );
%
%    @param int vector N x 1, order: contains the index-ordering of
%           individuals with highest fitness. That is crossed indexis 
%           into population
%
%    @param float vector N x 1, fitness: contains fitness of 
%           individuals in population order, tahat is straight into
%           population
%
%    @param struct, param: params, man!
%
%    Generates expectation value of number of offsprings of all
%    individuals in the population. Parameters:
%
%    param.selectionMethod = 'exponential' means exponential ranking 
%    with regard to rankedOrder and param.selectionPressure.
%
%    param.selectionMethod = 'fitprop' takes number of offspring
%    expectation to be proportional to fitness.


function rExp = compExpectation ( aOrder, aFitness, aParam )


  %% expectation exponential to ranking 
  if (aParam.selectionMethod(1) == 'e') 

    expectedValue = zeros(aParam.nIndividuals,1);   
    for i = 1:aParam.nIndividuals
      
      expectedValue(i) = aParam.nParents*(1-aParam.selectionPressure)/...
          (1 - aParam.selectionPressure ^ aParam.nIndividuals)*...
          aParam.selectionPressure ^ ( aOrder(i) - 1 );
      
    end

    rExp = expectedValue;

  %% expectation proportionate to fittness
  elseif (aParam.selectionMethod(1) == 'f')
    aFitness = aFitness ./ sum(aFitness); % normalisasion 
    rExp = aFitness * aParam.nParents; % proportional expectation 

  else
    error('No such method exists');
  end
end

