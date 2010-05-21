% genTransMat.m Returns transision matrix given a state table.
% matrix = genTransMat (table, param)
%
%    @param N x 2 float matrix: table
%    @param main parameter struct: param
%    @return N x N float matrix: matrix
%
% The transition matrix contains the transition probabilities between
% state I and J in the state table. N is number of possible history 
% states.

function rMat = genTransMat (aTab, aParam)

  % find dimension and simmilar operations
  dim = size (aTab, 1);
  prob = aParam.pError;
  prob4 = prob * prob;
  prob3 = (1 - prob) * prob;
  prob1 = (1 - prob) * (1 - prob);

  rMat = zeros (dim);

  if (dim == 4)
    for i = 1:dim
      for j = 1:dim
	if (j == 1 || j == 2)
	  term1 = 1 - aTab(i, 1);
	else
	  term1 = aTab(i, 1);
	end
	if (j == 1 || j == 3)
	  term2 = 1 - aTab(i, 2);
	else
	  term2 = aTab(i, 2);
	end
	rMat(i, j) = ...
	    term1 * term2 * prob1 + ...
	    term1 * (1 - term2) * prob3 + ...
	    (1 - term1) * term2 * prob3 + ...
	    (1 - term1) * (1 - term2) * prob4;
      end % loop over j
    end % loop over i

  elseif (dim == 16)
    for i = 1:dim
      for j = 1:dim

	% calculate helping measures
        x = 1 + rem (j - 1, 4); % row within block of four
	y = 1 + rem (i - 1, 4); % column within block of four
	z = floor ( (j - 1) / 4 ); % block number, row wise

	if (z == y)
	  if (x == 1 || x == 2)
	    term1 = 1 - aTab(i, 1);
	  else
	    term1 = aTab(i, 1);
	  end
	  if (x == 1 || x == 3)
	    term2 = 1 - aTab(i, 2);
	  else
	    term2 = aTab(i, 2);
	  end
	  rMat(i, j) = ...
	      term1 * term2 * prob1 + ...
	      term1 * (1 - term2) * prob3 + ...
	      (1 - term1) * term2 * prob3 + ...
	      (1 - term1) * (1 - term2) * prob4;
	else
	  rMat(i, j) = 0;
	end
      end % loop over j
    end % loop over i

  else % DEBUG
    error ('genTransMat 1', 'Table dimension error.');
  end
  
return 



   
  
