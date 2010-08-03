% driverCompExpectation.m Driver script for compExpectation.m


param = ...
    struct('nIndividuals', 20, ...
	   'nParents', 15, ...
	   'selectionMethod', 'exponential', ...
	   'selectionPressure', 0.1);
isOk = 1;
prec = 3.5e-15;

%% check that sum of expectation is nParents
for i = 1:8
  if (i > 4) param.selectionMethod = 'fitprop'; end

  fitness = rand(param.nIndividuals, 1);
  [temp, rankedOrder] = sort (fitness, 1, 'descend');
  expectation = compExpectation(rankedOrder, fitness, param);

  expSum = sum(expectation, 1); 
  disp (['Test ' num2str(i) ': expSum = ' num2str(expSum)]);
  disp ('fitness, temp, rankedOrder, expectation');
  disp ([ fitness, temp, rankedOrder, expectation]);
  if (abs(expSum - param.nParents) > prec)
    isOk = 0;
    disp (['diff = ' num2str(abs(expSum - param.nParents))]);
  end

end

if isOk
  display('Test OK.')
else
  display('Test not OK.')
end






  

