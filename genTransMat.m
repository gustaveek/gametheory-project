% genTransMat.m Returns transision matrix given a state table.
% matrix = genTransMat (table, param)
%
%    @param N x 2 float matrix: table
%    @param main parameter struct: param
%    @return N x N float matrix: matrix
%
% The transition matrix contains the transition probabilities between
% state J and I in the state table. N is number of possible history 
% states.
%
% This function can not yet handle noise and will exit with an error 
% message.

function rMat = genTransMat (aTab, aParam)

  % find dimension and simmilar operations
  dim = size (aTab, 1);
  blockLevs = log2 (dim) / 2;
  if (blockLevs ~= floor (blockLevs))
    error ('Block level error.')
  end
  prob = aParam.pError;
  prob4 = prob * prob;
  prob3 = (1 - prob) * prob;
  prob1 = (1 - prob) * (1 - prob);

  % FIX so that the function can coope with errors. 
  if (prob ~= 0.0)
    error('Noise level not zero.');
  end
  
  % initilize empty matrix
  rMat = zeros (dim);
  xMeas = zeros(1, blockLevs);
  yMeas = zeros(1, blockLevs);

  % start operate
  for iTo = 1:dim

    % generate measure x
    for s = 1:blockLevs
      xMeas(s) = 1 + rem (floor ((iTo - 1)/4^(s-1)), 4);
    end

    % for all jFrom
    for yS = [1:4]

      % get measure y
      for s = 1:blockLevs - 1
	yMeas(s) = xMeas(s + 1);
      end
      yMeas(blockLevs) = yS;

      % get jFrom
      jFrom =  1;
      for s = 1:blockLevs
	jFrom = jFrom + (yMeas(s) - 1) * 4^(s-1);
      end
      
      % generate element in rMat
      factorA = aTab(jFrom, 1);
      if (xMeas(1) == 1 || xMeas(1) == 2)
	factorA = 1 - aTab(jFrom, 1);
      end
      factorB = aTab(jFrom, 2);	
      if (xMeas(1) == 1 || xMeas(1) == 3)
	factorB = 1 - aTab(jFrom, 2);
      end

      rMat(iTo, jFrom) = ...
	  factorA * factorB * prob1 + ...
	  factorA * (1 - factorB) * prob3 + ...
	  (1 - factorA) * factorB * prob3 + ...
	  (1 - factorB) * (1 - factorB) * prob4;

    end % for all jForm
  end % for all iTo
  
return 



   
  
